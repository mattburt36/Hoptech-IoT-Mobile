#!/bin/bash
# Quick script to apply logo sizing fixes

echo "Applying logo display fixes..."

# Fix 1: Login screen logo
sed -i '124,133s/height: 25,/height: 40,\n          fit: BoxFit.contain,/' lib/core/auth/login/login_page.dart

# Fix 2: Region selection logo  
sed -i '21s@SvgPicture.asset(ThingsboardImage.thingsboardBigLogo),@Padding(\n            padding: const EdgeInsets.all(24.0),\n            child: SvgPicture.asset(\n              ThingsboardImage.thingsboardBigLogo,\n              height: 150,\n              fit: BoxFit.contain,\n            ),\n          ),@' lib/core/auth/login/select_region/select_region_screen.dart

echo "✅ Logo fixes applied!"
echo "Run 'fvm flutter run' to see changes"
