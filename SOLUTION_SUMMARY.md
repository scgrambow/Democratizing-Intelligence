# Summary: Download Statistics Solution

## Question Asked
"Can you tell me how many downloads there have been?"

## Answer

### Direct Answer
To see download statistics for the repository, you have several options:

#### Option 1: GitHub Web Interface (Easiest for Repository Owners)
If you have push access to the repository:
1. Visit: https://github.com/scgrambow/Democratizing-Intelligence/graphs/traffic
2. You'll see:
   - Total views and unique visitors (last 14 days)
   - Total clones and unique cloners (last 14 days)
   - Popular content paths
   - Traffic referrers

#### Option 2: Use the Scripts Provided
Two scripts are now included in the repository:

**Python Script:**
```bash
export GITHUB_TOKEN=your_token_here  # Optional
python3 get_download_stats.py
```

**Bash Script:**
```bash
export GITHUB_TOKEN=your_token_here  # Optional
./quick_stats.sh
```

### Important Notes About Download Tracking

#### ✅ What IS Tracked by GitHub:
- **Repository Views**: How many times the repo page was viewed (last 14 days)
- **Unique Visitors**: Number of unique users who viewed the repo
- **Repository Clones**: How many times the repository was cloned/downloaded
- **Unique Cloners**: Number of unique users who cloned the repo

#### ❌ What is NOT Tracked:
- **Individual PDF file downloads**: GitHub does NOT track downloads of individual files stored in the repository
- **Historical data beyond 14 days**: GitHub only keeps traffic data for 2 weeks

### The PDF Download Problem

The PDF file `2025-01-06-Grambow-CTSI-NCAHPD.pdf` **cannot** be tracked for individual downloads in its current location (as a regular repository file).

**Solution: Create a GitHub Release**

To track PDF downloads specifically:

1. Create a GitHub Release:
   - Go to: https://github.com/scgrambow/Democratizing-Intelligence/releases/new
   - Tag: `v1.0`
   - Title: "Presentation - January 2026"
   - Upload the PDF as a release asset
   - Publish

2. Update the README link to:
   ```markdown
   [Download PDF](https://github.com/scgrambow/Democratizing-Intelligence/releases/download/v1.0/2025-01-06-Grambow-CTSI-NCAHPD.pdf)
   ```

3. View download counts at:
   https://github.com/scgrambow/Democratizing-Intelligence/releases

**Benefits of using Releases:**
- ✅ Accurate download counts for the PDF
- ✅ Download statistics visible to everyone
- ✅ Historical data preserved (doesn't expire)
- ✅ Professional presentation

## What Was Added to the Repository

### 1. Documentation
- **DOWNLOAD_STATS.md**: Comprehensive guide on all statistics options
- **DOWNLOAD_STATS_QUICKREF.md**: Quick reference with actionable steps
- **README.md**: Updated with link to statistics guide

### 2. Tools
- **get_download_stats.py**: Python script to fetch repository statistics via GitHub API
- **quick_stats.sh**: Bash script for quick command-line statistics

### 3. Features
- Fetches repository views, clones, referrers, and popular content
- Works with or without authentication (better with GitHub token)
- Portable across different platforms (macOS, Linux)
- Clear error messages and helpful instructions

## How to Use

### For Quick Check (No Setup Required)
1. Have repository push access
2. Visit: https://github.com/scgrambow/Democratizing-Intelligence/graphs/traffic

### For Programmatic Access
1. Generate a GitHub Personal Access Token:
   - Go to: https://github.com/settings/tokens
   - Create new token with `repo` scope
   
2. Run one of the scripts:
   ```bash
   export GITHUB_TOKEN=your_token
   python3 get_download_stats.py
   # or
   ./quick_stats.sh
   ```

### For PDF Download Tracking
1. Create a GitHub Release (instructions above)
2. This enables permanent, accurate PDF download tracking

## Summary

**Current Status:**
- Repository traffic (views/clones) can be tracked ✅
- Individual PDF downloads cannot be tracked ❌

**Recommendation:**
Create a GitHub Release to enable complete download statistics including PDF downloads.

**Documentation:**
All tools and instructions are now available in the repository for future reference.
