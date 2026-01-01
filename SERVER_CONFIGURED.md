# ThingsBoard Server Configuration - COMPLETE ✅

## Configuration Applied

**Your ThingsBoard Server:** `https://iot.hoptech.co.nz`

### What Was Changed

**File:** `lib/constants/app_constants.dart`

**Before:**
```dart
static const thingsBoardApiEndpoint = String.fromEnvironment('thingsboardApiEndpoint');
```

**After:**
```dart
static const thingsBoardApiEndpoint = String.fromEnvironment(
  'thingsboardApiEndpoint',
  defaultValue: 'https://iot.hoptech.co.nz',
);
```

**Also configured:**
```dart
thingsboardOAuth2CallbackUrlScheme = 'io.hoptech.iot.auth'
```

### How It Works

The app now uses **`https://iot.hoptech.co.nz`** as the default ThingsBoard server.

**Benefits of this approach:**
- App always connects to your server by default
- Users don't need to enter server URL manually
- You can still override at build time if needed
- Region selection is skipped (goes straight to login)

### Server Verification

✅ **Server is online and accessible**
- URL: https://iot.hoptech.co.nz
- Status: HTTP 200 OK
- SSL/HTTPS: Working

### Testing the Configuration

**On Emulator:**
```bash
# Start emulator
~/Android/Sdk/emulator/emulator -avd hoptech_dev &

# Run app
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
fvm flutter run
```

**What to test:**
1. App launches without region selection
2. Goes directly to login screen
3. Can login with your ThingsBoard credentials
4. Can view dashboards and devices

### Build Release Version

Now you can build the release version:

```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Build for Play Store
fvm flutter build appbundle --release

# Or build APK for direct distribution
fvm flutter build apk --release
```

### Override Server at Build Time (Optional)

If you ever need to build for a different server:

```bash
fvm flutter build appbundle --release \
  --dart-define=thingsboardApiEndpoint=https://different-server.com
```

### Next Steps

✅ **Step 1: Server configured** ← **YOU ARE HERE**

**Step 2: Create keystore (10 minutes)**
```bash
cd ~
keytool -genkey -v -keystore hoptech-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias hoptech-release
```

**Step 3: Configure signing** (see RELEASE_ROADMAP.md Phase 3)

**Step 4: Build release**
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
fvm flutter build appbundle --release
```

**Step 5: Test with your ThingsBoard server**

**Step 6: Prepare Play Store assets**

**Step 7: Submit to Play Store**

### Quick Test Right Now

Want to test the configuration immediately?

```bash
# If emulator is running:
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
fvm flutter run

# Then try logging in with your ThingsBoard credentials
```

### Troubleshooting

**If app shows "No host specified" error:**
- Check that `defaultValue` is set in app_constants.dart
- Rebuild: `fvm flutter clean && fvm flutter run`

**If can't connect to server:**
- Verify server is accessible: `curl https://iot.hoptech.co.nz`
- Check firewall/network settings
- Ensure SSL certificate is valid

**If login fails:**
- Verify credentials work in web browser
- Check ThingsBoard server logs
- Ensure mobile API is enabled in ThingsBoard

### Server Details

**Your Configuration:**
- Server: https://iot.hoptech.co.nz
- OAuth Scheme: io.hoptech.iot.auth
- Package: io.hoptech.iot
- Region Selection: Disabled (automatic)

### Files Modified

- ✅ `lib/constants/app_constants.dart` - Server URL configured

### Configuration Status

| Setting | Value | Status |
|---------|-------|--------|
| Server URL | https://iot.hoptech.co.nz | ✅ Configured |
| Server Online | Yes | ✅ Verified |
| SSL/HTTPS | Valid | ✅ Working |
| OAuth Scheme | io.hoptech.iot.auth | ✅ Configured |
| Region Selection | Disabled | ✅ Auto-connect |

### What This Means

Users who install your app will:
1. Launch app
2. See splash screen with Hoptech logo
3. Go directly to login screen (no region selection)
4. Login with ThingsBoard credentials
5. Access your IoT devices and dashboards

**No manual configuration needed by users!**

---

**Status:** ✅ ThingsBoard server configured and verified
**Next:** Create release keystore and build release version
**Time to release:** 2-3 hours + Google approval

See `RELEASE_ROADMAP.md` for complete release process.
