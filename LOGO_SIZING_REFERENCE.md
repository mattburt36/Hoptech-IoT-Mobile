# Logo Sizing Quick Reference

## Current Logo Sizes (Updated)

### 1. Splash Screen (App Loading)
**Location:** Native splash screens (Android/iOS)
**Size:** 800x800 pixels centered in 1152x1152 canvas
**Padding:** 176px on all sides
**Status:** ✅ Fixed - Logo won't get cut off

**Files:**
- `assets/branding/splash.png`
- `assets/branding/splash_android_12.png`

### 2. Region Selection Screen
**Location:** `lib/core/auth/login/select_region/select_region_screen.dart`
**Max Height:** 120px
**Padding:** 40px horizontal, 24px vertical
**Constraints:** `ConstrainedBox` with maxHeight
**Status:** ✅ Fixed - Won't overflow screen

### 3. Login Screen Logo
**Location:** `lib/core/auth/login/login_page.dart`
**Height:** 40px
**Padding:** 8px all around
**Status:** ✅ Fixed - Displays fully with proper spacing

## If Logo Still Appears Cut Off

### For Splash Screen (App Load)
The splash screen logo is now 800x800 in a 1152x1152 canvas, leaving plenty of padding.

If you want even more padding:
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Create even smaller logo (600x600)
inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  --export-width=600 --export-height=600 \
  --export-background=white -o /tmp/logo_smaller.png

# Create splash with more padding
magick -size 1152x1152 xc:white /tmp/logo_smaller.png \
  -gravity center -composite assets/branding/splash.png

magick -size 1152x1152 xc:white /tmp/logo_smaller.png \
  -gravity center -composite assets/branding/splash_android_12.png

# Regenerate native splash
fvm flutter pub run flutter_native_splash:create
```

### For Region Selection Screen
If logo still too big, edit `lib/core/auth/login/select_region/select_region_screen.dart`:

**Current (line ~21-28):**
```dart
constraints: const BoxConstraints(
  maxHeight: 120,  // Try 100, 80, or 60
  maxWidth: double.infinity,
),
```

**Try smaller:**
```dart
constraints: const BoxConstraints(
  maxHeight: 100,  // Reduced from 120
  maxWidth: double.infinity,
),
```

### For Login Screen
Edit `lib/core/auth/login/login_page.dart` (line ~127):

**Current:**
```dart
height: 40,  // Try 35, 30, or 25
```

## Quick Size Adjustments

### Make ALL logos smaller by 20%
```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Region selection: 120 → 96
sed -i 's/maxHeight: 120/maxHeight: 96/' lib/core/auth/login/select_region/select_region_screen.dart

# Login screen: 40 → 32
sed -i 's/height: 40,/height: 32,/' lib/core/auth/login/login_page.dart

# Splash: 800 → 640
inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  --export-width=640 --export-height=640 \
  --export-background=white -o /tmp/logo_640.png
  
magick -size 1152x1152 xc:white /tmp/logo_640.png \
  -gravity center -composite assets/branding/splash.png
  
magick -size 1152x1152 xc:white /tmp/logo_640.png \
  -gravity center -composite assets/branding/splash_android_12.png

fvm flutter pub run flutter_native_splash:create
```

### Make ALL logos bigger by 20%
```bash
# Region selection: 120 → 144
sed -i 's/maxHeight: 120/maxHeight: 144/' lib/core/auth/login/select_region/select_region_screen.dart

# Login screen: 40 → 48
sed -i 's/height: 40,/height: 48,/' lib/core/auth/login/login_page.dart

# Splash: 800 → 960
inkscape /home/matt/src/Hoptech/Random/Logo/Logo.svg \
  --export-width=960 --export-height=960 \
  --export-background=white -o /tmp/logo_960.png
  
magick -size 1152x1152 xc:white /tmp/logo_960.png \
  -gravity center -composite assets/branding/splash.png
  
magick -size 1152x1152 xc:white /tmp/logo_960.png \
  -gravity center -composite assets/branding/splash_android_12.png

fvm flutter pub run flutter_native_splash:create
```

## Testing Changes

After making changes:

```bash
# For splash screen changes:
fvm flutter clean
fvm flutter run

# For code changes only:
# Just press 'R' in running app

# Verify splash:
# 1. Close app completely
# 2. Tap app icon
# 3. Watch the splash screen when app launches
```

## Current Settings Summary

| Screen | Size | Padding | Status |
|--------|------|---------|--------|
| Splash | 800x800 in 1152x1152 | 176px all sides | ✅ Won't cut off |
| Region Select | Max 120px height | 40px H, 24px V | ✅ Constrained |
| Login | 40px height | 8px all sides | ✅ Fits well |

## Files Modified

1. `assets/branding/splash.png` - Splash screen image (800x800 logo in 1152x1152 canvas)
2. `assets/branding/splash_android_12.png` - Android 12+ splash (same size)
3. `lib/core/auth/login/select_region/select_region_screen.dart` - Region screen (maxHeight: 120)
4. `lib/core/auth/login/login_page.dart` - Login screen (height: 40, padding: 8)

## Visual Comparison

### Before
- Splash: 1024x1024 logo in 1152x1152 → Only 64px padding each side
- Region: 150px height, no max constraint → Could overflow
- Result: Logo often cut off on smaller screens

### After  
- Splash: 800x800 logo in 1152x1152 → 176px padding each side
- Region: Max 120px height with ConstrainedBox → Never overflows
- Result: Logo always displays fully with comfortable padding

## Recommended Sizes for Different Devices

If logo looks too big on tablets or too small on phones:

### Phone-optimized (smaller)
- Splash: 700x700
- Region: maxHeight: 100
- Login: height: 35

### Tablet-optimized (larger)
- Splash: 900x900
- Region: maxHeight: 140
- Login: height: 45

### Current (balanced for all)
- Splash: 800x800
- Region: maxHeight: 120
- Login: height: 40

## Need Help?

1. **Logo too small?** Increase the numbers above
2. **Logo too big/cut off?** Decrease the numbers above
3. **Logo looks distorted?** Check the SVG file aspect ratio
4. **Changes not showing?** Run `fvm flutter clean` and rebuild

---

**Last Updated:** January 1, 2026
**Status:** ✅ Logo sizing optimized for all screens
