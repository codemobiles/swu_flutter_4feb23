# Install jdk from android studio
- new flutter project
- open product structure
- select sdk and click + jdk
- download
- set jre location (java and keytool)

remove comments
//.*

// IOS
podfile
platform :ios, '10.0'

https://www.youtube.com/watch?v=jpcNpaSrLig
flutter run --release

cd android
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key


# rename pacakge both Android and iOS
1. change_app_package_name in dev dependencies
2. flutter pub run change_app_package_name:main com.xxx.xx
3. Clean and Run (check Android Manifest and Info.plist)
- https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html

flutter pub add flutter_launcher_icons
flutter pub run flutter_launcher_icons:main
flutter run --release

flutter build apk
flutter build appbundle


connect android adb via wifi
-----------------------------
adb devices
adb tcpip 5555
adb shell ip addr show wlan0
adb connect 192.168.0.114


flutter build appbundle -v

# Fix [Solved] Mapping new ns to old ns Flutter [Solved]
# Upgrade gradle
classpath 'com.android.tools.build:gradle:7.1.1'
gradle-wrapper.properties distributionUrl=https\://services.gradle.org/distributions/gradle-7.2-all.zip
uses-sdk:minSdkVersion 16 cannot be smaller than version 20 declared in library

# Fix
open /build.gradle
ext.kotlin_version = '1.5.10'
classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"

# Android proxy
https://medium.com/@indaniram/run-android-emulator-with-proxy-configurations-6586ecb5461d

# Gradle build with proxy
/home/<username>/.gradle/ (Linux)
/Users/<username>/.gradle/ (Mac)
C:\Users\<username>\.gradle (Windows)

This is my gradle.properties, please note those HTTPS portion
systemProp.http.proxyHost=127.0.0.1
systemProp.http.proxyPort=8118
systemProp.https.proxyHost=127.0.0.1
systemProp.https.proxyPort=8118

