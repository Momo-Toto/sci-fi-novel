# Daily Sci-Fi Novel Setup

## Overview
This system automatically generates a Black Mirror-style sci-fi story every day at 9:00 AM UTC, saves it to `sci_fi_novel_daily.md`, and posts it to your Discord channel.

## Files Created

1. **`sci_fi_novel_daily.md`** - Main file containing all daily stories
2. **`sci_fi_daily_YYYY-MM-DD.md`** - Individual daily story files
3. **`daily_sci_fi_cron.py`** - Python script that generates stories
4. **`generate_sci_fi_story.sh`** - Bash script alternative
5. **`test_sci_fi_generator.sh`** - Test script to manually generate a story

## Cron Job

A cron job has been set up with the following configuration:
- **Name:** `daily-sci-fi-novel`
- **Schedule:** `0 7 * * *` (7:00 AM UTC daily)
- **Agent:** `main`
- **Discord Channel ID:** `1478264739250442281` ✅ **WORKING**
- **Job ID:** `ba076918-e3b6-4a74-b51d-610216b272f6`
- **Trigger Message:** `RUN_DAILY_SCI_FI_STORY`

**Status:** ✅ **Fully operational** - Discord integration tested and working!

## How It Works

1. Every day at 9:00 AM UTC, OpenClaw's cron system triggers the job
2. The job sends a message to the main agent session
3. The agent runs the story generation logic
4. A new Black Mirror-style story is generated with:
   - A unique title from a pool of sci-fi concepts
   - A dystopian theme exploring technology's impact on society
   - A protagonist facing an ethical dilemma
   - An open-ended conclusion
5. The story is appended to `sci_fi_novel_daily.md`
6. A separate daily file is created
7. A preview is posted to the Discord channel `openclaw-chat`

## Story Themes

The generator uses these Black Mirror-inspired themes:
- Memory manipulation and taxation
- Social credit systems
- Algorithmic control of society
- Emotional commodification
- Truth manipulation and filtering
- Neural surveillance and advertising
- Digital afterlife and consciousness
- Dream monitoring and thought crime
- Authenticity scoring and social worth

## Manual Testing

To test the system manually:
```bash
./test_sci_fi_generator.sh
```

Or run the Python script directly:
```bash
python3 daily_sci_fi_cron.py
```

## Managing the Cron Job

View cron jobs:
```bash
openclaw cron list
```

Run the job manually (for testing):
```bash
openclaw cron run f993d5bf-ab0c-4470-94a9-3dae5b9e2626
```

Disable the job:
```bash
openclaw cron disable f993d5bf-ab0c-4470-94a9-3dae5b9e2626
```

Enable the job:
```bash
openclaw cron enable f993d5bf-ab0c-4470-94a9-3dae5b9e2626
```

Remove the job:
```bash
openclaw cron rm f993d5bf-ab0c-4470-94a9-3dae5b9e2626
```

## Customization

To modify the story generation:
1. Edit `daily_sci_fi_cron.py` to change:
   - Story themes and titles
   - Story structure and length
   - Character types and conflicts

2. To change the Discord channel, update the cron job:
   ```bash
   openclaw cron rm f993d5bf-ab0c-4470-94a9-3dae5b9e2626
   openclaw cron add --name "daily-sci-fi-novel" --description "Generate and post daily Black Mirror-style sci-fi story" --cron "0 9 * * *" --message "Generate today's Black Mirror-style sci-fi novel, append to sci_fi_novel_daily.md, and post to Discord" --agent main --announce --to "channel:YOUR_CHANNEL_ID" --channel discord
   ```

3. To change the schedule, update the cron expression:
   - `0 9 * * *` = 9:00 AM daily
   - `0 18 * * *` = 6:00 PM daily
   - `0 9 * * 1` = 9:00 AM every Monday
   - `0 9 1 * *` = 9:00 AM on the 1st of every month

## Notes

- Stories are generated in UTC timezone
- Each story is approximately 300-500 words
- The system maintains a continuous narrative across days
- Discord messages are truncated previews with links to the full story
- All stories are saved locally for archival purposes

## Troubleshooting

### Discord Issues
If stories aren't appearing in Discord, you need to find the correct channel ID:

1. **Enable Developer Mode in Discord:**
   - Open Discord → User Settings → Advanced
   - Enable "Developer Mode"

2. **Find Your Channel ID:**
   - Right-click on the channel where you want stories posted
   - Select "Copy ID"
   - The ID will be a long number like `123456789012345678`

3. **Update the Cron Job:**
   ```bash
   # Remove the existing job
   openclaw cron rm c43cf826-0051-4e01-88ba-296153ba9e67
   
   # Create new job with correct channel ID
   openclaw cron add --name "daily-sci-fi-novel" \
     --description "Generate and post daily Black Mirror-style sci-fi story" \
     --cron "0 9 * * *" \
     --message "RUN_DAILY_SCI_FI_STORY" \
     --agent main \
     --announce \
     --to "channel:YOUR_CHANNEL_ID_HERE" \
     --channel discord
   ```

4. **Test Discord Sending:**
   ```bash
   # Test sending a message to Discord
   openclaw message send --channel discord --target "channel:YOUR_CHANNEL_ID_HERE" --message "Test: Sci-Fi System"
   ```

### General Troubleshooting
1. Verify the cron job is enabled: `openclaw cron list`
2. Check for errors in the cron run history: `openclaw cron runs --id YOUR_JOB_ID`
3. Look for error logs in workspace files
4. Test story generation manually: `./daily_sci_fi_generator.sh`

### Fallback Option
If Discord continues to have issues, the stories will still be generated and saved to:
- `sci_fi_novel_daily.md` (all stories)
- `sci_fi_daily_YYYY-MM-DD.md` (individual daily stories)
- `discord_message_YYYY-MM-DD.txt` (Discord-ready messages)

You can manually copy from `discord_message_YYYY-MM-DD.txt` to Discord if needed.

If you want to change the model used for generation, update the cron job with `--model` flag when recreating it.