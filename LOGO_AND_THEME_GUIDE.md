# Logo and Theme Customization Guide

## Problem: Logo Overlap / Not Showing Completely

The logo may appear cut off or overlapping in some screens. Here's how to fix it:

### Solution 1: Add Padding to Logo Display

The logo is displayed in two main places:

#### A. Login Screen (Line 124-133 in `lib/core/auth/login/login_page.dart`)

Current code:
```dart
SvgPicture.asset(
  ThingsboardImage.thingsBoardWithTitle,
  height: 25,
  colorFilter: ColorFilter.mode(
    Theme.of(context).primaryColor,
    BlendMode.srcIn,
  ),
  semanticsLabel: S.of(context).logoDefaultValue,
),
```

**Fix Options:**

**Option 1: Add explicit dimensions**
```dart
SvgPicture.asset(
  ThingsboardImage.thingsBoardWithTitle,
  height: 40,  // Increase from 25
  width: 200,  // Add explicit width
  fit: BoxFit.contain,  // Ensure logo fits within bounds
  colorFilter: ColorFilter.mode(
    Theme.of(context).primaryColor,
    BlendMode.srcIn,
  ),
  semanticsLabel: S.of(context).logoDefaultValue,
),
```

**Option 2: Wrap in Container with padding**
```dart
Container(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  child: SvgPicture.asset(
    ThingsboardImage.thingsBoardWithTitle,
    height: 40,
    fit: BoxFit.contain,
    colorFilter: ColorFilter.mode(
      Theme.of(context).primaryColor,
      BlendMode.srcIn,
    ),
    semanticsLabel: S.of(context).logoDefaultValue,
  ),
),
```

**Option 3: Remove color filter (if it's causing issues)**
```dart
SvgPicture.asset(
  ThingsboardImage.thingsBoardWithTitle,
  height: 40,
  width: 200,
  fit: BoxFit.contain,
  // Remove colorFilter to show logo in original colors
  semanticsLabel: S.of(context).logoDefaultValue,
),
```

#### B. Region Selection Screen (Line 21 in `lib/core/auth/login/select_region/select_region_screen.dart`)

Current code:
```dart
SvgPicture.asset(ThingsboardImage.thingsboardBigLogo),
```

**Fix Options:**

**Option 1: Add size constraints and padding**
```dart
Padding(
  padding: const EdgeInsets.all(24.0),
  child: SvgPicture.asset(
    ThingsboardImage.thingsboardBigLogo,
    height: 120,
    width: 120,
    fit: BoxFit.contain,
  ),
),
```

**Option 2: Use AspectRatio to maintain proportions**
```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 40.0),
  child: AspectRatio(
    aspectRatio: 1.0,  // For square logo
    child: SvgPicture.asset(
      ThingsboardImage.thingsboardBigLogo,
      fit: BoxFit.contain,
    ),
  ),
),
```

### Solution 2: Modify the Logo SVG File

If the logo itself has too much white space or the viewBox is wrong:

```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Check current SVG viewBox
head -5 assets/images/hoptech_with_title.svg

# Edit the SVG to adjust viewBox or add padding
inkscape assets/images/hoptech_with_title.svg
```

In Inkscape:
1. File → Document Properties
2. Resize page to drawing or selection
3. Add margin if needed
4. Save

Or use command line:
```bash
# Add padding to SVG
inkscape assets/images/hoptech_with_title.svg \
  --export-area-page \
  --export-margin=20 \
  -o assets/images/hoptech_with_title_padded.svg
```

---

## Changing Color Scheme to Dark Grey / Silver

### Quick Method: Update Theme Colors

Edit `lib/config/themes/tb_theme.dart`:

```dart
// REPLACE lines 4-10 with:

// Dark grey / Silver color scheme
const int _tbPrimaryColorValue = 0xFF37474F;  // Dark grey-blue
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF78909C);  // Medium grey-blue
const Color _tbDarkPrimaryColor = Color(0xFFB0BEC5);  // Light silver-grey
Color get appPrimaryColor => _tbPrimaryColor;
const int _tbTextColorValue = 0xFF212121;  // Dark grey text
const Color _tbTextColor = Color(_tbTextColorValue);
```

### Alternative Dark Grey / Silver Palettes

**Option 1: Cool Grey / Silver**
```dart
const int _tbPrimaryColorValue = 0xFF455A64;  // Blue grey 700
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF90A4AE);  // Blue grey 300
const Color _tbDarkPrimaryColor = Color(0xFFCFD8DC);  // Blue grey 100
const Color _tbTextColor = Color(0xFF263238);  // Blue grey 900
```

**Option 2: Warm Grey / Silver**
```dart
const int _tbPrimaryColorValue = 0xFF616161;  // Grey 700
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF9E9E9E);  // Grey 500
const Color _tbDarkPrimaryColor = Color(0xFFE0E0E0);  // Grey 300
const Color _tbTextColor = Color(0xFF212121);  // Grey 900
```

**Option 3: Charcoal / Platinum**
```dart
const int _tbPrimaryColorValue = 0xFF37474F;  // Charcoal
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF546E7A);  // Dark silver
const Color _tbDarkPrimaryColor = Color(0xFFCFD8DC);  // Platinum
const Color _tbTextColor = Color(0xFF1C1C1C);  // Almost black
```

### Update Material Color Swatch

After changing primary colors, update the MaterialColor definition (lines 14-38):

```dart
const tbMatIndigo = MaterialColor(_tbPrimaryColorValue, <int, Color>{
  50: Color(0xFFECEFF1),   // Lightest
  100: Color(0xFFCFD8DC),
  200: Color(0xFFB0BEC5),
  300: Color(0xFF90A4AE),
  400: Color(0xFF78909C),
  500: _tbPrimaryColor,     // Main color
  600: _tbSecondaryColor,
  700: Color(0xFF455A64),
  800: Color(0xFF37474F),
  900: Color(0xFF263238),   // Darkest
});
```

### Complete Dark Grey Theme Example

Replace the entire theme section in `lib/config/themes/tb_theme.dart`:

```dart
// Dark Grey / Silver Color Scheme
const int _tbPrimaryColorValue = 0xFF37474F;
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF78909C);
const Color _tbDarkPrimaryColor = Color(0xFFB0BEC5);
Color get appPrimaryColor => _tbPrimaryColor;
const int _tbTextColorValue = 0xFF212121;
const Color _tbTextColor = Color(_tbTextColorValue);
const Color _tbAccentColor = Color(0xFFC0C0C0);  // Silver accent

Typography tbTypography = Typography.material2018();

const tbMatIndigo = MaterialColor(_tbPrimaryColorValue, <int, Color>{
  50: Color(0xFFECEFF1),
  100: Color(0xFFCFD8DC),
  200: Color(0xFFB0BEC5),
  300: Color(0xFF90A4AE),
  400: Color(0xFF78909C),
  500: _tbPrimaryColor,
  600: _tbSecondaryColor,
  700: Color(0xFF455A64),
  800: Color(0xFF37474F),
  900: Color(0xFF263238),
});

const tbDarkMatIndigo = MaterialColor(_tbPrimaryColorValue, <int, Color>{
  50: Color(0xFFECEFF1),
  100: Color(0xFFCFD8DC),
  200: Color(0xFFB0BEC5),
  300: Color(0xFF90A4AE),
  400: Color(0xFF78909C),
  500: _tbDarkPrimaryColor,
  600: _tbSecondaryColor,
  700: Color(0xFF455A64),
  800: _tbPrimaryColor,
  900: Color(0xFF263238),
});

final ThemeData theme = ThemeData(primarySwatch: tbMatIndigo);

ThemeData tbTheme = ThemeData(
  useMaterial3: false,
  primarySwatch: tbMatIndigo,
  colorScheme: theme.colorScheme.copyWith(
    primary: _tbPrimaryColor,
    secondary: _tbAccentColor,
    surface: const Color(0xFFF5F5F5),  // Light grey background
  ),
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  textTheme: tbTypography.black,
  primaryTextTheme: tbTypography.black,
  typography: tbTypography,
  appBarTheme: AppBarTheme(
    backgroundColor: _tbPrimaryColor,  // Dark grey app bar
    foregroundColor: Colors.white,     // White text on dark grey
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: _tbPrimaryColor,
    selectedItemColor: _tbAccentColor,  // Silver for selected
    unselectedItemColor: Colors.grey.shade400,
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.iOS: FadeOpenPageTransitionsBuilder(),
      TargetPlatform.android: FadeOpenPageTransitionsBuilder(),
    },
  ),
);

ThemeData tbDarkTheme = ThemeData(
  primarySwatch: tbDarkMatIndigo,
  colorScheme: darkTheme.colorScheme.copyWith(
    primary: _tbDarkPrimaryColor,
    secondary: _tbAccentColor,
  ),
  brightness: Brightness.dark,
);
```

---

## Testing Your Changes

### 1. Quick Test with Hot Reload

```bash
# With app already running:
# 1. Make changes to theme file
# 2. Save the file
# 3. Press 'r' in the terminal for hot reload
# 4. Or press 'R' for hot restart
```

### 2. Full Rebuild

```bash
cd /home/matt/src/Hoptech/Mobile/Hoptech-IoT-Mobile

# Clean and rebuild
fvm flutter clean
fvm flutter pub get
fvm flutter run
```

### 3. Check Different Screens

Navigate through these screens to verify logo display:
- Login screen
- Region selection
- Main dashboard
- Settings

---

## Quick Fixes to Apply Now

### Fix 1: Adjust Login Screen Logo

Edit `lib/core/auth/login/login_page.dart` (around line 124):

```dart
// FIND:
SvgPicture.asset(
  ThingsboardImage.thingsBoardWithTitle,
  height: 25,
  colorFilter: ColorFilter.mode(
    Theme.of(context).primaryColor,
    BlendMode.srcIn,
  ),
  semanticsLabel: S.of(context).logoDefaultValue,
),

// REPLACE WITH:
Padding(
  padding: const EdgeInsets.all(8.0),
  child: SvgPicture.asset(
    ThingsboardImage.thingsBoardWithTitle,
    height: 40,
    fit: BoxFit.contain,
    colorFilter: ColorFilter.mode(
      Theme.of(context).primaryColor,
      BlendMode.srcIn,
    ),
    semanticsLabel: S.of(context).logoDefaultValue,
  ),
),
```

### Fix 2: Adjust Region Selection Logo

Edit `lib/core/auth/login/select_region/select_region_screen.dart` (line 21):

```dart
// FIND:
SvgPicture.asset(ThingsboardImage.thingsboardBigLogo),

// REPLACE WITH:
Padding(
  padding: const EdgeInsets.all(24.0),
  child: SvgPicture.asset(
    ThingsboardImage.thingsboardBigLogo,
    height: 150,
    fit: BoxFit.contain,
  ),
),
```

### Fix 3: Apply Dark Grey Theme

Edit `lib/config/themes/tb_theme.dart` (lines 4-6):

```dart
// FIND:
const int _tbPrimaryColorValue = 0xFF305680;
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF527dad);

// REPLACE WITH:
const int _tbPrimaryColorValue = 0xFF37474F;  // Dark grey
const Color _tbPrimaryColor = Color(_tbPrimaryColorValue);
const Color _tbSecondaryColor = Color(0xFF78909C);  // Medium grey
```

---

## Color Picker Tool

To experiment with colors visually:

1. **Online:** https://material.io/resources/color/
2. **Command line:** 
   ```bash
   # Get hex color from RGB
   printf '#%02X%02X%02X\n' 55 71 79  # Outputs: #37474F
   ```

3. **In Dart format:**
   - Hex `#37474F` → Dart `0xFF37474F`
   - Always prefix with `0xFF` for opacity

---

## Applying Changes

```bash
# 1. Make your edits to the files above
# 2. If app is running, press 'R' for hot restart
# 3. Or rebuild:
fvm flutter run
```

## Preview Before Building Release

Test on emulator:
```bash
# Start emulator
~/Android/Sdk/emulator/emulator -avd hoptech_dev &

# Run app
fvm flutter run

# Test all screens:
# - Login page (check logo size and color)
# - Region selection (check big logo)
# - Main screens (check theme colors)
# - Settings (check consistency)
```

Take screenshots at each stage:
```bash
~/Android/Sdk/platform-tools/adb exec-out screencap -p > screenshot_login.png
```

---

## Common Issues

**Issue: Logo still cut off**
- Increase `height` value more (try 50, 60, etc.)
- Add more padding
- Check SVG viewBox in the file itself

**Issue: Colors not updating**
- Press 'R' (capital R) for full restart
- If still not working, do `fvm flutter clean && fvm flutter run`

**Issue: Logo is white/invisible**
- Remove the `colorFilter` to see logo in original colors
- Or adjust the filter color

**Issue: Text unreadable on new background**
- Adjust `_tbTextColor` constant
- Check AppBar `foregroundColor`
- Update `bottomNavigationBarTheme` colors

---

## Files to Edit

1. **Logo sizing:**
   - `lib/core/auth/login/login_page.dart`
   - `lib/core/auth/login/select_region/select_region_screen.dart`

2. **Color scheme:**
   - `lib/config/themes/tb_theme.dart`

3. **Logo files** (if needed):
   - `assets/images/hoptech_with_title.svg`
   - `assets/images/hoptech_big_logo.svg`
