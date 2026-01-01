# Hoptech IoT - Deployment Checklist

## Pre-Deployment Verification ✅

### Rebranding Complete
- [x] App name changed to "Hoptech IoT"
- [x] Package ID: `io.hoptech.iot`
- [x] Hoptech logo in app launcher
- [x] Hoptech logo in splash screen
- [x] Hoptech logo throughout app UI
- [x] All localization files updated
- [x] App runs successfully on emulator

### Code Quality
- [x] `flutter analyze` passes (only 45 info warnings about import ordering)
- [x] No compilation errors
- [x] App launches without crashes
- [x] Core functionality works

## Release Build Preparation

### 1. Update Version Number

Edit `pubspec.yaml`:
```yaml
version: 1.0.0+1  # Already set correctly
```

Version format: `MAJOR.MINOR.PATCH+BUILD_NUMBER`
- For first release: `1.0.0+1` ✅
- For updates: increment appropriately

### 2. Configure App Signing (Android)

#### Create Release Keystore
```bash
keytool -genkey -v -keystore ~/hoptech-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias hoptech-release
```

**Important:** Save the keystore password securely!

#### Configure Gradle Signing

Create `android/key.properties`:
```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=hoptech-release
storeFile=/home/matt/hoptech-release.jks
```

#### Update `android/app/build.gradle`

Add before `android {`:
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Add inside `android {` block:
```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
        // ... existing config
    }
}
```

### 3. Configure Backend Server

Choose one method:

**Option A: Edit `lib/constants/app_constants.dart`**
```dart
static const thingsBoardApiEndpoint = 'https://your-thingsboard-server.com';
```

**Option B: Pass at build time**
```bash
fvm flutter build apk --release \
  --dart-define=thingsboardApiEndpoint=https://your-server.com
```

### 4. Build Release APK

```bash
# Clean previous builds
fvm flutter clean
fvm flutter pub get

# Build release APK
fvm flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### 5. Build App Bundle (for Google Play)

```bash
# Build app bundle
fvm flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### 6. Test Release Build

```bash
# Install on device
~/Android/Sdk/platform-tools/adb install \
  build/app/outputs/flutter-apk/app-release.apk

# Or run directly
fvm flutter run --release
```

## Google Play Store Preparation

### 1. App Store Listing Information

**App Name:** Hoptech IoT

**Short Description (80 characters max):**
```
IoT device management and monitoring solution powered by ThingsBoard
```

**Full Description:**
```
Hoptech IoT is a powerful mobile application for managing and monitoring your IoT devices powered by the ThingsBoard platform.

Features:
• Real-time device monitoring
• Remote device control
• Dashboard visualization
• Alarm management
• Asset tracking
• Customer management
• Audit logs
• Multi-language support

Connect to your ThingsBoard server and manage your IoT infrastructure from anywhere.

Perfect for industrial IoT, smart home, and enterprise device management.
```

**Category:** Business / Productivity

**Content Rating:** Everyone

**Privacy Policy:** [Required - provide URL]

### 2. Graphics Assets Required

#### App Icon
- [x] Already created: Hoptech logo in all sizes
- Requirement: 512x512 PNG

#### Feature Graphic
- Requirement: 1024x500 PNG
- TODO: Create marketing banner with Hoptech branding

#### Screenshots (Required)
Capture from app:
- [ ] Login/Splash screen
- [ ] Dashboard view
- [ ] Device list
- [ ] Device details
- [ ] Settings screen

Minimum: 2 screenshots
Maximum: 8 screenshots
Size: 320-3840 pixels on longest side

Take screenshots:
```bash
~/Android/Sdk/platform-tools/adb exec-out screencap -p > screenshot_1.png
```

#### Promo Video (Optional)
- Max 2 minutes
- YouTube URL

### 3. Store Presence Checklist

- [ ] App name: "Hoptech IoT"
- [ ] Short description written
- [ ] Full description written
- [ ] Screenshots captured (minimum 2)
- [ ] Feature graphic created (1024x500)
- [ ] App icon uploaded (512x512)
- [ ] Privacy policy URL provided
- [ ] Category selected
- [ ] Content rating completed

## iOS Deployment (Optional)

### 1. Configure Xcode Project

```bash
cd ios
open Runner.xcworkspace
```

In Xcode:
1. Select Runner target
2. Update Bundle Identifier: `io.hoptech.iot`
3. Set Display Name: `Hoptech IoT`
4. Configure Signing & Capabilities
5. Select your development team

### 2. Build iOS App

```bash
fvm flutter build ios --release
```

### 3. Archive and Upload

Use Xcode or Transporter app to submit to App Store

## Post-Deployment Tasks

### After First Release

- [ ] Monitor crash reports in Play Console
- [ ] Check user reviews and ratings
- [ ] Monitor analytics (if configured)
- [ ] Prepare update plan for bugs/issues

### Update Process

For future updates:
1. Increment version in `pubspec.yaml`
2. Make code changes
3. Test thoroughly
4. Build release
5. Upload to Play Console
6. Write release notes

## Security Checklist

- [ ] Keystore secured and backed up
- [ ] `key.properties` added to `.gitignore`
- [ ] No sensitive data in source code
- [ ] API keys properly secured
- [ ] SSL/TLS for all network connections

## Testing Checklist

Before release:
- [ ] Test on multiple Android versions
- [ ] Test on different screen sizes
- [ ] Test network connectivity issues
- [ ] Test permissions (location, camera, etc.)
- [ ] Test login/logout flows
- [ ] Test all core features
- [ ] Test in different languages

## Build Commands Summary

```bash
# Debug builds (for testing)
fvm flutter build apk --debug
fvm flutter run

# Release builds (for deployment)
fvm flutter build apk --release          # APK
fvm flutter build appbundle --release    # AAB for Play Store
fvm flutter build ios --release          # iOS

# With custom configuration
fvm flutter build apk --release \
  --dart-define=thingsboardApiEndpoint=https://your-server.com \
  --dart-define=androidApplicationId=io.hoptech.iot \
  --dart-define=androidApplicationName="Hoptech IoT"
```

## File Sizes (Approximate)

- Debug APK: ~233 MB (includes debug symbols)
- Release APK: ~40-60 MB (optimized)
- App Bundle: ~30-50 MB (smallest download size)

## Support Information

**Developer Contact:**
- Email: [Your support email]
- Website: [Your website]
- Privacy Policy: [Your privacy policy URL]

## Notes

- First release uses version `1.0.0+1`
- App is fully rebranded with Hoptech identity
- Package name `io.hoptech.iot` is unique to your organization
- ThingsBoard client library remains as dependency (correct)
- Backend configuration must be set before release or passed at build time

## Quick Commands

```bash
# Complete release build process
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Clean and prepare
fvm flutter clean
fvm flutter pub get
fvm flutter analyze

# Build release
fvm flutter build appbundle --release

# Check output
ls -lh build/app/outputs/bundle/release/

# The file `app-release.aab` is ready for Play Store upload!
```

## Deployment Status

- ✅ App rebranded to Hoptech IoT
- ✅ Package configured: io.hoptech.iot
- ✅ Debug build tested and working
- ⏳ Release keystore needed
- ⏳ Release build needed
- ⏳ Play Store listing needed
- ⏳ Screenshots needed
- ⏳ Feature graphic needed

## Next Immediate Steps

1. **Create release keystore** (see section 2)
2. **Configure signing** in gradle
3. **Build release version**
4. **Test release build** on real device
5. **Capture screenshots** for store listing
6. **Prepare store listing** information
7. **Upload to Play Console**

You're 80% done! Just need signing configuration and store assets!
