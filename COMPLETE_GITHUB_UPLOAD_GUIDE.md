# Complete GitHub Upload Guide for Sci-Fi Novel Generator

## Current Status
✅ **Local repository is ready** with:
- 2 commits (initial setup + sci-fi novel project)
- 13 files in `sci-fi-novel-repo/` directory
- Git configured for user "Momo-Toto" (irt5032@gmail.com)

❌ **GitHub repository doesn't exist yet**
❌ **Current GITHUB_TOKEN lacks 'repo' creation permissions**

## Immediate Solution

### Step 1: Create Repository on GitHub.com
1. **Go to**: https://github.com/new
2. **Repository name**: `sci-fi-novel`
3. **Description**: "Daily Black Mirror-style sci-fi story generator"
4. **Visibility**: **Private** (as requested)
5. **CRITICAL**: **DO NOT** initialize with README, .gitignore, or license
6. Click **"Create repository"**

### Step 2: Push Local Repository
```bash
# Set remote (if not already set)
git remote add origin https://github.com/Momo-Toto/sci-fi-novel.git

# Push to GitHub
git push -u origin master
```

### Step 3: Authentication Options
If authentication fails, try one of these:

**Option A: Use current token** (may not work due to permissions):
```bash
git remote set-url origin https://Momo-Toto:$GITHUB_TOKEN@github.com/Momo-Toto/sci-fi-novel.git
git push -u origin master
```

**Option B: Get new token with correct permissions**:
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Fine-grained token"
3. Settings:
   - Token name: "OpenClaw Repo Creation"
   - Expiration: 90 days (recommended)
   - Repository access: **All repositories**
   - Permissions: **Repository permissions** → **Administration: Read and write**
4. Copy the new token
5. Update environment:
   ```bash
   export GITHUB_TOKEN=your_new_token_here
   ```
6. Try pushing again

**Option C: Use GitHub CLI** (if installed):
```bash
gh auth login  # Follow prompts
gh repo create sci-fi-novel --private --description "Daily Black Mirror-style sci-fi story generator" --push --source=. --remote=origin
```

## What's Being Uploaded

### Core Files:
- `README.md` - Complete project documentation
- `SCI_FI_NOVEL_SETUP.md` - Detailed setup guide
- `daily_sci_fi_generator.sh` - Main story generation script
- `sci_fi_novel_daily.md` - 9+ sample Black Mirror-style stories

### Support Files:
- `DAILY_SYSTEMS_SETUP.md` - Multi-system setup guide
- `THREE_DAILY_SYSTEMS.md` - Complete system overview
- `FINAL_SETUP_GUIDE.md` - Final installation guide
- `handle_sci_fi_cron.sh` - Cron job handler
- `test_full_system.sh` - System testing script
- `check_sci_fi_status.sh` - Status checker
- `discord_status_check.sh` - Discord integration checker
- `setup_repo.sh` - Repository setup script
- `test_upload.sh` - Upload test script

## Verification

After successful upload:
1. Visit: https://github.com/Momo-Toto/sci-fi-novel
2. Verify all 13 files are present
3. Check commit history shows 2 commits
4. Repository should be private

## Troubleshooting

### Error: "Repository not found"
- Repository doesn't exist yet → Create it at https://github.com/new

### Error: "Authentication failed"
- Token is invalid/expired → Get new token at https://github.com/settings/tokens
- Token lacks permissions → Ensure token has "repo" scope or fine-grained "Administration" permissions

### Error: "Password authentication not supported"
- GitHub rejects token-in-URL → Use credential helper or SSH
- Try: `git config credential.helper 'store'` then push

### Error: "Permission denied (publickey)"
- SSH key not set up → Use HTTPS instead or add SSH key to GitHub account

## Quick One-Liner Solution

If you create the repository manually, then run:
```bash
git remote add origin https://github.com/Momo-Toto/sci-fi-novel.git && git push -u origin master
```

## Need Help?

If you continue having issues:
1. Create repository manually at https://github.com/new
2. Run the push command
3. If authentication fails, create new token with "repo" permissions

The local repository is 100% ready - just needs the GitHub destination to exist.