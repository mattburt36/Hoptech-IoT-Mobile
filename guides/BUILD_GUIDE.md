# Hoptech IoT Mobile - Build Guide

## Overview
This guide walks you through setting up the development environment and building the Hoptech IoT mobile application from scratch.

## Prerequisites
- Linux (openSUSE Leap 16.0 or similar)
- Git
- curl
- Internet connection

## Step 1: Install FVM (Flutter Version Manager)

FVM allows you to manage multiple Flutter SDK versions on the same machine.

```bash
# Install FVM
curl -fsSL https://fvm.app/install.sh | bash

# Add FVM to your PATH
echo 'export PATH="/home/$USER/fvm/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Verify installation
fvm --version
```

## Step 2: Install Flutter SDK

This project uses Flutter 3.29.0:

```bash
# Navigate to project directory
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Install Flutter 3.29.0
fvm install 3.29.0

# Set it as the version for this project
fvm use 3.29.0

# Verify Flutter installation
fvm flutter --version
```

## Step 3: Install Dependencies

```bash
# Get all Flutter dependencies
fvm flutter pub get
```

This will download all required packages defined in `pubspec.yaml`.

## Step 4: Configure Android Development

### Install Android SDK
If you don't have Android SDK installed:

```bash
# The Flutter doctor command will guide you
fvm flutter doctor

# Accept Android licenses
fvm flutter doctor --android-licenses
```

### Install Android NDK
The NDK is automatically installed during the first build, but you can install it manually:

```bash
# Via Android SDK Manager
sdkmanager "ndk;25.1.8937393"
```

## Step 5: Generate App Icons and Splash Screens

After replacing the branding assets in `assets/branding/`, generate the icons:

```bash
# Generate launcher icons for Android and iOS
fvm flutter pub run flutter_launcher_icons

# Generate splash screens
fvm flutter pub run flutter_native_splash:create
```

## Step 6: Build the Application

### Debug Build (for development)

```bash
# Build debug APK
fvm flutter build apk --debug

# Output location: build/app/outputs/flutter-apk/app-debug.apk
```

**Note:** The first build takes 20-30 minutes as it downloads and compiles all dependencies.

### Release Build (for production)

```bash
# Build release APK
fvm flutter build apk --release

# Build app bundle for Google Play Store
fvm flutter build appbundle --release
```

## Step 7: Run Code Analysis

Before committing code, run the analyzer:

```bash
# Analyze code for issues
fvm flutter analyze

# Format code
fvm flutter format lib/
```

## Step 8: Run Tests

```bash
# Run all tests
fvm flutter test

# Run tests with coverage
fvm flutter test --coverage
```

## Running on Devices

### Run on Emulator

```bash
# List available devices/emulators
fvm flutter devices

# Run on connected device or emulator
fvm flutter run
```

### Run on Physical Device

1. Enable Developer Options on your Android device
2. Enable USB Debugging
3. Connect device via USB
4. Run: `fvm flutter run`

## Build Times

- **First build:** 20-30 minutes (downloads NDK, dependencies)
- **Incremental builds:** 1-3 minutes
- **Clean builds:** 5-10 minutes

## Common Commands

```bash
# Check Flutter environment
fvm flutter doctor -v

# Clean build artifacts
fvm flutter clean

# Get latest dependencies
fvm flutter pub get

# Upgrade dependencies
fvm flutter pub upgrade

# List outdated packages
fvm flutter pub outdated

# Run with custom dart defines
fvm flutter run \
  --dart-define=thingsboardApiEndpoint=https://your-server.com
```

## Custom Branding Build

You can override branding at build time:

```bash
# Android with custom settings
fvm flutter build apk \
  --dart-define=androidApplicationId=io.hoptech.iot \
  --dart-define=androidApplicationName="Hoptech IoT" \
  --dart-define=thingsboardApiEndpoint=https://your-server.com

# iOS with custom settings
fvm flutter build ios \
  --dart-define=thingsboardApiEndpoint=https://your-server.com \
  --dart-define=thingsboardOAuth2CallbackUrlScheme=io.hoptech.iot.auth
```

## Project Structure

```
Hoptech-IoT-Mobile/
├── android/                 # Android native code
│   └── app/
│       ├── build.gradle    # Android build configuration
│       └── src/
│           └── main/
│               └── kotlin/io/hoptech/iot/  # Kotlin code
├── ios/                    # iOS native code
├── lib/                    # Dart application code
│   ├── main.dart          # App entry point
│   ├── constants/         # App constants
│   ├── modules/           # Feature modules
│   └── widgets/           # Reusable widgets
├── assets/
│   └── branding/          # App icons and splash screens
├── test/                  # Unit and widget tests
├── pubspec.yaml           # Dependencies and metadata
└── BUILD_GUIDE.md         # This file
```

## Key Configuration Files

### `pubspec.yaml`
- App name: `hoptech_iot_app`
- Version: `1.0.0+1`
- Dependencies and dev dependencies

### `android/app/build.gradle`
- Package ID: `io.hoptech.iot`
- App name: `Hoptech IoT`
- Min SDK: 24
- Target SDK: 36
- Compile SDK: 35

### `lib/constants/app_constants.dart`
- API endpoints
- OAuth2 callback schemes
- App secrets

## Troubleshooting

### Build Failures

```bash
# Clean and rebuild
fvm flutter clean
fvm flutter pub get
fvm flutter build apk --debug
```

### Gradle Issues

```bash
# In android directory
cd android
./gradlew clean
cd ..
fvm flutter build apk --debug
```

### Package Issues

```bash
# Reset dependencies
rm -rf pubspec.lock
rm -rf .flutter-plugins
rm -rf .flutter-plugins-dependencies
fvm flutter pub get
```

### Permission Issues

If you get permission errors on Android, check:
- `android/app/src/main/AndroidManifest.xml` for required permissions
- Device settings for app permissions

## Release Checklist

Before releasing to production:

- [ ] Update version in `pubspec.yaml`
- [ ] Run `fvm flutter analyze` (no errors)
- [ ] Run `fvm flutter test` (all tests pass)
- [ ] Test on physical devices (Android & iOS)
- [ ] Configure signing certificates
- [ ] Build release versions
- [ ] Test release builds
- [ ] Update changelog
- [ ] Tag release in git

## Signing for Release

### Android Signing

Create a keystore:
```bash
keytool -genkey -v -keystore ~/hoptech-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias hoptech
```

Configure `android/key.properties`:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=hoptech
storeFile=<path-to-keystore>
```

### iOS Signing

Use Xcode to configure:
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner target
3. Go to Signing & Capabilities
4. Select your team
5. Configure bundle identifier: `io.hoptech.iot`

## Support

For issues or questions:
- Check Flutter docs: https://flutter.dev
- ThingsBoard mobile docs: https://thingsboard.io/docs/mobile/
- Project repository issues

## Version History

- **1.0.0+1** - Initial Hoptech branded release
  - Rebranded from ThingsBoard app
  - Package: `io.hoptech.iot`
  - Custom Hoptech logo and splash screens

## Emulator Setup (Completed)

### Created Emulator: `hoptech_dev`
- **System Image:** Android 16 (API 36) Google APIs with Play Store
- **Architecture:** x86_64
- **Device Profile:** Pixel 5

### Emulator Commands

```bash
# List available emulators
~/Android/Sdk/emulator/emulator -list-avds

# Start emulator
~/Android/Sdk/emulator/emulator -avd hoptech_dev &

# Or use Flutter command
export ANDROID_SDK_ROOT=~/Android/Sdk
fvm flutter emulators --launch hoptech_dev

# Check running devices
fvm flutter devices

# Run app on emulator
fvm flutter run -d emulator-5554
```

### Development Workflow

1. **Start emulator** (if not already running):
   ```bash
   ~/Android/Sdk/emulator/emulator -avd hoptech_dev &
   ```

2. **Run the app**:
   ```bash
   fvm flutter run
   ```

3. **Hot reload** - Press `r` in the terminal to instantly reload changes
4. **Hot restart** - Press `R` for a full restart
5. **Quit** - Press `q` to stop the app

### Tips

- First run takes longer as it installs the APK
- Hot reload (`r`) is much faster for UI changes
- Use Flutter DevTools for debugging (URL shown in console)
- Check logs with: `~/Android/Sdk/platform-tools/adb logcat -s flutter`

## Successful Build Verification ✅

The app has been successfully:
- ✅ Rebranded with Hoptech logo and identity
- ✅ Built for Android (debug APK: 233MB)
- ✅ Deployed to emulator
- ✅ Launched and running

**Package ID:** `io.hoptech.iot`  
**App Name:** Hoptech IoT  
**Current Version:** 1.0.0+1
