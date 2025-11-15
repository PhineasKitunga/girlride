@echo off
REM Build script for GirlRide with secure API keys
REM 
REM Usage: 
REM   Set your API keys as environment variables first:
REM   set MAPS_API_KEY_ANDROID=your_android_key
REM   set MAPS_API_KEY_IOS=your_ios_key
REM   set MAPS_API_KEY_WEB=your_web_key
REM   
REM   Then run: build.bat

echo Building GirlRide with secure API keys...

if "%MAPS_API_KEY_WEB%"=="" (
    echo WARNING: MAPS_API_KEY_WEB not set!
    echo Please set environment variables before building.
    echo See BUILD_INSTRUCTIONS.md for details.
    pause
    exit /b 1
)

echo Building for Web...
flutter build web ^
    --dart-define=MAPS_API_KEY_ANDROID=%MAPS_API_KEY_ANDROID% ^
    --dart-define=MAPS_API_KEY_IOS=%MAPS_API_KEY_IOS% ^
    --dart-define=MAPS_API_KEY_WEB=%MAPS_API_KEY_WEB%

echo.
echo Build complete!
echo Keys were passed at compile time and are not stored in source code.
