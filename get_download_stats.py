#!/usr/bin/env python3
"""
Script to fetch repository download and traffic statistics from GitHub.

This script retrieves:
- Repository clones (count and unique visitors)
- Repository views (count and unique visitors)
- Traffic referrers
- Popular content

Note: GitHub API only retains traffic data for the last 14 days.
"""

import requests
import json
import sys
from datetime import datetime

# Repository information
OWNER = "scgrambow"
REPO = "Democratizing-Intelligence"

def get_github_token():
    """
    Get GitHub token from environment or prompt user.
    For public repositories, token is optional but recommended for higher rate limits.
    """
    import os
    token = os.environ.get('GITHUB_TOKEN')
    if not token:
        print("Note: No GITHUB_TOKEN found in environment. You may hit rate limits.")
        print("To set a token, export GITHUB_TOKEN=your_token_here")
        print()
    return token

def fetch_stats(endpoint, token=None):
    """Fetch statistics from GitHub API."""
    url = f"https://api.github.com/repos/{OWNER}/{REPO}/{endpoint}"
    headers = {}
    if token:
        headers['Authorization'] = f'token {token}'
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        return response.json()
    elif response.status_code == 403:
        print(f"Error: Access forbidden. You may need repository access or a valid token.")
        return None
    elif response.status_code == 404:
        print(f"Error: Repository or endpoint not found.")
        return None
    else:
        print(f"Error {response.status_code}: {response.text}")
        return None

def print_clones_stats(data):
    """Print repository clone statistics."""
    if not data:
        print("Clone statistics not available (requires push access to repository)")
        return
    
    print("=" * 60)
    print("REPOSITORY CLONES (Last 14 days)")
    print("=" * 60)
    print(f"Total clones: {data.get('count', 0)}")
    print(f"Unique cloners: {data.get('uniques', 0)}")
    print()
    
    if 'clones' in data and data['clones']:
        print("Daily breakdown:")
        for day in data['clones']:
            date = day['timestamp'][:10]
            print(f"  {date}: {day['count']} clones ({day['uniques']} unique)")
    print()

def print_views_stats(data):
    """Print repository view statistics."""
    if not data:
        print("View statistics not available (requires push access to repository)")
        return
    
    print("=" * 60)
    print("REPOSITORY VIEWS (Last 14 days)")
    print("=" * 60)
    print(f"Total views: {data.get('count', 0)}")
    print(f"Unique visitors: {data.get('uniques', 0)}")
    print()
    
    if 'views' in data and data['views']:
        print("Daily breakdown:")
        for day in data['views']:
            date = day['timestamp'][:10]
            print(f"  {date}: {day['count']} views ({day['uniques']} unique)")
    print()

def print_referrers_stats(data):
    """Print top referrers."""
    if not data:
        print("Referrer statistics not available")
        return
    
    print("=" * 60)
    print("TOP REFERRERS (Last 14 days)")
    print("=" * 60)
    for referrer in data[:10]:  # Top 10
        print(f"  {referrer['referrer']}: {referrer['count']} views ({referrer['uniques']} unique)")
    print()

def print_popular_content(data):
    """Print popular repository content."""
    if not data:
        print("Popular content statistics not available")
        return
    
    print("=" * 60)
    print("POPULAR CONTENT (Last 14 days)")
    print("=" * 60)
    for item in data[:10]:  # Top 10
        print(f"  {item['path']}")
        print(f"    Views: {item['count']} ({item['uniques']} unique)")
        print(f"    Title: {item.get('title', 'N/A')}")
        print()

def main():
    """Main function to fetch and display repository statistics."""
    print("\n" + "=" * 60)
    print(f"GitHub Repository Statistics for {OWNER}/{REPO}")
    print(f"Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    print()
    
    token = get_github_token()
    
    # Fetch various statistics
    print("Fetching statistics from GitHub API...")
    print()
    
    clones = fetch_stats("traffic/clones", token)
    views = fetch_stats("traffic/views", token)
    referrers = fetch_stats("traffic/popular/referrers", token)
    paths = fetch_stats("traffic/popular/paths", token)
    
    # Print statistics
    print_views_stats(views)
    print_clones_stats(clones)
    print_referrers_stats(referrers)
    print_popular_content(paths)
    
    print("=" * 60)
    print("NOTES:")
    print("- GitHub only retains traffic data for the last 14 days")
    print("- Clone and view statistics require repository push access")
    print("- For more detailed analytics, consider using GitHub Insights")
    print("- To set up a GitHub token: export GITHUB_TOKEN=your_token_here")
    print("=" * 60)
    print()
    
    # Additional repository info
    repo_data = fetch_stats("", token)
    if repo_data:
        print("=" * 60)
        print("REPOSITORY INFORMATION")
        print("=" * 60)
        print(f"Stars: {repo_data.get('stargazers_count', 0)}")
        print(f"Forks: {repo_data.get('forks_count', 0)}")
        print(f"Watchers: {repo_data.get('subscribers_count', 0)}")
        print(f"Open Issues: {repo_data.get('open_issues_count', 0)}")
        print(f"Size: {repo_data.get('size', 0)} KB")
        print(f"Created: {repo_data.get('created_at', 'N/A')}")
        print(f"Last Updated: {repo_data.get('updated_at', 'N/A')}")
        print("=" * 60)

if __name__ == "__main__":
    try:
        import requests
    except ImportError:
        print("Error: 'requests' library not found.")
        print("Install it with: pip install requests")
        sys.exit(1)
    
    main()
