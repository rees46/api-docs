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


