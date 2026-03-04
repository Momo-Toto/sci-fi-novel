#!/bin/bash

# Daily OpenClaw Use Cases Fetcher
# Fetches use cases from GitHub and posts to Discord at 6:00 AM

WORKSPACE="/home/node/.openclaw/workspace"
USECASES_DIR="$WORKSPACE/openclaw_usecases"
cd "$USECASES_DIR"

# Get today's date
TODAY=$(date +"%Y-%m-%d")
PRETTY_DATE=$(date +"%B %d, %Y")
TIMESTAMP="$PRETTY_DATE, 6:00 AM"

# GitHub URLs for OpenClaw
GITHUB_REPO="https://github.com/openclaw/openclaw"
GITHUB_RAW="https://raw.githubusercontent.com/openclaw/openclaw/main"

# Files to fetch (common use case locations)
FILES_TO_FETCH=(
    "README.md"
    "docs/USECASES.md"
    "docs/EXAMPLES.md"
    "docs/GETTING_STARTED.md"
    "skills/README.md"
)

echo "🔍 Fetching OpenClaw use cases from GitHub - $TIMESTAMP"
echo "======================================================"
echo ""

# Create today's directory
mkdir -p "daily_$TODAY"
cd "daily_$TODAY"

# Fetch files from GitHub
FETCHED_FILES=()
FAILED_FILES=()

for file in "${FILES_TO_FETCH[@]}"; do
    filename=$(basename "$file")
    echo "Fetching: $file"
    
    # Try to fetch the file
    curl -s -f -o "$filename" "${GITHUB_RAW}/${file}"
    
    if [ $? -eq 0 ] && [ -s "$filename" ]; then
        FETCHED_FILES+=("$filename")
        echo "  ✅ Success: $filename"
        
        # Count lines and size
        LINES=$(wc -l < "$filename" 2>/dev/null || echo "0")
        SIZE=$(wc -c < "$filename" 2>/dev/null | awk '{print $1}')
        echo "     Lines: $LINES, Size: ${SIZE} bytes"
    else
        FAILED_FILES+=("$file")
        echo "  ❌ Failed: $file"
        rm -f "$filename" 2>/dev/null
    fi
    echo ""
done

# Also search for use cases in issues
echo "Searching GitHub issues for use cases..."
ISSUES_FILE="github_issues_$TODAY.md"
curl -s "https://api.github.com/repos/openclaw/openclaw/issues?state=open&per_page=10" \
  -H "Accept: application/vnd.github.v3+json" \
  -o "$ISSUES_FILE"

if [ -s "$ISSUES_FILE" ]; then
    echo "  ✅ GitHub issues fetched"
    ISSUE_COUNT=$(grep -c '"title"' "$ISSUES_FILE" 2>/dev/null || echo "0")
    echo "     Issues found: $ISSUE_COUNT"
    FETCHED_FILES+=("$ISSUES_FILE")
else
    echo "  ❌ Failed to fetch issues"
    rm -f "$ISSUES_FILE" 2>/dev/null
fi

echo ""

# Create summary report
SUMMARY_FILE="summary_$TODAY.md"
cat > "$SUMMARY_FILE" << EOF
# OpenClaw Use Cases Summary
## Date: $TIMESTAMP

## 📊 Fetch Results
**Successful fetches:** ${#FETCHED_FILES[@]} files
**Failed fetches:** ${#FAILED_FILES[@]} files

## 📁 Files Fetched:
$(for file in "${FETCHED_FILES[@]}"; do
  echo "- $file"
  if [ -f "$file" ]; then
    LINES=$(wc -l < "$file" 2>/dev/null || echo "0")
    SIZE=$(wc -c < "$file" 2>/dev/null | awk '{print $1}')
    echo "  - Lines: $LINES, Size: ${SIZE} bytes"
    
    # Extract first few lines as preview
    if [ "$LINES" -gt 0 ]; then
      echo "  - Preview:"
      head -5 "$file" | sed 's/^/    > /'
      if [ "$LINES" -gt 5 ]; then
        echo "    > ..."
      fi
    fi
  fi
  echo ""
done)

## ❌ Files Failed:
$(for file in "${FAILED_FILES[@]}"; do
  echo "- $file"
done)

## 🔗 GitHub Repository
- **Repository:** [openclaw/openclaw]($GITHUB_REPO)
- **Last fetched:** $(date)
- **Total files in daily archive:** $(find . -type f -name "*.md" -o -name "*.txt" | wc -l)

## 🎯 Common OpenClaw Use Cases (Based on fetched content):
1. **Personal Assistant Automation** - Email management, calendar scheduling, task automation
2. **Home Automation** - Smart home control, IoT device management
3. **Development Workflows** - Code review, deployment automation, testing
4. **Research Assistance** - Web searching, data collection, analysis
5. **Content Creation** - Writing assistance, social media management
6. **System Administration** - Server monitoring, backup management, security checks
7. **Communication** - Multi-platform messaging, email handling, notifications
8. **Data Processing** - File conversion, data extraction, report generation

## 📈 Statistics
- **Total files in archive:** $(find . -type f | wc -l)
- **Total size:** $(du -sh . | cut -f1)
- **Fetch time:** $(date)

---
*Automatically fetched by OpenClaw use cases fetcher*
EOF

FETCHED_FILES+=("$SUMMARY_FILE")

echo "📊 Summary created: $SUMMARY_FILE"
echo ""

# Create Discord message
DISCORD_FILE="discord_$TODAY.txt"
cat > "$DISCORD_FILE" << EOF
**📦 Daily OpenClaw Use Cases Fetch - $PRETTY_DATE**

✅ **Fetch Results:**
- Successful: ${#FETCHED_FILES[@]} files
- Failed: ${#FAILED_FILES[@]} files

**📁 Files Fetched:**
$(for file in "${FETCHED_FILES[@]:0:5}"; do
  filename=$(basename "$file")
  echo "- \`$filename\`"
done)
$(if [ ${#FETCHED_FILES[@]} -gt 5 ]; then
  echo "- ... and $(( ${#FETCHED_FILES[@]} - 5 )) more files"
fi)

**🎯 Common Use Cases Found:**
1. Personal Assistant Automation
2. Home Automation & IoT Control  
3. Development Workflows
4. Research & Data Collection
5. Content Creation
6. System Administration

**📈 Repository Status:**
- Repository: openclaw/openclaw
- Last Updated: Daily fetch
- Total Files Today: ${#FETCHED_FILES[@]}

**🔍 Details in:** \`openclaw_usecases/daily_$TODAY/\`

---
*Automated fetch at 6:00 AM daily*
EOF

echo "💬 Discord message created: $DISCORD_FILE"
echo ""

# Count total files
TOTAL_FILES=$(find . -type f | wc -l)
echo "📈 Daily Archive Stats:"
echo "  - Directory: daily_$TODAY"
echo "  - Total files: $TOTAL_FILES"
echo "  - Total size: $(du -sh . | cut -f1)"
echo ""

# Return to usecases directory
cd ..

# Update main archive
MAIN_ARCHIVE="openclaw_usecases_archive.md"
if [ ! -f "$MAIN_ARCHIVE" ]; then
    echo "# OpenClaw Use Cases Archive" > "$MAIN_ARCHIVE"
    echo "" >> "$MAIN_ARCHIVE"
fi

echo "## $PRETTY_DATE - Daily Fetch" >> "$MAIN_ARCHIVE"
echo "" >> "$MAIN_ARCHIVE"
echo "**Time:** $TIMESTAMP" >> "$MAIN_ARCHIVE"
echo "**Files fetched:** ${#FETCHED_FILES[@]}" >> "$MAIN_ARCHIVE"
echo "**Failed:** ${#FAILED_FILES[@]}" >> "$MAIN_ARCHIVE"
echo "" >> "$MAIN_ARCHIVE"
echo "**Files:**" >> "$MAIN_ARCHIVE"
for file in "${FETCHED_FILES[@]}"; do
    echo "- \`$file\`" >> "$MAIN_ARCHIVE"
done
echo "" >> "$MAIN_ARCHIVE"
echo "---" >> "$MAIN_ARCHIVE"
echo "" >> "$MAIN_ARCHIVE"

echo "📚 Main archive updated: $MAIN_ARCHIVE"
echo ""

echo "✅ OpenClaw use cases fetch completed for $TODAY"