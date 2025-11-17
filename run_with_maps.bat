@echo off
REM Run Flutter app with Google Maps API key
REM Replace YOUR_API_KEY_HERE with your actual Google Maps API key

flutter run --dart-define=MAPS_API_KEY_WEB=YOUR_API_KEY_HERE --dart-define=MAPS_API_KEY_ANDROID=YOUR_API_KEY_HERE --dart-define=MAPS_API_KEY_IOS=YOUR_API_KEY_HERE
