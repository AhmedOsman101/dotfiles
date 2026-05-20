# Readme

### Step 1: Export Your Key

```bash
# List your keys to get the key ID or fingerprint
gpg --list-secret-keys --keyid-format LONG

# Export the private key
gpg --export-secret-keys --armor YOUR_KEY_ID > master.private.asc

# Also export the public key (good practice)
gpg --export --armor YOUR_KEY_ID > master.public.asc

# Also export your trust database
gpg --export-ownertrust > ownertrust.txt
```

---

### Step 2: Encrypt the Export with a Passphrase

Use **Age** or GPG symmetric encryption. Age is cleaner for this:

```bash
# Using Age (recommended)
age -p master.private.asc > master.private.asc.age
# prompts for a passphrase — use something long and memorable

# Or using GPG symmetric (no key dependency)
gpg --symmetric --armor --cipher-algo AES256 master.private.asc
# produces master.private.asc.asc
```

Now you have an encrypted blob that only requires a passphrase to unlock, no pre-existing key needed — critical for a cold recovery scenario.

### Step 3: Recovery Procedure (When Storage Dies)

```bash
# Pull your backup
git clone https://github.com/AhmedOsman101/dotfiles  # or download from wherever

# Decrypt it
age -d master.private.asc.age > master.private.asc
# or: gpg --decrypt master.private.asc.asc > master.private.asc

# Import into GPG
gpg --import master.private.asc

# Restore trust
gpg --import-ownertrust ownertrust.txt

# Clone your password store
git clone https://github.com/AhmedOsman101/secrets ~/.password-store

# Done — pass should work immediately
pass ls
```
