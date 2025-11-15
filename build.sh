#!/bin/bash
# Build script for GirlRide with secure API keys
# 
# Usage: 
#   Set your API keys as environment variables first:
#   export MAPS_API_KEY_ANDROID=your_android_key
#   export MAPS_API_KEY_IOS=your_ios_key
#   export MAPS_API_KEY_WEB=your_web_key
#   
#   Then run: ./build.sh

echo "Building GirlRide with secure API keys..."

if [ -z "$MAPS_API_KEY_WEB" ]; then
    echo "WARNING: MAPS_API_KEY_WEB not set!"
    echo "Please set environment variables before building."
    echo "See BUILD_INSTRUCTIONS.md for details."
    exit 1
fi

echo "Building for Web..."
flutter build web \
    --dart-define=MAPS_API_KEY_ANDROID=$MAPS_API_KEY_ANDROID \
    --dart-define=MAPS_API_KEY_IOS=$MAPS_API_KEY_IOS \
    --dart-define=MAPS_API_KEY_WEB=$MAPS_API_KEY_WEB

echo ""
echo "Build complete!"
echo "Keys were passed at compile time and are not stored in source code."
