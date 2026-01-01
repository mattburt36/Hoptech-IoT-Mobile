# Hoptech IoT - Android Emulator Guide

## Current Setup

You now have a fully configured Android development environment with:

- **Emulator Name:** `hoptech_dev`
- **Android Version:** Android 16 (API 36)
- **System Image:** Google APIs with Play Store
- **Architecture:** x86_64
- **Device:** Pixel 5 profile

## Quick Start

### 1. Start the Emulator

```bash
# Option 1: Direct emulator command
~/Android/Sdk/emulator/emulator -avd hoptech_dev &

# Option 2: Using Flutter
export ANDROID_SDK_ROOT=~/Android/Sdk
fvm flutter emulators --launch hoptech_dev
```

### 2. Run the Hoptech IoT App

```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
fvm flutter run
```

The app will automatically install and launch on the emulator.

## Development Commands

### Flutter Hot Reload (While app is running)

- **`r`** - Hot reload (applies code changes instantly)
- **`R`** - Hot restart (full restart of the app)
- **`h`** - Show all available commands
- **`d`** - Detach (keeps app running)
- **`q`** - Quit (stops the app)
- **`c`** - Clear the screen

### Emulator Management

```bash
# List all available emulators
~/Android/Sdk/emulator/emulator -list-avds

# Check running devices
fvm flutter devices

# Kill emulator
~/Android/Sdk/platform-tools/adb emu kill
```

### Debugging

```bash
# View real-time logs
~/Android/Sdk/platform-tools/adb logcat -s flutter

# View all logs
~/Android/Sdk/platform-tools/adb logcat

# Clear logs
~/Android/Sdk/platform-tools/adb logcat -c

# Screenshot
~/Android/Sdk/platform-tools/adb exec-out screencap -p > screenshot.png
```

## Flutter DevTools

When you run `flutter run`, you'll see a URL like:
```
http://127.0.0.1:9100?uri=http://127.0.0.1:39257/xxxxx/
```

Open this in your browser for:
- Performance profiling
- Widget inspector
- Network requests
- Logging
- Memory profiling

## Emulator Keyboard Shortcuts

- **Power button:** `Power`
- **Volume up:** `Ctrl + Up`
- **Volume down:** `Ctrl + Down`
- **Back button:** `Esc`
- **Home button:** `Home`
- **Recent apps:** `PgUp`
- **Rotate left:** `Ctrl + Left`
- **Rotate right:** `Ctrl + Right`

## Troubleshooting

### Emulator Won't Start

```bash
# Check if another instance is running
ps aux | grep emulator

# Kill old instances
killall qemu-system-x86_64

# Try again
~/Android/Sdk/emulator/emulator -avd hoptech_dev
```

### App Install Issues

```bash
# Uninstall app
~/Android/Sdk/platform-tools/adb uninstall io.hoptech.iot

# Clean and rebuild
fvm flutter clean
fvm flutter pub get
fvm flutter run
```

### Emulator Performance

The emulator is configured for x86_64 which provides good performance. If it's slow:

1. **Enable hardware acceleration:**
   ```bash
   # Check KVM support (Linux)
   egrep -c '(vmx|svm)' /proc/cpuinfo
   # If result is > 0, KVM is supported
   ```

2. **Start with more resources:**
   ```bash
   ~/Android/Sdk/emulator/emulator -avd hoptech_dev \
     -memory 2048 \
     -cores 4 \
     -gpu host
   ```

### Android SDK Issues

```bash
# Update SDK components
export ANDROID_SDK_ROOT=~/Android/Sdk
~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager --update

# List installed packages
~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager --list_installed
```

## Creating Additional Emulators

### List Available System Images

```bash
~/Android/Sdk/cmdline-tools/latest/bin/sdkmanager --list | grep system-images
```

### Create New Emulator

```bash
# Example: Create a tablet emulator
~/Android/Sdk/cmdline-tools/latest/bin/avdmanager create avd \
  -n hoptech_tablet \
  -k "system-images;android-36;google_apis_playstore;x86_64" \
  -d "pixel_tablet"
```

### Using Flutter to Create Emulator

```bash
export ANDROID_SDK_ROOT=~/Android/Sdk
fvm flutter emulators --create --name my_new_emulator
```

## Next Steps

### Configure Backend Connection

The app is currently trying to connect to a ThingsBoard server. To configure:

1. **Edit constants:**
   ```bash
   nano lib/constants/app_constants.dart
   ```

2. **Or pass at build time:**
   ```bash
   fvm flutter run \
     --dart-define=thingsboardApiEndpoint=https://your-server.com
   ```

### Test on Physical Device

1. Enable Developer Options on Android device
2. Enable USB Debugging
3. Connect via USB
4. Run: `fvm flutter run`

### Build Release APK

```bash
# Build release APK
fvm flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

## Useful Resources

- Flutter DevTools: Shown in console when running
- Android Debug Bridge: `~/Android/Sdk/platform-tools/adb`
- Emulator Console: Connect with `telnet localhost 5554`
- Logs: `~/Android/Sdk/platform-tools/adb logcat`

## Status Check

Run this to verify everything is working:

```bash
export PATH="/home/matt/fvm/bin:$PATH"
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

echo "=== Flutter Version ==="
fvm flutter --version

echo ""
echo "=== Available Devices ==="
fvm flutter devices

echo ""
echo "=== Emulators ==="
~/Android/Sdk/emulator/emulator -list-avds

echo ""
echo "=== Flutter Doctor ==="
fvm flutter doctor
```

---

**Pro Tip:** Keep the emulator running while developing. Use hot reload (`r`) to see changes instantly without restarting the app!
