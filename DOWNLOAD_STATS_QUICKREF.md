# Repository Download Statistics - Quick Reference

## How to Check Download Statistics RIGHT NOW

### Method 1: GitHub Website (Easiest - For Repository Owners)
1. Go to: **https://github.com/scgrambow/Democratizing-Intelligence/graphs/traffic**
2. You'll immediately see:
   - Views (last 14 days)
   - Unique visitors
   - Clones
   - Unique cloners

**Note**: Requires push access to the repository.

### Method 2: Use the Scripts in This Repository

**Option A - Python Script (More detailed output):**
```bash
cd /path/to/repository
export GITHUB_TOKEN=your_token_here  # Optional but recommended
python3 get_download_stats.py
```

**Option B - Bash Script (Quick and simple):**
```bash
cd /path/to/repository
export GITHUB_TOKEN=your_token_here  # Optional but recommended
./quick_stats.sh
```

## What Statistics Are Available?

### ✅ Currently Tracked by GitHub:
- **Repository Views** - How many times someone viewed the repository (last 14 days)
- **Unique Visitors** - How many unique people viewed the repository
- **Repository Clones** - How many times someone cloned/downloaded the entire repository
- **Unique Cloners** - How many unique people cloned the repository
- **Popular Paths** - Which files were viewed most
- **Referrer Sources** - Where traffic came from

### ❌ NOT Currently Tracked:
- **Individual PDF file downloads** - GitHub doesn't track individual file downloads from repositories
- **Historical data beyond 14 days** - GitHub only keeps traffic data for 2 weeks

## Important: PDF Download Tracking

### The Problem
The PDF file `2025-01-06-Grambow-CTSI-NCAHPD.pdf` **cannot** be tracked for individual downloads in its current location (as a repository file).

### The Solution: Create a GitHub Release

To track PDF downloads specifically, you need to:

1. **Create a Release on GitHub**:
   - Navigate to: https://github.com/scgrambow/Democratizing-Intelligence/releases/new
   - Tag version: `v1.0` (or whatever version you prefer)
   - Release title: "Presentation - January 2026"
   - Upload the PDF as a release asset
   - Publish release

2. **Update the README link** to point to the release:
   ```markdown
   [Download PDF](https://github.com/scgrambow/Democratizing-Intelligence/releases/download/v1.0/2025-01-06-Grambow-CTSI-NCAHPD.pdf)
   ```

3. **View download counts**:
   - Go to: https://github.com/scgrambow/Democratizing-Intelligence/releases
   - Each release shows download counts for all attached files

### Why This Matters
Once you create a release:
- ✅ GitHub tracks every download of the PDF
- ✅ Download counts are visible to everyone (public)
- ✅ Historical data is preserved (doesn't expire after 14 days)
- ✅ Professional presentation (releases are standard for distributing files)

## Getting a GitHub Personal Access Token

If the scripts require authentication:

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Select scopes: `repo` (or `public_repo` for public repos only)
4. Generate and copy the token
5. Use it:
   ```bash
   export GITHUB_TOKEN=ghp_your_token_here
   ```

## Summary

**Current Situation:**
- Repository traffic (views/clones) can be tracked ✅
- Individual PDF downloads cannot be tracked ❌

**Recommended Action:**
- Create a GitHub Release to enable PDF download tracking
- Update README to link to the release
- Then you'll have complete download statistics

**For More Details:**
See `DOWNLOAD_STATS.md` in this repository.
