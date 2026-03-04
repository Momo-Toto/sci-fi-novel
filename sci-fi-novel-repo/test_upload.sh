#!/bin/bash

# Test script to simulate GitHub upload process

echo "🧪 GitHub Upload Test Simulation"
echo "================================"
echo ""

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "❌ Git repository not initialized"
    echo "   Run ./setup_repo.sh first"
    exit 1
fi

echo "1. Checking Git status..."
git status --short

echo ""
echo "2. Checking Git configuration..."
git config --local user.name
git config --local user.email

echo ""
echo "3. Listing files to be uploaded:"
echo "--------------------------------"
find . -type f -name "*.md" -o -name "*.sh" | grep -v ".git" | sort

echo ""
echo "4. File sizes:"
echo "--------------"
find . -type f \( -name "*.md" -o -name "*.sh" \) -exec du -h {} \; | grep -v ".git"

echo ""
echo "5. Sample of README.md:"
echo "----------------------"
head -20 README.md

echo ""
echo "6. Sample of sci_fi_novel_daily.md:"
echo "----------------------------------"
head -30 sci_fi_novel_daily.md | tail -20

echo ""
echo "7. Testing script execution:"
echo "---------------------------"
echo "Testing daily_sci_fi_generator.sh..."
if [ -x "daily_sci_fi_generator.sh" ]; then
    ./daily_sci_fi_generator.sh > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "✅ daily_sci_fi_generator.sh works"
        # Show what was generated
        if [ -f "discord_message_*.txt" ]; then
            echo "   Generated: $(ls discord_message_*.txt | head -1)"
        fi
    else
        echo "❌ daily_sci_fi_generator.sh failed"
    fi
else
    echo "❌ daily_sci_fi_generator.sh not executable"
fi

echo ""
echo "8. Simulating git commands for upload:"
echo "-------------------------------------"
echo "Commands that would be run:"
echo ""
echo "  # Add all files"
echo "  git add ."
echo ""
echo "  # Check status"
echo "  git status"
echo ""
echo "  # Commit changes"
echo "  git commit -m 'Update: New stories and improvements'"
echo ""
echo "  # Push to GitHub (if remote is configured)"
echo "  git push origin master"
echo ""
echo "9. Repository summary:"
echo "---------------------"
echo "Total files: $(find . -type f | grep -v ".git" | wc -l)"
echo "Total size: $(du -sh . | cut -f1)"
echo "Scripts: $(find . -name "*.sh" -type f | wc -l) executable files"
echo "Markdown: $(find . -name "*.md" -type f | wc -l) documentation files"
echo ""
echo "✅ Upload test simulation complete!"
echo ""
echo "📋 ACTUAL UPLOAD INSTRUCTIONS:"
echo "=============================="
echo ""
echo "After creating repository on GitHub:"
echo ""
echo "1. Add remote origin:"
echo "   git remote add origin https://github.com/Momo-Toto/sci-fi-novel.git"
echo ""
echo "2. Push to GitHub:"
echo "   git push -u origin master"
echo ""
echo "3. Verify on GitHub.com"
echo ""
echo "🎉 Ready for actual GitHub upload!"