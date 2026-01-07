#!/bin/bash
# Quick script to fetch repository statistics from GitHub API
# Usage: ./quick_stats.sh [github_token]
# Note: Script continues on errors to show all available information

OWNER="scgrambow"
REPO="Democratizing-Intelligence"
TOKEN="${1:-${GITHUB_TOKEN}}"

echo "============================================================"
echo "GitHub Repository Statistics"
echo "Repository: $OWNER/$REPO"
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')"
echo "============================================================"
echo ""

# Set up authentication header if token is provided
if [ -n "$TOKEN" ]; then
    AUTH_HEADER="Authorization: token $TOKEN"
    echo "Using authenticated requests (higher rate limits)"
else
    AUTH_HEADER=""
    echo "No token provided - using unauthenticated requests"
    echo "Tip: Set GITHUB_TOKEN environment variable or pass token as argument"
fi
echo ""

# Fetch basic repository information
echo "Fetching repository information..."
if [ -n "$AUTH_HEADER" ]; then
    REPO_INFO=$(curl -s -H "$AUTH_HEADER" "https://api.github.com/repos/$OWNER/$REPO")
else
    REPO_INFO=$(curl -s "https://api.github.com/repos/$OWNER/$REPO")
fi

echo "============================================================"
echo "REPOSITORY METRICS"
echo "============================================================"

# Check if jq is available for better JSON parsing
if command -v jq &> /dev/null; then
    echo "Stars: $(echo "$REPO_INFO" | jq -r '.stargazers_count // "N/A"')"
    echo "Forks: $(echo "$REPO_INFO" | jq -r '.forks_count // "N/A"')"
    echo "Watchers: $(echo "$REPO_INFO" | jq -r '.subscribers_count // "N/A"')"
    echo "Open Issues: $(echo "$REPO_INFO" | jq -r '.open_issues_count // "N/A"')"
    echo "Size (KB): $(echo "$REPO_INFO" | jq -r '.size // "N/A"')"
    echo "Created: $(echo "$REPO_INFO" | jq -r '.created_at // "N/A"')"
    echo "Last Updated: $(echo "$REPO_INFO" | jq -r '.updated_at // "N/A"')"
else
    # Fallback to grep if jq is not available
    echo "$REPO_INFO" | grep -E '"stargazers_count"|"forks_count"|"subscribers_count"|"open_issues_count"|"size"|"created_at"|"updated_at"' | \
        sed 's/^[ \t]*//;s/,$//' | \
        sed 's/"stargazers_count"/Stars:/' | \
        sed 's/"forks_count"/Forks:/' | \
        sed 's/"subscribers_count"/Watchers:/' | \
        sed 's/"open_issues_count"/Open Issues:/' | \
        sed 's/"size"/Size (KB):/' | \
        sed 's/"created_at"/Created:/' | \
        sed 's/"updated_at"/Last Updated:/'
fi
echo ""

# Try to fetch traffic data (requires authentication and push access)
if [ -n "$AUTH_HEADER" ]; then
    echo "============================================================"
    echo "TRAFFIC STATISTICS (Last 14 days)"
    echo "============================================================"
    
    # Views
    echo "Fetching view statistics..."
    VIEWS=$(curl -s -H "$AUTH_HEADER" "https://api.github.com/repos/$OWNER/$REPO/traffic/views")
    if echo "$VIEWS" | grep -q '"count"'; then
        if command -v jq &> /dev/null; then
            TOTAL_VIEWS=$(echo "$VIEWS" | jq -r '.count // "N/A"')
            UNIQUE_VIEWS=$(echo "$VIEWS" | jq -r '.uniques // "N/A"')
        else
            # Portable sed-based parsing (works on macOS and Linux)
            TOTAL_VIEWS=$(echo "$VIEWS" | grep '"count"' | head -1 | sed 's/[^0-9]*\([0-9][0-9]*\).*/\1/')
            UNIQUE_VIEWS=$(echo "$VIEWS" | grep '"uniques"' | head -1 | sed 's/[^0-9]*\([0-9][0-9]*\).*/\1/')
        fi
        echo "Total Views: $TOTAL_VIEWS"
        echo "Unique Visitors: $UNIQUE_VIEWS"
    else
        echo "View statistics not available (requires push access)"
    fi
    echo ""
    
    # Clones
    echo "Fetching clone statistics..."
    CLONES=$(curl -s -H "$AUTH_HEADER" "https://api.github.com/repos/$OWNER/$REPO/traffic/clones")
    if echo "$CLONES" | grep -q '"count"'; then
        if command -v jq &> /dev/null; then
            TOTAL_CLONES=$(echo "$CLONES" | jq -r '.count // "N/A"')
            UNIQUE_CLONES=$(echo "$CLONES" | jq -r '.uniques // "N/A"')
        else
            # Portable sed-based parsing (works on macOS and Linux)
            TOTAL_CLONES=$(echo "$CLONES" | grep '"count"' | head -1 | sed 's/[^0-9]*\([0-9][0-9]*\).*/\1/')
            UNIQUE_CLONES=$(echo "$CLONES" | grep '"uniques"' | head -1 | sed 's/[^0-9]*\([0-9][0-9]*\).*/\1/')
        fi
        echo "Total Clones: $TOTAL_CLONES"
        echo "Unique Cloners: $UNIQUE_CLONES"
    else
        echo "Clone statistics not available (requires push access)"
    fi
    echo ""
else
    echo "============================================================"
    echo "TRAFFIC STATISTICS"
    echo "============================================================"
    echo "Traffic data requires authentication with a GitHub token"
    echo "Usage: $0 your_github_token"
    echo "   or: export GITHUB_TOKEN=your_token && $0"
    echo ""
fi

echo "============================================================"
echo "NOTES"
echo "============================================================"
echo "- GitHub retains traffic data for only 14 days"
echo "- Traffic stats require repository push access"
echo "- Individual file downloads are not tracked by GitHub"
echo "- For PDF download tracking, consider creating a GitHub Release"
echo ""
echo "For more information, see DOWNLOAD_STATS.md"
echo "============================================================"
