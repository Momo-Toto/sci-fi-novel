#!/bin/bash

echo "Testing Sci-Fi Story Generator"
echo "=============================="

# Run the Python script
cd /home/node/.openclaw/workspace
python3 daily_sci_fi_cron.py

echo ""
echo "Checking generated files:"
echo "-------------------------"
ls -la sci_fi_*.md
echo ""
echo "Latest entry in sci_fi_novel_daily.md:"
echo "--------------------------------------"
tail -50 sci_fi_novel_daily.md