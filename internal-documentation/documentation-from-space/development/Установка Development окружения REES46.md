## Ключ авторизации

1. Генерируем SSH-ключ без пароля:

```bash
ssh-keygen
```

2. Выводим содержимое публичного ключа:

```bash
cat ~/.ssh/id_rsa.pub
```

3. Открываем настройки JetBrains Space: `Preferences -> Git Keys` и добавляем ключ.

4. Добавляем приватный ключ к SSH-агенту:

```bash
ssh-add -K ~/.ssh/id_rsa
```

---

## Установка зависимостей

### PostgreSQL 14

#### Ubuntu 18.04:

```bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && \
sudo apt update
```

#### Ubuntu 18.04–22.04:

```bash
sudo apt -y install postgresql-14 postgresql-client-14 libpq-dev
```

#### macOS:

```bash
brew install postgresql
createuser -s postgres
brew services start postgresql
```

Добавляем службу в автозапуск:

```bash
mkdir -p ~/Library/LaunchAgents && \
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents && \
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

Запускаем утилиту:

```bash
sudo -u postgres psql
```

Если `psql` и `createuser` недоступны:

```bash
echo 'export PATH=/opt/local/bin:/opt/local/sbin:$PATH' >> ~/.profile && source ~/.profile
```

Создаем юзера и даем права:

```sql
CREATE USER rees46 WITH ENCRYPTED PASSWORD 'rees46';
ALTER USER rees46 WITH SUPERUSER;
```

---

### Clickhouse 22.2 (macOS)

```bash
brew tap clickhouse/clickhouse && brew install clickhouse@22.2 && brew services restart clickhouse
```

---

### Обновление сертификатов

#### Ubuntu:

```bash
sudo apt install ca-certificates
```

#### macOS:

```bash
brew install ca-certificates
```

---

### Ruby (через RVM)

```bash
curl -sSL https://get.rvm.io | bash -s stable && source ~/.profile
```

Если возникает ошибка SSL:

```bash
curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
```

Устанавливаем Ruby 2.7.5:

```bash
rvm install 2.7.5
```

Устанавливаем `bundler`:

```bash
gem install bundler -v 1.17.3
```

#### macOS: ошибка `requirements_osx_brew_update_system`

```bash
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

---

### ImageMagick 6

#### Ubuntu:

```bash
sudo apt-get install -y imagemagick-6.q16 libmagickwand-dev
```

#### macOS:

```bash
brew install shared-mime-info imagemagick@6
```

---

### Node 16, NPM

#### Ubuntu:

```bash
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt -y install nodejs
node -v
```

#### macOS:

```bash
brew install node@16
node -v
```

---

## Настройка API проекта

```bash
mkdir ~/Projects && cd ~/Projects
git clone ssh://git@git.jetbrains.space/rees46/dev/api-rails.git && cd api-rails
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
```

Редактируем `config/database.yml`:

```yaml
development_clickhouse:
  <<: *default_clickhouse
#  <<: *default_clickhouse_pg
```

Добавляем в `/etc/hosts`:

```bash
sudo bash -c "echo '127.0.0.1 dev.api.rees46.com' >> /etc/hosts"
```

```bash
bundle config set --local without production
bundle install
```

Если ошибка с `gem puma`:

```bash
bundle config build.puma --with-cflags="-Wno-error=implicit-function-declaration"
```

Создаем базы:

```bash
rake db:create
rake db:schema:load
rake clickhouse:create clickhouse:schema:load
RAILS_ENV=test rake db:create
RAILS_ENV=test rake clickhouse:schema:load -- --simple
```

Запускаем сервер:

```bash
bin/server
```

---

## Настройка Dashboard проекта

```bash
git clone ssh://git@git.jetbrains.space/rees46/dev/Dashboard.git && cd Dashboard
cp ../api-rails/config/database.yml config/database.yml
cp config/secrets.yml.example config/secrets.yml
```

Редактируем `config/database.yml` аналогично API.

```bash
bundle install
npm i
rake db:seed
rails s
```

Открываем [http://localhost:3000](http://localhost:3000). Используйте `localhost`, иначе не сработает капча.

---

## Создание и настройка магазина

1. Регистрируемся и создаем магазин с:

  * URL: `https://demo.rees46.com`
  * YML-файл: `https://demo.rees46.com/store/xml_rees46.xml`
2. Жмем "Настроить позже".
3. В API-консоли:

```bash
cd ~/Projects/api-rails && rails c
Customer.first.update(role: 0)
Shop.find(SHOP_ID).async_yml_import
```

4. Продлеваем магазин через `http://localhost:3000/admin/shops`, ставим тариф `xl` и дату в будущее.

---

## Расширенная настройка

### ElasticSearch 6.8 (macOS)

```bash
brew install elasticsearch@6
brew uninstall --ignore-dependencies openjdk
brew install openjdk@17
brew services restart elasticsearch@6
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch@6.plist
```

Проверка:

```bash
curl http://localhost:9200/
```

Изменение конфигурации:

```bash
curl -XPUT "http://localhost:9200/_template/default?pretty" \
 -H 'Content-Type: application/json' \
 -d'{"settings": {"number_of_shards": 2, "number_of_replicas": 0}, "index_patterns": ["*"]}'
```

Сброс read-only:

```bash
curl -XPUT -H "Content-Type: application/json" \
http://localhost:9200/_all/_settings \
-d '{"index.blocks.read_only_allow_delete": null}'
```

---

## API Микро-сервисы

Требуются:

* PHP 8.1+
* RabbitMQ 3+
* ElasticSearch 6.8

Установка зависимостей PHP:

```bash
apt -y install php8.1 php8.1-cgi php8.1-dev php8.1-bcmath php8.1-mbstring \
php8.1-curl php8.1-pgsql php8.1-xml php8.1-gmp php8.1-intl php-pear libevent-dev
pecl install event
```

Установка Composer:

```bash
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

(Дальнейшие шаги — по README соответствующих сервисов.)
