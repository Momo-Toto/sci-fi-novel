#!/bin/bash

# Setup script for sci-fi novel GitHub repository

echo "🚀 Sci-Fi Novel Repository Setup"
echo "================================"
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ]; then
    echo "❌ Error: Please run this script from the sci-fi-novel-repo directory"
    exit 1
fi

echo "1. Initializing Git repository..."
git init

echo "2. Configuring Git user..."
git config user.name "Momo-Toto"
git config user.email "irt5032@gmail.com"

echo "3. Adding files to Git..."
git add README.md SCI_FI_NOVEL_SETUP.md DAILY_SYSTEMS_SETUP.md THREE_DAILY_SYSTEMS.md FINAL_SETUP_GUIDE.md

echo "4. Adding executable scripts..."
git add daily_sci_fi_generator.sh handle_sci_fi_cron.sh test_full_system.sh check_sci_fi_status.sh discord_status_check.sh

echo "5. Adding sample content..."
if [ -f "../sci_fi_novel_daily.md" ]; then
    cp ../sci_fi_novel_daily.md .
    git add sci_fi_novel_daily.md
    echo "   ✅ Added sci_fi_novel_daily.md with sample stories"
else
    echo "   ⚠️  No sample stories found, creating empty file"
    touch sci_fi_novel_daily.md
    echo "# Daily Sci-Fi Novel Archive" > sci_fi_novel_daily.md
    echo "" >> sci_fi_novel_daily.md
    echo "## Sample Entry" >> sci_fi_novel_daily.md
    echo "Stories will be added here daily by the automation system." >> sci_fi_novel_daily.md
    git add sci_fi_novel_daily.md
fi

echo "6. Creating .gitignore..."
cat > .gitignore << 'EOF'
# Generated files
discord_message_*.txt
sci_fi_daily_*.md

# Temporary files
*.tmp
*.log

# Backup files
*.backup
*.bak

# OpenClaw configuration
.openclaw/

# System files
.DS_Store
Thumbs.db
EOF

git add .gitignore

echo "7. Making initial commit..."
git commit -m "Initial commit: Daily Sci-Fi Novel Generator

Features:
- Daily Black Mirror-style story generation
- Discord integration for automatic posting
- Cron job scheduling for 7:00 AM daily
- Complete automation system
- Sample stories included

Setup complete and ready for GitHub."

echo ""
echo "✅ Repository setup complete!"
echo ""
echo "📋 NEXT STEPS:"
echo "============="
echo ""
echo "1. Create a new repository on GitHub:"
echo "   - Go to https://github.com/new"
echo "   - Repository name: sci-fi-novel"
echo "   - Description: Daily Black Mirror-style sci-fi story generator"
echo "   - Choose Public or Private"
echo "   - DO NOT initialize with README (we already have one)"
echo ""
echo "2. Connect local repository to GitHub:"
echo "   git remote add origin https://github.com/Momo-Toto/sci-fi-novel.git"
echo ""
echo "3. Push to GitHub:"
echo "   git push -u origin master"
echo ""
echo "4. Verify on GitHub:"
echo "   - Visit https://github.com/Momo-Toto/sci-fi-novel"
echo "   - Check that all files are present"
echo ""
echo "5. Test the system:"
echo "   ./test_full_system.sh"
echo ""
echo "🎉 Your sci-fi novel generator is ready for GitHub!"