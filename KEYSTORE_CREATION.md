# Creating Your Release Keystore - Step by Step

## What is a Keystore?

A keystore is a **digital certificate** that proves the app updates come from you. Google Play requires this to ensure no one else can update your app.

## ⚠️ CRITICAL WARNINGS

**READ THIS CAREFULLY:**

1. **You can NEVER recover this password** if you lose it
2. **You can NEVER update your app** if you lose the keystore file
3. **You MUST use this same keystore** for ALL future updates
4. **Backup the keystore file** immediately after creating it
5. **Store the password** in a password manager RIGHT NOW

If you lose either one, your app is dead. You'll have to:
- Unpublish the old app
- Create entirely new app with new package name
- Lose all reviews, ratings, and downloads
- Start from scratch

**Don't skip the backup step!**

---

## Creating the Keystore

### Option 1: Automated (Recommended)

I've created a helper script for you:

```bash
/tmp/create-keystore-simple.sh
```

**What it does:**
1. Asks for a password (you create it)
2. Asks organizational questions
3. Creates the keystore
4. Automatically creates a backup
5. Shows you what to do next

**When prompted for password:**
- Use at least 8 characters
- Include letters, numbers, special characters
- Example: `Hoptech2026!IoT`
- **WRITE IT DOWN IMMEDIATELY**

**When prompted for information:**
- First and last name: `Hoptech` or your name
- Organizational unit: `Development`
- Organization: `Hoptech`
- City: `Auckland` (or your city)
- State: `Auckland` (or your region)
- Country code: `NZ`
- Confirm: `yes`
- Key password: Just press **ENTER** (same as keystore)

---

### Option 2: Manual Command

If you prefer to do it manually:

```bash
keytool -genkey -v -keystore ~/hoptech-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias hoptech-release
```

Follow the same prompts as above.

---

## After Creation

### Immediate Steps (DO NOT SKIP!)

**1. Verify keystore was created:**
```bash
ls -lh ~/hoptech-release.jks
```

You should see a file around 2-3 KB.

**2. Create backup:**
```bash
cp ~/hoptech-release.jks ~/hoptech-release-BACKUP.jks
```

**3. Store password:**
- Open your password manager (LastPass, 1Password, etc.)
- Create new entry: "Hoptech IoT Release Keystore"
- Save the password you just created
- Add note: "Used for signing Android app releases"

**4. Backup the keystore file to multiple locations:**

```bash
# Copy to cloud storage
cp ~/hoptech-release.jks ~/Dropbox/hoptech-release.jks
# Or
cp ~/hoptech-release.jks ~/Google\ Drive/hoptech-release.jks

# Copy to USB drive
cp ~/hoptech-release.jks /media/usb-drive/hoptech-release.jks

# Email to yourself
# (Attach the .jks file to an email)
```

**5. Test the keystore:**
```bash
keytool -list -v -keystore ~/hoptech-release.jks
# Enter your password when prompted
```

You should see details about the key including:
- Alias: hoptech-release
- Valid for: 10,000 days (~27 years)
- Algorithm: RSA
- Owner: CN=Hoptech (or what you entered)

---

## Troubleshooting

### "keytool: command not found"

Java is not installed or not in PATH. Install it:
```bash
sudo zypper install java-17-openjdk
# or
sudo apt install openjdk-17-jdk
```

### "Password is too short"

Minimum 6 characters required. Use a longer, stronger password.

### "Keystore file already exists"

You already have one! Check:
```bash
ls -lh ~/hoptech-release.jks
```

If you want to create a new one (NOT recommended):
```bash
rm ~/hoptech-release.jks
# Then run creation command again
```

### Lost the password?

**Unfortunately, there's NO WAY to recover it.** This is why backing up and saving the password is so critical.

---

## Security Best Practices

**DO:**
- ✅ Use a strong, unique password
- ✅ Store password in a password manager
- ✅ Keep multiple backups in different locations
- ✅ Use the same keystore for all versions
- ✅ Keep the keystore file private

**DON'T:**
- ❌ Commit keystore to git/GitHub
- ❌ Share keystore file with others
- ❌ Use a simple or common password
- ❌ Store password in plain text
- ❌ Forget to backup!

---

## After Keystore Creation

Once you have the keystore created and backed up, proceed to:

**Next Step: Configure App Signing**

See: `SIGNING_CONFIGURATION.md` (creating next)

---

## Keystore Information

**File location:** `~/hoptech-release.jks`
**Backup location:** `~/hoptech-release-BACKUP.jks`
**Alias:** `hoptech-release`
**Validity:** 27+ years
**Algorithm:** RSA 2048-bit
**Use:** Sign all Hoptech IoT releases

---

## Quick Reference

**Create keystore:**
```bash
/tmp/create-keystore-simple.sh
```

**List keystore info:**
```bash
keytool -list -v -keystore ~/hoptech-release.jks
```

**Verify password works:**
```bash
keytool -list -keystore ~/hoptech-release.jks
# If password is correct, it shows key details
```

---

## Checklist

After creating keystore, verify:

- [ ] Keystore file exists: `~/hoptech-release.jks`
- [ ] Backup created: `~/hoptech-release-BACKUP.jks`
- [ ] Password saved in password manager
- [ ] Backup copied to cloud storage
- [ ] Backup copied to USB drive
- [ ] Backup emailed to yourself
- [ ] Can list keystore contents (password works)
- [ ] Ready for next step: signing configuration

---

**Status:** Waiting for keystore creation
**Command:** `/tmp/create-keystore-simple.sh`
**Next:** Configure app signing in build.gradle
