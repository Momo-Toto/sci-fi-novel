# Daily Systems Setup

## 📅 Two Automated Daily Systems

### System 1: Daily Sci-Fi Novel (Black Mirror Style)
**Channel:** `1478264739250442281`
**Schedule:** 7:00 AM local time (13:00 UTC)
**Cron Job ID:** `aa5a2b19-36da-4441-b831-2c66add23137`
**Trigger Message:** `RUN_DAILY_SCI_FI_STORY`
**Files:** `sci_fi_novel_daily.md`, daily files in workspace root

### System 2: Daily Neuroscience Updates
**Channel:** `1478389372498874519`
**Schedule:** 7:30 AM local time (13:30 UTC)
**Cron Job ID:** `108f3bd2-74db-41e1-a9c9-b64e60039974`
**Trigger Message:** `RUN_DAILY_NEUROSCIENCE_UPDATE`
**Files:** `brain/neuro_daily.md`, daily files in brain folder

## 🕗 Timezone Note
Both systems are scheduled for **your local morning** (assuming UTC-6):
- **7:00 AM your time** = 13:00 UTC (Sci-Fi)
- **7:30 AM your time** = 13:30 UTC (Neuroscience)

If your timezone is different, adjust the cron expressions accordingly.

## 📁 File Structure

```
Workspace Root/
├── sci_fi_novel_daily.md          # All sci-fi stories
├── sci_fi_daily_YYYY-MM-DD.md     # Daily sci-fi stories
├── discord_message_YYYY-MM-DD.txt # Sci-fi Discord messages
├── daily_sci_fi_generator.sh      # Sci-fi generator
├── test_full_system.sh            # System test
├── check_sci_fi_status.sh         # Status check
└── brain/                         # Neuroscience system
    ├── neuro_daily.md             # All neuroscience updates
    ├── neuro_daily_YYYY-MM-DD.md  # Daily neuroscience
    ├── discord_neuro_YYYY-MM-DD.txt # Neuroscience Discord messages
    ├── daily_neuroscience_generator.sh # Neuroscience generator
    └── handle_neuroscience_cron.sh    # Cron handler
```

## 🚀 Quick Start Commands

### Sci-Fi System:
```bash
# Generate sci-fi story now
./daily_sci_fi_generator.sh

# Test full system
./test_full_system.sh

# Check status
./check_sci_fi_status.sh
```

### Neuroscience System:
```bash
# Generate neuroscience update now
cd brain && ./daily_neuroscience_generator.sh

# Test neuroscience system
cd brain && ./handle_neuroscience_cron.sh
```

## 🔧 Management Commands

### View All Cron Jobs:
```bash
openclaw cron list
```

### Run Jobs Manually:
```bash
# Sci-fi
openclaw cron run aa5a2b19-36da-4441-b831-2c66add23137

# Neuroscience
openclaw cron run 108f3bd2-74db-41e1-a9c9-b64e60039974
```

### Disable/Enable:
```bash
# Disable
openclaw cron disable aa5a2b19-36da-4441-b831-2c66add23137
openclaw cron disable 108f3bd2-74db-41e1-a9c9-b64e60039974

# Enable
openclaw cron enable aa5a2b19-36da-4441-b831-2c66add23137
openclaw cron enable 108f3bd2-74db-41e1-a9c9-b64e60039974
```

## 🎭 Content Details

### Sci-Fi Stories:
- **Style:** Black Mirror-inspired tech dystopias
- **Length:** 300-500 words
- **Themes:** Memory taxation, social credit, algorithmic control, emotional commodification
- **Structure:** Protagonist discovers system flaw, faces ethical dilemma
- **Ending:** "To be continued..." cliffhanger

### Neuroscience Updates:
- **Topics:** 15+ neuroscience areas rotated daily
- **Content:** Research highlights, practical applications, quotes
- **Sources:** Recent studies (2024-2026), methodological advances
- **Format:** Key concept, research highlights, applications, quote
- **Focus:** Evidence-based, practical neuroscience

## ✅ Current Status

### Sci-Fi System:
- ✅ Channel: `1478264739250442281` configured
- ✅ Schedule: 7:00 AM local time (13:00 UTC)
- ✅ Tested: Messages successfully sent
- ✅ Archive: `sci_fi_novel_daily.md` (8+ stories)

### Neuroscience System:
- ✅ Channel: `1478389372498874519` configured
- ✅ Schedule: 7:30 AM local time (13:30 UTC)
- ✅ Tested: Messages successfully sent
- ✅ Archive: `brain/neuro_daily.md` (2+ updates)

## 🎯 Next Deliveries

**Tomorrow:**
- **7:00 AM your time:** New sci-fi story to channel `1478264739250442281`
- **7:30 AM your time:** Neuroscience update to channel `1478389372498874519`

## 🆘 Troubleshooting

### Discord Issues:
```bash
# Test sci-fi channel
openclaw message send --channel discord --target "channel:1478264739250442281" --message "Test"

# Test neuroscience channel
openclaw message send --channel discord --target "channel:1478389372498874519" --message "Test"
```

### Timezone Adjustment:
If times are wrong, update cron expressions:
- `0 13 * * *` = 13:00 UTC (7:00 AM UTC-6)
- `30 13 * * *` = 13:30 UTC (7:30 AM UTC-6)

Use [crontab.guru](https://crontab.guru) for help with cron expressions.

## 📝 Notes

1. Both systems generate content even if Discord fails
2. All content is archived locally for backup
3. Discord messages are truncated previews with links to full content
4. Systems are independent - one can fail without affecting the other
5. Content is randomly selected from pools for variety

---

*Last updated: March 3, 2026*
*Both systems tested and operational*