#!/bin/bash

# Handler for daily sci-fi cron job
# When the agent receives "RUN_DAILY_SCI_FI_STORY", this script should be run

WORKSPACE="/home/node/.openclaw/workspace"
cd "$WORKSPACE"

echo "🕐 Daily Sci-Fi Story Generator - $(date)"
echo "========================================"

# Run the generator
./daily_sci_fi_generator.sh

# Get the latest story
LATEST_FILE=$(ls -t sci_fi_daily_*.md | head -1)
TODAY=$(date +"%Y-%m-%d")

echo ""
echo "📖 Latest Story Generated:"
echo "--------------------------"
head -20 "sci_fi_daily_$TODAY.md"

echo ""
echo "📊 Stats:"
echo "--------"
echo "Total entries in main file: $(grep -c '^## Entry ' sci_fi_novel_daily.md)"
echo "Today's story: sci_fi_daily_$TODAY.md"
echo "Discord message: discord_message_$TODAY.txt"

# For Discord integration, the cron job will handle sending the message
# The message is saved in discord_message_$TODAY.txt