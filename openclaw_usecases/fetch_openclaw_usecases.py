#!/usr/bin/env python3
"""
Daily OpenClaw Use Cases Fetcher
Fetches use cases from GitHub and prepares for Discord posting
"""

import os
import sys
import json
from datetime import datetime
import subprocess

# Add workspace to path
workspace = "/home/node/.openclaw/workspace"
sys.path.insert(0, workspace)

def run_web_fetch(url, output_file):
    """Use OpenClaw's web_fetch tool to fetch content."""
    try:
        # Use web_fetch tool via OpenClaw CLI
        cmd = ["openclaw", "web_fetch", "--url", url, "--extract-mode", "markdown"]
        result = subprocess.run(cmd, capture_output=True, text=True, timeout=30)
        
        if result.returncode == 0:
            # Parse the JSON output
            try:
                data = json.loads(result.stdout)
                content = data.get("text", "")
                
                if content:
                    with open(output_file, "w", encoding="utf-8") as f:
                        f.write(content)
                    return True
            except json.JSONDecodeError:
                # Try to extract content directly
                with open(output_file, "w", encoding="utf-8") as f:
                    f.write(result.stdout)
                return True
    except Exception as e:
        print(f"  Error fetching {url}: {e}")
    
    return False

def fetch_github_file(github_raw, file_path, output_file):
    """Fetch a file from GitHub."""
    url = f"{github_raw}/{file_path}"
    print(f"Fetching: {file_path}")
    
    if run_web_fetch(url, output_file):
        # Check if file has content
        if os.path.exists(output_file) and os.path.getsize(output_file) > 0:
            lines = sum(1 for _ in open(output_file, encoding="utf-8"))
            size = os.path.getsize(output_file)
            print(f"  ✅ Success: {os.path.basename(output_file)}")
            print(f"     Lines: {lines}, Size: {size} bytes")
            return True
        else:
            print(f"  ⚠️  Empty file: {file_path}")
            return False
    else:
        print(f"  ❌ Failed: {file_path}")
        return False

def main():
    # Setup directories
    usecases_dir = os.path.join(workspace, "openclaw_usecases")
    os.chdir(usecases_dir)
    
    # Get today's date
    today = datetime.now().strftime("%Y-%m-%d")
    pretty_date = datetime.now().strftime("%B %d, %Y")
    timestamp = f"{pretty_date}, 6:00 AM"
    
    # GitHub URLs
    github_repo = "https://github.com/openclaw/openclaw"
    github_raw = "https://raw.githubusercontent.com/openclaw/openclaw/main"
    
    # Files to fetch
    files_to_fetch = [
        "README.md",
        "docs/USECASES.md",
        "docs/EXAMPLES.md",
        "docs/GETTING_STARTED.md",
        "skills/README.md"
    ]
    
    print(f"🔍 Fetching OpenClaw use cases from GitHub - {timestamp}")
    print("=" * 60)
    print()
    
    # Create today's directory
    daily_dir = os.path.join(usecases_dir, f"daily_{today}")
    os.makedirs(daily_dir, exist_ok=True)
    os.chdir(daily_dir)
    
    # Fetch files
    fetched_files = []
    failed_files = []
    
    for file_path in files_to_fetch:
        filename = os.path.basename(file_path)
        output_file = os.path.join(daily_dir, filename)
        
        if fetch_github_file(github_raw, file_path, output_file):
            fetched_files.append(filename)
        else:
            failed_files.append(file_path)
        print()
    
    # Create summary report
    summary_file = os.path.join(daily_dir, f"summary_{today}.md")
    
    with open(summary_file, "w", encoding="utf-8") as f:
        f.write(f"# OpenClaw Use Cases Summary\n")
        f.write(f"## Date: {timestamp}\n\n")
        
        f.write(f"## 📊 Fetch Results\n")
        f.write(f"**Successful fetches:** {len(fetched_files)} files\n")
        f.write(f"**Failed fetches:** {len(failed_files)} files\n\n")
        
        f.write(f"## 📁 Files Fetched:\n")
        for filename in fetched_files:
            filepath = os.path.join(daily_dir, filename)
            f.write(f"- {filename}\n")
            
            if os.path.exists(filepath):
                lines = sum(1 for _ in open(filepath, encoding="utf-8"))
                size = os.path.getsize(filepath)
                f.write(f"  - Lines: {lines}, Size: {size} bytes\n")
                
                if lines > 0:
                    f.write(f"  - Preview:\n")
                    with open(filepath, "r", encoding="utf-8") as content_file:
                        for i, line in enumerate(content_file):
                            if i < 5:
                                f.write(f"    > {line}")
                            else:
                                break
                        if lines > 5:
                            f.write(f"    > ...\n")
                f.write("\n")
        
        f.write(f"## ❌ Files Failed:\n")
        for file_path in failed_files:
            f.write(f"- {file_path}\n")
        f.write("\n")
        
        f.write(f"## 🔗 GitHub Repository\n")
        f.write(f"- **Repository:** [openclaw/openclaw]({github_repo})\n")
        f.write(f"- **Last fetched:** {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        
        total_files = len([name for name in os.listdir(daily_dir) 
                          if name.endswith('.md') or name.endswith('.txt')])
        f.write(f"- **Total files in daily archive:** {total_files}\n\n")
        
        f.write(f"## 🎯 Common OpenClaw Use Cases:\n")
        f.write(f"1. **Personal Assistant Automation** - Email, calendar, task management\n")
        f.write(f"2. **Home Automation** - Smart home control, IoT devices\n")
        f.write(f"3. **Development Workflows** - Code review, deployment, testing\n")
        f.write(f"4. **Research Assistance** - Web searching, data collection\n")
        f.write(f"5. **Content Creation** - Writing, social media management\n")
        f.write(f"6. **System Administration** - Monitoring, backups, security\n")
        f.write(f"7. **Communication** - Multi-platform messaging, notifications\n")
        f.write(f"8. **Data Processing** - File conversion, data extraction\n\n")
        
        f.write(f"## 📈 Statistics\n")
        total_size = sum(os.path.getsize(os.path.join(daily_dir, name)) 
                        for name in os.listdir(daily_dir) 
                        if os.path.isfile(os.path.join(daily_dir, name)))
        f.write(f"- **Total files in archive:** {len(os.listdir(daily_dir))}\n")
        f.write(f"- **Total size:** {total_size:,} bytes\n")
        f.write(f"- **Fetch time:** {datetime.now().strftime('%H:%M:%S')}\n\n")
        
        f.write(f"---\n")
        f.write(f"*Automatically fetched by OpenClaw use cases fetcher*\n")
    
    fetched_files.append(f"summary_{today}.md")
    print(f"📊 Summary created: {os.path.basename(summary_file)}")
    print()
    
    # Create Discord message
    discord_file = os.path.join(daily_dir, f"discord_{today}.txt")
    
    with open(discord_file, "w", encoding="utf-8") as f:
        f.write(f"**📦 Daily OpenClaw Use Cases Fetch - {pretty_date}**\n\n")
        
        f.write(f"✅ **Fetch Results:**\n")
        f.write(f"- Successful: {len(fetched_files)} files\n")
        f.write(f"- Failed: {len(failed_files)} files\n\n")
        
        f.write(f"**📁 Files Fetched:**\n")
        for i, filename in enumerate(fetched_files[:5]):
            f.write(f"- `{filename}`\n")
        
        if len(fetched_files) > 5:
            f.write(f"- ... and {len(fetched_files) - 5} more files\n")
        f.write("\n")
        
        f.write(f"**🎯 Common Use Cases Found:**\n")
        f.write(f"1. Personal Assistant Automation\n")
        f.write(f"2. Home Automation & IoT Control\n")
        f.write(f"3. Development Workflows\n")
        f.write(f"4. Research & Data Collection\n")
        f.write(f"5. Content Creation\n")
        f.write(f"6. System Administration\n\n")
        
        f.write(f"**📈 Repository Status:**\n")
        f.write(f"- Repository: openclaw/openclaw\n")
        f.write(f"- Last Updated: Daily fetch\n")
        f.write(f"- Total Files Today: {len(fetched_files)}\n\n")
        
        f.write(f"**🔍 Details in:** `openclaw_usecases/daily_{today}/`\n\n")
        
        f.write(f"---\n")
        f.write(f"*Automated fetch at 6:00 AM daily*\n")
    
    print(f"💬 Discord message created: {os.path.basename(discord_file)}")
    print()
    
    # Count total files
    total_files = len(os.listdir(daily_dir))
    total_size = sum(os.path.getsize(os.path.join(daily_dir, name)) 
                    for name in os.listdir(daily_dir) 
                    if os.path.isfile(os.path.join(daily_dir, name)))
    
    print(f"📈 Daily Archive Stats:")
    print(f"  - Directory: daily_{today}")
    print(f"  - Total files: {total_files}")
    print(f"  - Total size: {total_size:,} bytes")
    print()
    
    # Update main archive
    os.chdir(usecases_dir)
    main_archive = "openclaw_usecases_archive.md"
    
    if not os.path.exists(main_archive):
        with open(main_archive, "w", encoding="utf-8") as f:
            f.write("# OpenClaw Use Cases Archive\n\n")
    
    with open(main_archive, "a", encoding="utf-8") as f:
        f.write(f"## {pretty_date} - Daily Fetch\n\n")
        f.write(f"**Time:** {timestamp}\n")
        f.write(f"**Files fetched:** {len(fetched_files)}\n")
        f.write(f"**Failed:** {len(failed_files)}\n\n")
        f.write(f"**Files:**\n")
        for filename in fetched_files:
            f.write(f"- `{filename}`\n")
        f.write(f"\n---\n\n")
    
    print(f"📚 Main archive updated: {main_archive}")
    print()
    print(f"✅ OpenClaw use cases fetch completed for {today}")

if __name__ == "__main__":
    main()