## Ключ авторизации

Генерируем ssh ключ авторизации без указания пароля:

```
ssh-keygen
```
Выводим содержимое:

```
cat ~/.ssh/id_rsa.pub
```
Открываем настройки Space: Preferences -> Git Keys и добавляем ключ.

Добавляем приватный ключ к ssh агенту:

```
ssh-add -K ~/.ssh/id_rsa
```

## Установка зависимостей

Подготовка окружения и установка необходимых зависимостей для работы сервисов REES46.

Если хорошо владеете Docker - проще всего поставить необходимые компоненты через него. Но данный способ не советую, т.к. Docker съедает много оперативной памяти.

### PostgreSQL 14

#### Ubuntu 18.04:

```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - && sudo apt update
```

#### Ubuntu 18.04:

```
sudo apt -y install postgresql-14 postgresql-client-14 libpq-dev
```

#### Mac OS:

```
brew install postgresql
```

```
createuser -s postgres
```

```
brew services start postgresql
```

Добавляем службу в автозапуск:

```
mkdir -p ~/Library/LaunchAgents && \
```

```
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents && \
```

```
launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
```

После установки заходим в утилиту `sudo -u postgres psql` для создания юзера.

<aside class="notice">

Если утилита `psql` и `createuser` недоступна, возможно у вас не прописаны пути от `brew` в переменной `$PATH`, выполняем:

```
echo 'export PATH=/opt/local/bin:/opt/local/sbin:$PATH' >> ~/.profile && source ~/.profile
```

</aside>

Создаем юзера командой и даем права суперюзера:

```
CREATE USER rees46 WITH ENCRYPTED PASSWORD 'rees46';
ALTER USER rees46 WITH SUPERUSER;
```
### Clickhouse 22.2

Mac OS:

```
brew tap clickhouse/clickhouse && brew install clickhouse@22.2 && brew services restart clickhouse
```

#### Обновляем сертификаты

Ubuntu:

```
sudo apt install ca-certificates
```

Mac OS:

```
brew install ca-certificates
```

### Ruby 

Установка ruby через RVM:

```
curl -sSL https://get.rvm.io | bash -s stable && source ~/.profile
```
Если получаем ошибку `curl: (60) SSL certificate problem: certificate has expired`:

```
curl https://raw.githubusercontent.com/rvm/rvm/master/binscripts/rvm-installer | bash -s stable
```
Рестартуем терминал и выполняем установку Ruby 2.7.5

```
rvm install 2.7.5
```
#### Ubuntu

На версии 22.04 не работает подключение к PG. Падает с ошибкой Segmentation fault . Видимо из-за использования OpenSSL 3. Работает корректно только на 18.04 версии.

Устанавливаем bundle:

```
gem install bundler -v 1.17.3
```

#### Mac OS:

Если видимо ошибку при установке` Error running 'requirements_osx_brew_update_system ruby-2.7.5'`

Требуется поставить CommandLineTools:

```
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```
### ImageMagick 6

Ubuntu:

```
sudo apt-get install -y imagemagick-6.q16 libmagickwand-dev
```

Mac OS:

```
brew install shared-mime-info imagemagick@6
```

### Node 16, NPM

Ubuntu:

```
curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
sudo apt -y install nodejs
node -v
```

Mac OS:

```
brew install node@16
node -v
```
## Настройка API проекта

Создаем рабочую директорию с проектами (не обязательно, у вас оно может лежать в любом другом месте):



