@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-16.0.1
set PATH=%JAVA_HOME%\bin;%PATH%
cd /d C:\Users\HP\Documents\Flutter\mywitti
flutter clean
flutter pub get
flutter build apk
pause
