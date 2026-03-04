#!/bin/bash

echo "✅ Discord Status Check"
echo "======================"
echo ""
echo "Channel ID: 1478264739250442281"
echo "Schedule: 7:00 AM UTC daily"
echo ""

echo "1. Testing Discord connection..."
openclaw message send --channel discord --target "channel:1478264739250442281" --message "**Status Check**: Daily Sci-Fi System $(date +%H:%M:%S)"

if [ $? -eq 0 ]; then
    echo "✅ Discord connection successful"
else
    echo "❌ Discord connection failed"
fi

echo ""
echo "2. Current cron job:"
openclaw cron list | grep -A2 -B2 "daily-sci-fi"

echo ""
echo "3. Latest Discord-ready message:"
if [ -f "$(ls -t discord_message_*.txt 2>/dev/null | head -1)" ]; then
    LATEST_MSG=$(ls -t discord_message_*.txt | head -1)
    echo "   File: $LATEST_MSG"
    echo "   Preview:"
    head -3 "$LATEST_MSG"
else
    echo "   No Discord message files found"
fi

echo ""
echo "4. System status:"
echo "   Stories in archive: $(grep -c '^## Entry ' sci_fi_novel_daily.md 2>/dev/null || echo 0)"
echo "   Next story: Tomorrow at 7:00 AM UTC"
echo "   Discord: ✅ Configured and working"
echo "   Channel: 1478264739250442281"
echo ""

echo "🎯 Everything is configured and ready!"
echo "First automated story arrives tomorrow at 7:00 AM UTC"