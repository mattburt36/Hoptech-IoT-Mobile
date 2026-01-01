# Hoptech IoT - Complete Rebranding Guide

## Overview
This guide covers the complete rebranding of the ThingsBoard mobile app to Hoptech IoT, including all logos, text references, and visual assets.

## Rebranding Status

### ✅ Already Completed
- [x] Package name changed: `org.thingsboard.app` → `io.hoptech.iot`
- [x] App launcher icons replaced with Hoptech logo
- [x] Splash screens replaced with Hoptech logo
- [x] Android app name: `Hoptech IoT`
- [x] pubspec.yaml name: `hoptech_iot_app`

### 🔄 To Be Done
- [ ] Replace in-app logo images
- [ ] Update app title in localizations
- [ ] Replace ThingsBoard logo references
- [ ] Update about/settings screens
- [ ] Remove/replace "ThingsBoard" text throughout the app
- [ ] Update color scheme (optional)

## Logo Assets Inventory

### Available Hoptech Logos
Located in `/home/matt/src/Hoptech/Random/Logo/`:
- `Logo.svg` - Full Hoptech logo (140KB)
- `Logo-text.svg` - Logo with text (8.2KB)
- `Logo-bun.svg` - Logo variant (141KB)

### Assets to Replace

#### 1. App Icons & Splash (✅ DONE)
- `assets/branding/icon_filled.png`
- `assets/branding/icon_foreground.png`
- `assets/branding/icon_monochrome.png`
- `assets/branding/splash.png`
- `assets/branding/splash_android_12.png`

#### 2. In-App Logo Images (TODO)
Replace these ThingsBoard logo files:
- `assets/images/thingsboard.svg` → Main logo
- `assets/images/thingsboard.png` → PNG version
- `assets/images/thingsboard_with_title.svg` → Logo with text
- `assets/images/thingsboard_big_logo.svg` → Large logo
- `assets/images/thingsboard_center.svg` → Center element
- `assets/images/thingsboard_outer.svg` → Outer element

#### 3. Code References
File: `lib/constants/assets_path.dart`
```dart
abstract class ThingsboardImage {
  // Change these references to Hoptech logos
  static const thingsBoardWithTitle = 'assets/images/hoptech_with_title.svg';
  static const thingsboard = 'assets/images/hoptech.svg';
  static const thingsboardBigLogo = 'assets/images/hoptech_big_logo.svg';
  // ... etc
}
```

#### 4. Localization Files
Update all `.arb` files in `lib/l10n/`:
- `intl_en.arb` - English
- `intl_ar.arb` - Arabic
- `intl_zh.arb` - Chinese (Simplified)
- `intl_zh_CN.arb` - Chinese (China)
- `intl_zh_TW.arb` - Chinese (Taiwan)

Change:
```json
"appTitle": "ThingsBoard" → "Hoptech IoT"
"logoDefaultValue": "ThingsBoard Logo" → "Hoptech IoT Logo"
```

## Step-by-Step Rebranding Process

### Step 1: Prepare Logo Variants

Create different logo versions for different uses:

```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Main logo (square, for general use)
inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  -w 512 -h 512 -o assets/images/hoptech.png

inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  -w 512 -h 512 -o assets/images/hoptech.svg --export-plain-svg

# Logo with title (wide, for login screen)
cp /home/matt/src/Hoptech/Random/Logo/Logo-text.svg \
  assets/images/hoptech_with_title.svg

# Big logo (for splash/onboarding)
inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  -w 1024 -h 1024 -o assets/images/hoptech_big_logo.svg --export-plain-svg

# Optional: Center and outer elements if needed
cp /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  assets/images/hoptech_center.svg
cp /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  assets/images/hoptech_outer.svg
```

### Step 2: Update Asset References

Edit `lib/constants/assets_path.dart`:
```dart
abstract class HoptechImage {  // Rename class
  static const hoptechWithTitle = 'assets/images/hoptech_with_title.svg';
  static const hoptech = 'assets/images/hoptech.svg';
  static const hoptechOuter = 'assets/images/hoptech_outer.svg';
  static const hoptechCenter = 'assets/images/hoptech_center.svg';
  static const hoptechBigLogo = 'assets/images/hoptech_big_logo.svg';
  // Keep other assets unchanged
}
```

### Step 3: Update All References

Find and replace across the codebase:
```bash
# Find all references to ThingsboardImage
grep -r "ThingsboardImage" lib/ --include="*.dart"

# Replace in code (will need manual review)
find lib -name "*.dart" -exec sed -i 's/ThingsboardImage\.thingsboard/HoptechImage.hoptech/g' {} +
find lib -name "*.dart" -exec sed -i 's/ThingsboardImage/HoptechImage/g' {} +
```

### Step 4: Update Localizations

For each `.arb` file in `lib/l10n/`:
```json
{
  "appTitle": "Hoptech IoT",
  "logoDefaultValue": "Hoptech IoT Logo",
  "accountActivatedText": "Congratulations!\nYour Hoptech IoT account has been activated.\nNow you can login to your Hoptech IoT space."
}
```

### Step 5: Regenerate Localization Code

```bash
fvm flutter pub get
fvm flutter gen-l10n
```

### Step 6: Search for Remaining Text References

```bash
# Find remaining "ThingsBoard" text references
grep -r "ThingsBoard" lib/ --include="*.dart" | grep -v "import\|package\|//"

# Common places to check:
# - About screens
# - Settings
# - Login/signup flows
# - Error messages
# - Help text
```

### Step 7: Optional - Update Color Scheme

If you want to match Hoptech branding colors, update:
`lib/config/themes/tb_theme.dart` or similar theme files.

Example:
```dart
// Primary color
primaryColor: Color(0xFFYourColor),

// Accent color
accentColor: Color(0xFFYourAccent),
```

### Step 8: Test All Screens

Run the app and check:
- [ ] Login screen shows Hoptech logo
- [ ] Splash screen shows Hoptech branding
- [ ] Settings/About shows Hoptech name
- [ ] All menu items reference Hoptech
- [ ] No "ThingsBoard" text visible

### Step 9: Clean Build

```bash
fvm flutter clean
fvm flutter pub get
fvm flutter build apk --debug
```

## Files That Need Changes

### Critical Files
1. `lib/constants/assets_path.dart` - Logo path constants
2. `lib/l10n/intl_*.arb` - All localization files
3. `lib/generated/l10n.dart` - Auto-generated (will update after arb changes)

### Asset Files
4. `assets/images/thingsboard*.svg` - Replace with Hoptech logos
5. `assets/images/thingsboard.png` - Replace with Hoptech PNG

### Search & Replace Targets
- Class name: `ThingsboardImage` → `HoptechImage`
- Variable references: `thingsboard` → `hoptech`
- Text strings: `"ThingsBoard"` → `"Hoptech IoT"`

## Quick Commands

### Generate all logo variants at once:
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
mkdir -p assets/images/hoptech_variants

# Create all variants
for size in 256 512 1024; do
  inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
    -w $size -h $size \
    -o assets/images/hoptech_variants/hoptech_${size}.png
done

# Copy SVG versions
cp /home/matt/src/Hoptech/Random/Logo/Logo.svg assets/images/hoptech.svg
cp /home/matt/src/Hoptech/Random/Logo/Logo-text.svg assets/images/hoptech_with_title.svg
```

### Find all ThingsBoard references:
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile
grep -r -i "thingsboard" lib/ assets/ android/ ios/ \
  --include="*.dart" \
  --include="*.arb" \
  --include="*.xml" \
  --include="*.plist" \
  | grep -v "package:" \
  | grep -v "import" \
  > thingsboard_references.txt
```

### Replace text in all localization files:
```bash
cd lib/l10n
for file in *.arb; do
  sed -i 's/"ThingsBoard"/"Hoptech IoT"/g' "$file"
  sed -i 's/"ThingsBoard Logo"/"Hoptech IoT Logo"/g' "$file"
done
```

## Testing Checklist

After rebranding, test these screens:
- [ ] App launches with Hoptech splash
- [ ] Login screen shows Hoptech logo
- [ ] Main dashboard displays correctly
- [ ] Settings/About shows "Hoptech IoT"
- [ ] Device screens function normally
- [ ] No crash on logo display
- [ ] All languages show "Hoptech IoT" correctly

## Post-Rebranding

1. **Take screenshots** for app store listing
2. **Update README.md** with new branding
3. **Update any documentation** references
4. **Build release APK/AAB** for distribution
5. **Test on multiple devices**

## Rollback Plan

If issues occur:
```bash
git checkout lib/constants/assets_path.dart
git checkout lib/l10n/
git checkout assets/images/
fvm flutter clean && fvm flutter pub get
```

## Notes

- Keep backup of original ThingsBoard logos in case you need reference
- Some screens might use hardcoded "ThingsBoard" text
- Check for any external links to ThingsBoard documentation
- Update any email templates or notifications that reference ThingsBoard
- Consider updating app description and keywords for app stores

## Support

For issues or questions during rebranding:
- Check `git diff` to see what changed
- Use `flutter analyze` to find compilation errors
- Search for TODO comments added during rebranding
