#!/bin/bash

echo "🔍 Daily Sci-Fi Novel System Status"
echo "==================================="
echo ""

# Check current date
echo "📅 Date: $(date)"
echo "📅 UTC: $(date -u)"
echo ""

# Check files
echo "📁 File Status:"
echo "--------------"
if [ -f "sci_fi_novel_daily.md" ]; then
    echo "✅ sci_fi_novel_daily.md exists"
    ENTRY_COUNT=$(grep -c "^## Entry " sci_fi_novel_daily.md)
    echo "   Entries: $ENTRY_COUNT"
    echo "   Size: $(wc -l < sci_fi_novel_daily.md) lines"
else
    echo "❌ sci_fi_novel_daily.md missing"
fi

DAILY_FILES=$(ls sci_fi_daily_*.md 2>/dev/null | wc -l)
if [ "$DAILY_FILES" -gt 0 ]; then
    echo "✅ Daily files: $DAILY_FILES found"
    LATEST_DAILY=$(ls -t sci_fi_daily_*.md | head -1)
    echo "   Latest: $LATEST_DAILY"
else
    echo "⚠️  No daily files found"
fi

DISCORD_FILES=$(ls discord_message_*.txt 2>/dev/null | wc -l)
if [ "$DISCORD_FILES" -gt 0 ]; then
    echo "✅ Discord messages: $DISCORD_FILES ready"
else
    echo "⚠️  No Discord message files"
fi
echo ""

# Check scripts
echo "⚙️  Script Status:"
echo "----------------"
if [ -x "daily_sci_fi_generator.sh" ]; then
    echo "✅ daily_sci_fi_generator.sh (executable)"
else
    echo "❌ daily_sci_fi_generator.sh missing or not executable"
fi

if [ -x "handle_sci_fi_cron.sh" ]; then
    echo "✅ handle_sci_fi_cron.sh (executable)"
else
    echo "❌ handle_sci_fi_cron.sh missing or not executable"
fi
echo ""

# Check cron job
echo "⏰ Cron Job Status:"
echo "------------------"
openclaw cron list 2>/dev/null | grep -A1 -B1 "daily-sci-fi-novel" || echo "❌ Cron job not found or error checking"
echo ""

# Test generation
echo "🧪 Quick Test:"
echo "-------------"
echo "Running test generation..."
./daily_sci_fi_generator.sh > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Story generation test passed"
    NEW_ENTRIES=$(grep -c "^## Entry " sci_fi_novel_daily.md)
    echo "   Total entries now: $NEW_ENTRIES"
else
    echo "❌ Story generation test failed"
fi
echo ""

# Show latest story snippet
echo "📖 Latest Story Preview:"
echo "-----------------------"
if [ -f "sci_fi_novel_daily.md" ]; then
    tail -5 sci_fi_novel_daily.md | grep -B5 -A5 "## Entry" | head -20
fi
echo ""
echo "✅ Status check complete!"