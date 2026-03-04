#!/bin/bash

# Handler for daily neuroscience cron job

WORKSPACE="/home/node/.openclaw/workspace"
BRAIN_DIR="$WORKSPACE/brain"
cd "$BRAIN_DIR"

echo "🧠 Daily Neuroscience Update - $(date)"
echo "====================================="

# Run the generator
./daily_neuroscience_generator.sh

# Get today's date
TODAY=$(date +"%Y-%m-%d")

echo ""
echo "📖 Latest Neuroscience Update:"
echo "----------------------------"
head -15 "neuro_daily_$TODAY.md"

echo ""
echo "📊 Stats:"
echo "--------"
echo "Total entries in neuro_daily.md: $(grep -c '^## Entry ' neuro_daily.md)"
echo "Today's update: neuro_daily_$TODAY.md"
echo "Discord message: discord_neuro_$TODAY.txt"

# Send to Discord
if [ -f "discord_neuro_$TODAY.txt" ]; then
    echo ""
    echo "📤 Sending to Discord channel 1478389372498874519..."
    DISCORD_MSG=$(cat "discord_neuro_$TODAY.txt")
    openclaw message send --channel discord --target "channel:1478389372498874519" --message "$DISCORD_MSG"
    echo "✅ Sent to Discord"
fi