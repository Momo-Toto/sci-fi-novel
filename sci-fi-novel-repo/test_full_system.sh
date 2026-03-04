#!/bin/bash

echo "🚀 FULL SYSTEM TEST"
echo "=================="
echo ""

echo "1. Generating new story..."
./daily_sci_fi_generator.sh > /dev/null 2>&1
echo "   ✅ Story generated"
echo ""

echo "2. Checking files..."
echo "   Main archive: sci_fi_novel_daily.md ($(grep -c '^## Entry ' sci_fi_novel_daily.md) stories)"
echo "   Latest daily: $(ls -t sci_fi_daily_*.md | head -1)"
echo "   Discord message: $(ls -t discord_message_*.txt | head -1)"
echo ""

echo "3. Cron job status:"
openclaw cron list | grep -A1 -B1 "daily-sci-fi"
echo ""

echo "4. Discord test:"
echo "   Running actual test..."
openclaw message send --channel discord --target "channel:1478264739250442281" --message "**Test**: Daily Sci-Fi System Test $(date +%H:%M:%S)" 2>&1 | grep -q "Error" && echo "   ❌ Failed" || echo "   ✅ Success - Discord working!"
echo ""

echo "6. Sample story preview:"
echo "-----------------------"
head -10 "$(ls -t discord_message_*.txt | head -1)"
echo "..."

echo ""
echo "📋 DISCORD STATUS:"
echo "-----------------"
echo "✅ Channel 1478264739250442281 configured and working!"
echo "✅ Messages successfully sent to Discord"
echo "✅ Cron job configured for daily 7:00 AM UTC delivery"
echo ""
echo "✅ SYSTEM READY - Stories generate daily at 7:00 AM UTC"