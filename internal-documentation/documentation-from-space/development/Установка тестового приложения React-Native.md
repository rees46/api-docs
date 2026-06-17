## Установка зависимостей

Тестирование проводилось на macOS Catalina 10.15.7.

1. **Клонируем проект и переходим в директорию:**

   ```bash
   git clone ssh://git@git.jetbrains.space/rees46/dev/TestPushProject.git && cd TestPushProject
   ```

2. **Устанавливаем Ruby 2.7.5:**

   ```bash
   rvm install "ruby-2.7.5"
   ```

   Если при установке возникла ошибка, указываем пути к OpenSSL 1.1:

   ```bash
   export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
   export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
   export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
   export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
   rvm reinstall "ruby-2.7.5"
   ```

3. **Устанавливаем вспомогательные библиотеки:**

   ```bash
   brew install node watchman
   ```

4. **Устанавливаем зависимости для Node.js:**

   ```bash
   npm i
   ```

## Запуск приложения в iOS-эмуляторе

1. **Устанавливаем CocoaPods:**

   ```bash
   cd ios
   bundle install
   bundle exec pod install
   ```

   Если в процессе появилась ошибка, связанная с отсутствием Xcode:

  * Установите Xcode из App Store.
  * Откройте Xcode → Preferences → Locations → выберите версию Xcode для `Command Line Tools`.
  * После этого снова выполните:

    ```bash
    bundle exec pod install
    ```

2. **Ошибка в конце установки `pod install`:**

   Если видите сообщение об ошибке, добавьте в `Podfile`:

   ```ruby
   pod 'Firebase', :modular_headers => true
   pod 'FirebaseCoreInternal', :modular_headers => true
   pod 'GoogleUtilities', :modular_headers => true
   ```

   Затем повторите установку:

   ```bash
   bundle exec pod install
   ```

3. **Запускаем эмулятор:**

   ```bash
   cd .. && npm run ios
   ```

   При успешном запуске должно открыться новое окно терминала и запуститься приложение в эмуляторе.

4. **Ошибка компиляции `FBReactNativeSpec.h` (iOS 12.0):**

   Если при сборке возникает ошибка:

   ```
   error: 'value' is unavailable: introduced in iOS 12.0
   ```

   Необходимо заменить строку во всех `Pod`-файлах:

   ```
   IPHONEOS_DEPLOYMENT_TARGET = 11.0;
   ```

   на:

   ```
   IPHONEOS_DEPLOYMENT_TARGET = 12.4;
   ```

   Замену потребуется делать после каждого запуска `bundle exec pod install`.

   Альтернативно — указать нужную версию iOS в настройках Xcode вручную.

5. **Настройка `shop_id` и пути к API:**

  * Файл: `App.js`
  * Путь к API можно изменить в:
    `node_modules/@rees46/react-native-sdk/index.js`

## Настройка Firebase

1. Перейдите в [Firebase Console](https://console.firebase.google.com) и создайте новый проект.

2. Укажите `Apple bundle ID`:
   `org.reactjs.native.example.TestPushProject`

3. На следующем шаге скачайте `.plist` и добавьте его в Xcode:

  * Откройте `ios/TestPushProject.xcodeproj` в Xcode.
  * Перетащите файл `.plist` в структуру проекта.

4. Закройте Xcode и выполните повторный запуск:

   ```bash
   npm run ios
   ```

## Запуск приложения в Android-эмуляторе

1. **Установите Android Studio и SDK:**

   Скачайте [Command line tools only](https://developer.android.com/studio/index.html) (внизу страницы) и распакуйте в удобную директорию.

2. **Создайте файл `android/local.properties`:**

   ```properties
   sdk.dir=/path/to/sdk
   ```

3. **Добавьте пути к SDK в `~/.zshrc`:**

   ```bash
   export ANDROID_SDK_ROOT=/path/to/sdk
   export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
   export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
   ```

   Примените изменения:

   ```bash
   source ~/.zshrc
   ```

4. **Создайте эмулятор в Android Studio:**

  * Версия: Android 12.0 (Google Play), API Level 31

   *(Если есть физическое устройство с включённым USB-дебагом — подключите по USB, эмулятор можно не создавать.)*

5. **(Для Windows)**

   Пропишите переменные окружения с путями к SDK в системных настройках.

6. **Запуск приложения:**

   ```bash
   npm run android
   ```
