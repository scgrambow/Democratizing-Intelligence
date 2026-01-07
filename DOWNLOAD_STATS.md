# Download Statistics Guide

## Quick Answer: How Many Downloads Have There Been?

### Current Answer (as of the question):

**Repository Traffic (last 14 days only):**
- To see the current numbers, you must:
  1. Have push access to the repository, AND
  2. Visit: https://github.com/scgrambow/Democratizing-Intelligence/graphs/traffic

**PDF File Downloads:**
- ❌ **Not tracked** - GitHub does not track individual file downloads for files stored in the repository
- ✅ **Solution**: Create a GitHub Release (see instructions below)

### Why Can't I See the Numbers Right Now?

1. **Traffic data requires authentication** - Only repository owners/collaborators can view traffic statistics
2. **14-day limitation** - GitHub only retains the last 14 days of traffic data
3. **PDF downloads not tracked** - Individual file downloads are not tracked unless using GitHub Releases

### What You Can Do Now:

**For repository owners/collaborators:** To see the exact number of views and clones:

1. **Visit GitHub Insights** (easiest method):
   - Go to: https://github.com/scgrambow/Democratizing-Intelligence/graphs/traffic
   - You'll see views and clones for the last 14 days

2. **Run the included script**:
   ```bash
   export GITHUB_TOKEN=your_personal_access_token
   python3 get_download_stats.py
   ```

3. **Check manually on GitHub**:
   - Navigate to the repository: https://github.com/scgrambow/Democratizing-Intelligence
   - Click **"Insights"** → **"Traffic"**

**Important Notes:**
- ⚠️ GitHub only retains traffic data for **14 days**
- ⚠️ Individual PDF file downloads are **not tracked** by GitHub (only repository views and clones)
- ⚠️ You need **push access** to the repository to view detailed statistics
- ✅ To track PDF downloads specifically, consider creating a [GitHub Release](#tracking-pdf-downloads-specifically)

---

## How to View Repository Download Statistics

This repository tracks various metrics through GitHub. Here's how to access them:

### 1. **Repository Traffic Statistics** (For Repository Owners/Collaborators)

If you have **push access** to this repository, you can view detailed traffic statistics:

1. Go to the repository on GitHub: https://github.com/scgrambow/Democratizing-Intelligence
2. Click on **"Insights"** tab (near the top of the page)
3. Click on **"Traffic"** in the left sidebar

You'll see:
- **Views**: Number of times the repository was viewed (last 14 days)
- **Unique Visitors**: Number of unique users who viewed the repository
- **Clones**: Number of times the repository was cloned (last 14 days)
- **Unique Cloners**: Number of unique users who cloned the repository

### 2. **Using the Included Script**

This repository includes a Python script `get_download_stats.py` that fetches statistics programmatically.

#### Prerequisites
```bash
pip install requests
```

#### Usage

**For public information (no authentication needed):**
```bash
python3 get_download_stats.py
```

**With GitHub Personal Access Token (for detailed traffic stats):**
```bash
export GITHUB_TOKEN=your_github_token_here
python3 get_download_stats.py
```

#### Creating a GitHub Personal Access Token

1. Go to GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Click "Generate new token" → "Generate new token (classic)"
3. Give it a descriptive name (e.g., "Traffic Stats Reader")
4. Select scopes:
   - For traffic data: `repo` (or just `public_repo` for public repositories)
5. Click "Generate token"
6. Copy the token and use it with the script

### 3. **GitHub API (Manual)**

You can also query the GitHub API directly:

```bash
# Get repository information (public)
curl https://api.github.com/repos/scgrambow/Democratizing-Intelligence

# Get traffic views (requires authentication)
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/repos/scgrambow/Democratizing-Intelligence/traffic/views

# Get traffic clones (requires authentication)
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/repos/scgrambow/Democratizing-Intelligence/traffic/clones
```

### 4. **What Statistics Are Available?**

#### Public Statistics (No Authentication Required)
- ⭐ **Stars**: Number of users who starred the repository
- 🍴 **Forks**: Number of times the repository was forked
- 👁️ **Watchers**: Number of users watching the repository

You can view these on the repository homepage: https://github.com/scgrambow/Democratizing-Intelligence

#### Traffic Statistics (Requires Repository Access)
- 👀 **Views**: Page views over the last 14 days
- 👥 **Unique Visitors**: Unique users who viewed the repository
- 📥 **Clones**: Git clone operations over the last 14 days  
- 🔍 **Popular Content**: Most viewed files and paths
- 🔗 **Referrers**: Where traffic is coming from

### 5. **Tracking PDF Downloads Specifically**

**Important Note**: GitHub does **not** track downloads of individual files in regular repositories. The PDF file `2025-01-06-Grambow-CTSI-NCAHPD.pdf` in this repository does not have individual download tracking.

GitHub only tracks:
- Repository-level statistics (views, clones)
- Release asset downloads (if you create GitHub Releases)

#### **Recommended: Create a GitHub Release to Track PDF Downloads**

To get accurate download counts for the PDF:

1. **Create a Release**:
   - Go to: https://github.com/scgrambow/Democratizing-Intelligence/releases/new
   - Create a version tag (e.g., `v1.0`)
   - Add a title: "Presentation: Architecting the Future of Health Work"
   - Attach the PDF as a release asset
   - Publish the release

2. **View Download Statistics**:
   - GitHub automatically tracks downloads of release assets
   - View at: https://github.com/scgrambow/Democratizing-Intelligence/releases
   - Each release shows download counts for attached files

3. **Update README Link**:
   ```markdown
   [📄 Download the Full Presentation Deck (PDF)](https://github.com/scgrambow/Democratizing-Intelligence/releases/latest/download/2025-01-06-Grambow-CTSI-NCAHPD.pdf)
   ```

#### Alternative Tracking Methods:
- Host the PDF on a service that provides download analytics (e.g., Google Drive with analytics, Dropbox, etc.)
- Use URL shorteners with analytics (bit.ly, etc.)
- Implement custom tracking with services like Google Analytics

### 6. **Current Repository Statistics**

To see the current public statistics at any time:

```bash
# Stars, Forks, Watchers
curl https://api.github.com/repos/scgrambow/Democratizing-Intelligence | \
  python3 -c "import sys, json; data=json.load(sys.stdin); \
  print(f\"Stars: {data['stargazers_count']}\"); \
  print(f\"Forks: {data['forks_count']}\"); \
  print(f\"Watchers: {data['subscribers_count']}\")"
```

### 7. **Limitations**

- **14-Day Window**: GitHub only retains traffic data for the last 14 days
- **Authentication Required**: Detailed traffic stats require repository push access
- **No File-Level Tracking**: Individual file downloads are not tracked (except for release assets)
- **Rate Limits**: GitHub API has rate limits (60 requests/hour without auth, 5000 with auth)

### 8. **Alternative: Google Analytics**

For more comprehensive tracking, you could:
1. Create a landing page for the PDF
2. Add Google Analytics to track page visits and PDF clicks
3. Use this as your primary sharing link

## Questions?

If you need specific download metrics, please:
1. Specify which metric you're interested in (views, clones, file downloads)
2. Consider creating a GitHub Release if you want to track PDF download counts specifically
3. Use the included `get_download_stats.py` script for current statistics

---

**Last Updated**: January 2026
