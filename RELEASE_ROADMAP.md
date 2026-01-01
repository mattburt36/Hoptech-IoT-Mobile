# Hoptech IoT - Release to Play Store Roadmap

## Current Status: 90% Complete! 🎉

You have:
- ✅ Fully rebranded app (Hoptech IoT)
- ✅ Working build system
- ✅ Dark grey/silver theme
- ✅ Logo properly sized
- ✅ App runs on emulator
- ✅ Package ID: io.hoptech.iot

## What's Left: 3-4 Hours of Work

### Phase 1: Configure Your ThingsBoard Server (30 minutes)

**Option A: Edit the code (recommended for single server)**
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
nano lib/constants/app_constants.dart
```

Find and update:
```dart
static const thingsBoardApiEndpoint = 'YOUR_THINGSBOARD_URL';
// Example: 'https://iot.hoptech.com' or 'https://thingsboard.hoptech.com'
```

**Option B: Pass at build time (for multiple deployments)**
```bash
fvm flutter build appbundle --release \
  --dart-define=thingsboardApiEndpoint=https://your-server.com
```

**What you need:**
- Your ThingsBoard server URL (e.g., `https://demo.thingsboard.io`)
- Make sure it's accessible via HTTPS
- Test that the URL works in a browser

---

### Phase 2: Create Release Keystore (10 minutes)

**This is CRITICAL - Protect this file!**

```bash
cd ~

# Create the keystore
keytool -genkey -v -keystore hoptech-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias hoptech-release

# You'll be asked:
# - Password (SAVE THIS!)
# - Your name: Hoptech or Your Name
# - Organization: Hoptech
# - City/State/Country
# - Confirm: yes
```

**⚠️ IMPORTANT: Back this up NOW!**
```bash
# Copy to a safe location
cp ~/hoptech-release.jks ~/hoptech-release-BACKUP-$(date +%Y%m%d).jks

# Store the password in a password manager!
```

**Why:** Once you upload to Play Store with this key, you MUST use the same key for all future updates. If you lose it, you can never update your app!

---

### Phase 3: Configure App Signing (15 minutes)

**Create signing configuration:**
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile/android

cat > key.properties << 'EOF'
storePassword=YOUR_PASSWORD_HERE
keyPassword=YOUR_PASSWORD_HERE
keyAlias=hoptech-release
storeFile=/home/matt/hoptech-release.jks
EOF

# Make sure it's not committed to git
echo "key.properties" >> .gitignore
```

**Update build.gradle:**
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
nano android/app/build.gradle
```

Add BEFORE the `android {` block (around line 35):
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}
```

Find the `buildTypes {` section (around line 70) and add signing:
```gradle
buildTypes {
    release {
        signingConfig signingConfigs.release
        // Existing config below...
    }
}
```

Add INSIDE the `android {` block, BEFORE `buildTypes`:
```gradle
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
        storePassword keystoreProperties['storePassword']
    }
}
```

---

### Phase 4: Build Release Version (10 minutes)

```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Clean previous builds
fvm flutter clean
fvm flutter pub get

# Build signed app bundle (for Play Store)
fvm flutter build appbundle --release

# OR build APK (for direct distribution)
fvm flutter build apk --release

# Check the output
ls -lh build/app/outputs/bundle/release/app-release.aab
ls -lh build/app/outputs/flutter-apk/app-release.apk
```

**Expected sizes:**
- AAB (App Bundle): ~30-50 MB
- APK: ~40-60 MB

---

### Phase 5: Test Release Build (30 minutes)

**Install on emulator:**
```bash
# Start emulator if not running
~/Android/Sdk/emulator/emulator -avd hoptech_dev &

# Install release APK
~/Android/Sdk/platform-tools/adb install \
  build/app/outputs/flutter-apk/app-release.apk
```

**Test checklist:**
- [ ] App launches
- [ ] Splash screen displays correctly
- [ ] Can connect to your ThingsBoard server
- [ ] Login works
- [ ] Can view dashboards
- [ ] Can view devices
- [ ] Logo looks good
- [ ] Theme colors are correct

**Test on physical device (highly recommended):**
1. Enable Developer Options on your Android phone
2. Enable USB Debugging
3. Connect via USB
4. `adb devices` to verify connection
5. `adb install build/app/outputs/flutter-apk/app-release.apk`

---

### Phase 6: Prepare Play Store Assets (1 hour)

**Required assets:**

**1. Screenshots (minimum 2, maximum 8)**
```bash
mkdir -p ~/hoptech-app-store-assets/screenshots

# Take screenshots from emulator
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-app-store-assets/screenshots/01-splash.png

~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-app-store-assets/screenshots/02-login.png

~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-app-store-assets/screenshots/03-dashboard.png

# Continue for other screens...
```

**Screenshot requirements:**
- 320-3840 pixels on longest side
- PNG or JPEG
- Show actual app functionality
- No device frames needed

**2. App Icon (512x512)**
```bash
# You already have this!
cp assets/branding/icon_filled.png \
  ~/hoptech-app-store-assets/icon-512x512.png
```

**3. Feature Graphic (1024x500)**
Create a banner image with:
- Hoptech logo
- App name "Hoptech IoT"
- Tagline (e.g., "IoT Device Management")

```bash
# Quick creation with ImageMagick
convert -size 1024x500 xc:#37474F \
  -font Arial -pointsize 60 -fill white \
  -gravity center -annotate +0-50 "Hoptech IoT" \
  -font Arial -pointsize 30 -fill "#B0BEC5" \
  -gravity center -annotate +0+30 "IoT Device Management Platform" \
  ~/hoptech-app-store-assets/feature-graphic.png

# Then add your logo in the center using GIMP or similar
```

**4. App Description**

Short description (80 characters max):
```
IoT device management and monitoring powered by ThingsBoard
```

Full description:
```
Hoptech IoT is your comprehensive mobile solution for managing and monitoring IoT devices powered by the ThingsBoard platform.

Key Features:
• Real-time device monitoring and control
• Interactive dashboards with live data visualization
• Alarm management and notifications
• Asset tracking and organization
• Customer management
• Comprehensive audit logs
• Multi-language support (English, Arabic, Chinese)

Perfect For:
✓ Industrial IoT deployments
✓ Smart building management
✓ Fleet monitoring
✓ Energy management systems
✓ Environmental monitoring
✓ Any ThingsBoard-powered IoT solution

Connect to your ThingsBoard server and manage your entire IoT infrastructure from anywhere, anytime.

Secure, reliable, and easy to use - Hoptech IoT brings the power of ThingsBoard to your mobile device.

Requires: ThingsBoard server (self-hosted or cloud)
Support: [your-email@hoptech.com]
```

---

### Phase 7: Create Google Play Console Account (30 minutes)

**If you don't have one:**

1. Go to https://play.google.com/console
2. Sign up with Google account
3. Pay one-time $25 registration fee
4. Complete account setup

**Required information:**
- Developer name: Hoptech
- Email: your-email@hoptech.com
- Phone number
- Address

---

### Phase 8: Create Play Store Listing (30 minutes)

**In Play Console:**

1. **Create App**
   - App name: Hoptech IoT
   - Default language: English (United States)
   - App type: App
   - Free or paid: Free

2. **Store Listing**
   - Short description: (from Phase 6)
   - Full description: (from Phase 6)
   - App icon: Upload 512x512 PNG
   - Feature graphic: Upload 1024x500
   - Screenshots: Upload 2-8 screenshots
   - Category: Business or Productivity
   - Contact details: Email, website (optional), privacy policy URL

3. **Content Rating**
   - Answer questionnaire
   - Likely rating: Everyone

4. **App Content**
   - Privacy policy: Required (you'll need to create one)
   - Ads: No (probably)
   - App access: Full or restricted
   - Data safety: Fill out what data you collect

5. **Release**
   - Countries: Select where to release
   - Upload AAB file: `app-release.aab`
   - Release name: v1.0.0 (Hoptech IoT Initial Release)
   - Release notes:
     ```
     Initial release of Hoptech IoT
     - Connect to your ThingsBoard server
     - Monitor devices in real-time
     - View dashboards and analytics
     - Manage alarms and notifications
     - Secure and reliable
     ```

---

### Phase 9: Privacy Policy (30 minutes)

**You MUST have a privacy policy URL.**

**Quick option:** Use a generator:
- https://www.privacypolicygenerator.info/
- https://www.freeprivacypolicy.com/

**Minimum requirements:**
```
Hoptech IoT Privacy Policy

Data Collection:
- Login credentials (stored on your ThingsBoard server only)
- Device information (for compatibility)

Data Usage:
- Connecting to your self-hosted ThingsBoard server
- No data shared with third parties
- No analytics or tracking

User Rights:
- All data stored on your ThingsBoard server
- You control all data
- App only acts as a client

Contact: [your-email]
```

Host it on:
- Your website
- GitHub Pages (free)
- Google Sites (free)

---

### Phase 10: Submit for Review (5 minutes)

**In Play Console:**

1. Review all sections (must be complete)
2. Click "Send for Review"
3. Wait 1-7 days for Google approval

**Common rejection reasons:**
- Missing privacy policy
- Incomplete content rating
- Low-quality screenshots
- Misleading description

---

## Quick Start Checklist

Use this to track your progress:

### Pre-Release
- [ ] Configure ThingsBoard server URL
- [ ] Create release keystore
- [ ] Configure app signing
- [ ] Build release AAB
- [ ] Test on emulator
- [ ] Test on physical device

### Play Store Prep
- [ ] Take 2-8 screenshots
- [ ] Create feature graphic (1024x500)
- [ ] Write app description
- [ ] Create privacy policy
- [ ] Host privacy policy online

### Play Console
- [ ] Create Play Console account ($25)
- [ ] Create app listing
- [ ] Complete content rating
- [ ] Fill data safety section
- [ ] Upload AAB file
- [ ] Submit for review

### Post-Submission
- [ ] Wait for approval (1-7 days)
- [ ] Test published app
- [ ] Monitor crash reports
- [ ] Respond to user reviews

---

## Alternative: Direct Distribution (Skip Play Store)

If you just want to use the app yourself:

**Build APK:**
```bash
fvm flutter build apk --release
```

**Install on your devices:**
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

**Or share the APK file:**
- Email it to yourself
- Put on USB drive
- Upload to your website

**Note:** Users need to enable "Install from Unknown Sources"

---

## Estimated Timeline

| Task | Time | Can Skip? |
|------|------|-----------|
| Configure server URL | 30 min | No |
| Create keystore | 10 min | No |
| Configure signing | 15 min | No |
| Build release | 10 min | No |
| Test release | 30 min | No |
| Prepare assets | 1 hour | No |
| Create Play account | 30 min | Only if new |
| Create listing | 30 min | No |
| Privacy policy | 30 min | No |
| Submit | 5 min | No |
| **Total** | **3-4 hours** | - |

Then wait 1-7 days for Google approval.

---

## Your Next Command

**Start with this:**

```bash
# 1. Configure your ThingsBoard server URL
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
nano lib/constants/app_constants.dart
# Update: static const thingsBoardApiEndpoint = 'https://your-server.com';

# 2. Create keystore
cd ~
keytool -genkey -v -keystore hoptech-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias hoptech-release

# 3. Configure signing (see Phase 3 above)

# 4. Build release
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
fvm flutter build appbundle --release
```

---

## Need Help?

**Documentation files in your project:**
- `DEPLOYMENT_CHECKLIST.md` - Detailed deployment guide
- `BUILD_GUIDE.md` - Build instructions
- `SUMMARY.md` - Complete overview

**Common issues:**
- **Build fails:** Check signing configuration
- **App crashes:** Test server URL is correct
- **Can't submit:** Check all Play Console sections are complete
- **Rejected:** Read rejection reason, fix, resubmit

---

## After Release

**Monitor:**
- Crash reports in Play Console
- User reviews and ratings
- App performance

**Update process:**
1. Increment version in `pubspec.yaml`
2. Make changes
3. Build new AAB: `fvm flutter build appbundle --release`
4. Upload to Play Console as new release
5. Add release notes

**You can update as often as you want!**

---

**Status:** Ready to start release process
**Time to completion:** 3-4 hours of work + 1-7 days approval
**Next step:** Configure your ThingsBoard server URL

Good luck! 🚀
