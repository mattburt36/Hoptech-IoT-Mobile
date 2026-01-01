# Google Play Store Submission - Complete Guide

## 🚀 You're Ready! Here's Your Checklist

### What You Already Have:
✅ Signed app bundle: `app-release.aab` (46 MB)
✅ Keystore secured and backed up
✅ App fully tested and working
✅ Google Play Developer account

---

## Step-by-Step Submission Process

### Step 1: Gather Required Assets (30-45 minutes)

#### A. Screenshots (REQUIRED - minimum 2, maximum 8)

**Take screenshots from your running app:**

```bash
# Create directory for assets
mkdir -p ~/hoptech-play-store

# Start emulator if not running
~/Android/Sdk/emulator/emulator -avd hoptech_dev &

# Wait for boot, then install and run your app
~/Android/Sdk/platform-tools/adb install \
  build/app/outputs/flutter-apk/app-release.apk

# Navigate to different screens and capture:

# 1. Login/Splash screen
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-play-store/01-login.png

# 2. Dashboard
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-play-store/02-dashboard.png

# 3. Device list
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-play-store/03-devices.png

# 4. Device details
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-play-store/04-device-details.png

# 5. Alarms (optional)
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-play-store/05-alarms.png

# 6. Settings (optional)
~/Android/Sdk/platform-tools/adb exec-out screencap -p > \
  ~/hoptech-play-store/06-settings.png
```

**Screenshot Requirements:**
- Minimum: 2 screenshots
- Maximum: 8 screenshots
- Size: 320-3840 pixels (longest side)
- Format: PNG or JPEG
- Show actual app content (no mockups)

#### B. App Icon - 512x512 PNG (REQUIRED)

```bash
# Copy your existing icon
cp assets/branding/icon_filled.png \
  ~/hoptech-play-store/icon-512x512.png

# Verify size
identify ~/hoptech-play-store/icon-512x512.png
# Should show: 512x512
```

#### C. Feature Graphic - 1024x500 PNG (REQUIRED)

**Option 1: Quick creation with ImageMagick:**
```bash
magick -size 1024x500 xc:#37474F \
  -font Arial -pointsize 72 -fill white \
  -gravity center -annotate +0-40 "Hoptech IoT" \
  -font Arial -pointsize 32 -fill "#B0BEC5" \
  -gravity center -annotate +0+40 "IoT Device Management" \
  ~/hoptech-play-store/feature-graphic.png

# Then add your logo using GIMP or online editor
```

**Option 2: Use Canva (recommended):**
1. Go to canva.com
2. Create custom size: 1024 x 500
3. Add your Hoptech logo
4. Add text: "Hoptech IoT" and tagline
5. Use dark grey background (#37474F)
6. Download as PNG

**Feature Graphic Requirements:**
- Exact size: 1024 x 500 pixels
- Format: PNG or JPEG
- No transparency
- No excessive text (logo + name is fine)

#### D. Privacy Policy (REQUIRED)

**Create your privacy policy:**

1. Use a generator: https://www.privacypolicygenerator.info/

2. Fill in:
   - App name: Hoptech IoT
   - Website: your-website.com
   - Country: New Zealand
   - Type: Mobile App

3. Add these specifics:
```
Hoptech IoT Privacy Policy

Last updated: January 1, 2026

Data Collection:
- Login credentials (username/password)
- Device information for compatibility
- Usage data for app functionality

Data Usage:
- All data is transmitted to your self-hosted ThingsBoard server
- Server address: iot.hoptech.co.nz
- No data is stored on our servers
- No third-party sharing
- No analytics or tracking services

User Rights:
- All IoT data is controlled by you
- Data stored on your ThingsBoard instance
- App acts only as a client application

Security:
- All connections use HTTPS/TLS encryption
- Credentials stored securely on device
- No cloud storage of user data

Contact:
Email: support@hoptech.co.nz
Organization: Hoptech Limited
Location: New Zealand
```

4. **Host the privacy policy:**
   - Option A: Your website at https://hoptech.co.nz/privacy
   - Option B: GitHub Pages (free)
   - Option C: Google Sites (free)

**GitHub Pages (quick and free):**
```bash
# Create a simple privacy page
cat > privacy.html << 'PRIVACY'
<!DOCTYPE html>
<html>
<head>
    <title>Hoptech IoT - Privacy Policy</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 40px auto; padding: 20px; }
        h1 { color: #37474F; }
        h2 { color: #78909C; margin-top: 30px; }
    </style>
</head>
<body>
    <h1>Hoptech IoT - Privacy Policy</h1>
    <p><strong>Last updated: January 1, 2026</strong></p>
    
    <h2>Data Collection</h2>
    <p>Hoptech IoT collects:</p>
    <ul>
        <li>Login credentials for your ThingsBoard server</li>
        <li>Device information for compatibility</li>
        <li>Usage data for app functionality</li>
    </ul>
    
    <h2>Data Usage</h2>
    <ul>
        <li>All data transmitted to your self-hosted ThingsBoard server at iot.hoptech.co.nz</li>
        <li>No data stored on Hoptech servers</li>
        <li>No third-party data sharing</li>
        <li>No analytics or tracking</li>
    </ul>
    
    <h2>User Rights</h2>
    <p>All IoT data is controlled by you and stored on your ThingsBoard instance. 
    The app acts only as a client application.</p>
    
    <h2>Security</h2>
    <ul>
        <li>HTTPS/TLS encryption for all connections</li>
        <li>Secure credential storage on device</li>
        <li>No cloud storage of user data</li>
    </ul>
    
    <h2>Contact</h2>
    <p>Email: support@hoptech.co.nz<br>
    Organization: Hoptech Limited<br>
    Location: New Zealand</p>
</body>
</html>
PRIVACY

echo "Privacy policy created: privacy.html"
echo "Upload this to your website or GitHub Pages"
```

---

### Step 2: Create Play Console Listing (30 minutes)

#### A. Go to Play Console

1. Visit: https://play.google.com/console
2. Sign in with your Google account
3. Accept developer terms if first time

#### B. Create New App

1. Click **"Create app"**
2. Fill in:
   - **App name:** Hoptech IoT
   - **Default language:** English (United States)
   - **App or game:** App
   - **Free or paid:** Free
3. Check declarations boxes
4. Click **"Create app"**

#### C. Store Listing

Navigate to **Store presence** → **Main store listing**

**App details:**
```
App name: Hoptech IoT

Short description (80 characters max):
IoT device management and monitoring powered by ThingsBoard platform

Full description:
Hoptech IoT is your comprehensive mobile solution for managing and monitoring IoT devices powered by the ThingsBoard platform.

KEY FEATURES
• Real-time device monitoring and control
• Interactive dashboards with live data visualization
• Alarm management and notifications
• Asset tracking and organization
• Customer management capabilities
• Comprehensive audit logs
• Multi-language support (English, Arabic, Chinese)

PERFECT FOR
✓ Industrial IoT deployments
✓ Smart building management
✓ Fleet monitoring and tracking
✓ Energy management systems
✓ Environmental monitoring
✓ Any ThingsBoard-powered IoT solution

REQUIREMENTS
Requires connection to a ThingsBoard server (self-hosted or cloud-based). This app acts as a mobile client for your ThingsBoard instance.

FEATURES IN DETAIL
Monitor your devices in real-time with live telemetry data, create and manage custom dashboards, receive instant alarm notifications, and control your IoT infrastructure from anywhere.

Connect to your ThingsBoard server at iot.hoptech.co.nz and manage your entire IoT infrastructure from your mobile device.

Secure, reliable, and easy to use - Hoptech IoT brings the full power of ThingsBoard to your fingertips.

Support: support@hoptech.co.nz
```

**App icon:** Upload `icon-512x512.png`

**Feature graphic:** Upload `feature-graphic.png` (1024x500)

**Phone screenshots:** Upload 2-8 screenshots

**App category:** Business

**Store listing contact details:**
- Email: support@hoptech.co.nz (or your email)
- Website: https://hoptech.co.nz (optional)
- Phone: (optional)

**Privacy policy:** Paste your privacy policy URL

Click **Save**

#### D. Content Rating

Navigate to **Content rating**

1. Click **Start questionnaire**
2. Enter email: your-email@hoptech.co.nz
3. Select category: **Utility, Productivity, Communication**
4. Answer questions:
   - Violence: No
   - Sexuality: No
   - Language: No
   - Controlled substances: No
   - Gambling: No
   - User interaction: Yes (for IoT device control)
5. Review and submit
6. Should receive rating: **Everyone**

Click **Apply rating**

#### E. App Content

Navigate to **App content**

Complete these sections:

**1. Privacy policy:**
- Already filled in store listing ✓

**2. App access:**
- Select: **All functionality is available without restrictions**
- Click **Save**

**3. Ads:**
- Select: **No, my app does not contain ads**
- Click **Save**

**4. Content declarations:**
Click **Manage** and complete:
- Does your app allow users to create content? **No**
- Click **Save**

**5. Data safety:**
This is IMPORTANT. Click **Start**

**Data collection and security:**
```
Does your app collect or share user data?
→ Yes

Data types collected:
→ Personal info: Email addresses (for login)
→ App activity: App interactions (usage)

Is data encrypted in transit?
→ Yes

Can users request data deletion?
→ Users should contact you (provide email)

Purpose of data collection:
→ App functionality

Data shared with third parties?
→ No

Click Next → Submit
```

**6. Government apps:**
- Select: **No, this is not a government app**

**7. Financial features:**
- Select: **No**

**8. Health:**
- Select: **No**

---

### Step 3: Upload Your App Bundle (10 minutes)

#### A. Create Production Release

1. Navigate to **Production** in left menu
2. Click **Create new release**

3. **App signing by Google Play:**
   - If prompted, choose **Continue** (recommended)
   - Google will re-sign your app with their key for better security

4. **Upload app bundle:**
   - Click **Upload**
   - Select: `build/app/outputs/bundle/release/app-release.aab`
   - Wait for upload (46 MB, ~1-2 minutes)

5. **Release name:** 
   ```
   1.0.0 (1)
   ```

6. **Release notes:**
   ```
   Initial release of Hoptech IoT

   Features:
   • Connect to your ThingsBoard server
   • Monitor IoT devices in real-time
   • View dashboards and analytics
   • Manage alarms and notifications
   • Control devices remotely
   • Track assets and customers
   • Full audit log access
   • Multi-language support

   Requirements:
   • ThingsBoard server (self-hosted or cloud)
   • Valid login credentials
   
   Support: support@hoptech.co.nz
   ```

7. Click **Save**

#### B. Review Release

1. **Countries/regions:**
   - Click **Add countries/regions**
   - Select countries where you want to release
   - Suggested: New Zealand, Australia, or **Available in all countries**
   - Click **Add**

2. **Review summary:**
   - Check all sections have green checkmarks
   - Review any warnings

3. **Rollout percentage:**
   - Keep at 100% for full release
   - Or select lower % for staged rollout

---

### Step 4: Submit for Review (5 minutes)

1. Navigate to **Publishing overview**

2. Check all sections:
   - ✅ Store listing complete
   - ✅ Content rating complete
   - ✅ App content complete
   - ✅ Production release ready

3. **Any warnings?**
   - Review and fix if critical
   - Some warnings are OK (Google will review)

4. Click **Send for review** or **Publish**

5. **Confirm:**
   - Review the submission
   - Click **Confirm**

---

### Step 5: Wait for Approval (1-7 days)

**What happens now:**

1. **Processing:** Google scans your app (1-2 hours)
2. **Review:** Human review by Google (1-7 days)
3. **Email notification:** You'll receive approval/rejection email

**Typical timeline:**
- **Best case:** 24 hours
- **Average:** 2-3 days
- **Worst case:** 7 days

**Common reasons for delay:**
- First-time developer (longer review)
- Complex app features
- Holiday periods
- High submission volume

---

## Troubleshooting

### Upload Issues

**"App bundle contains errors"**
- Check signing: keystore and passwords correct
- Rebuild: `fvm flutter build appbundle --release`

**"Version code already used"**
- Update version in `pubspec.yaml`
- Increment: `1.0.0+2` (the +2 is version code)

**"Upload failed"**
- Check internet connection
- Try different browser
- File size limit is 150MB (yours is 46MB - OK)

### Content Issues

**"Privacy policy not found"**
- Verify URL works in browser
- Must be HTTPS (secure)
- Must be publicly accessible

**"Screenshots required"**
- Need minimum 2 screenshots
- Check file format (PNG/JPEG)
- Check size (320-3840px)

**"Feature graphic invalid"**
- Must be exactly 1024x500
- No transparency
- PNG or JPEG only

---

## After Approval

### When App Goes Live

1. **Test the published version:**
   - Search "Hoptech IoT" in Play Store
   - Install on clean device
   - Verify everything works

2. **Monitor:**
   - Crash reports in Play Console
   - User reviews and ratings
   - Download statistics

3. **Respond to reviews:**
   - Reply to user feedback
   - Address issues promptly

### Future Updates

**To update your app:**

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # Increment both numbers
   ```

2. Rebuild:
   ```bash
   fvm flutter build appbundle --release
   ```

3. Upload to Play Console → Production
4. Add release notes describing changes
5. Submit for review (usually faster than initial)

---

## Quick Checklist

Before submitting, verify:

- [ ] AAB file ready (46 MB)
- [ ] 2-8 screenshots captured
- [ ] App icon 512x512 prepared
- [ ] Feature graphic 1024x500 created
- [ ] Privacy policy written and hosted
- [ ] Privacy policy URL accessible
- [ ] Store listing description written
- [ ] Release notes prepared
- [ ] Content rating completed
- [ ] Data safety form filled
- [ ] All Play Console sections complete
- [ ] Test build installed and verified

---

## Support Contact Info to Use

**In Play Console, use:**
```
Email: support@hoptech.co.nz
Organization: Hoptech Limited
Country: New Zealand
```

**Or use your actual details if different**

---

## Expected Costs

- **Developer account:** $25 (one-time, already paid ✓)
- **App submission:** Free
- **Updates:** Free
- **No recurring fees**

---

## Your Ready-to-Use Text

**Short description (copy/paste):**
```
IoT device management and monitoring powered by ThingsBoard platform
```

**Email for support:**
```
support@hoptech.co.nz
```

**Category:**
```
Business
```

---

**You're ready! Start at:** https://play.google.com/console

**Time estimate:** 1-2 hours setup + 1-7 days Google review

**Good luck! 🚀**
