# Daily Sci-Fi Novel Generator

An automated system that generates Black Mirror-style sci-fi stories daily and posts them to Discord.

## 🚀 Features

- **Daily Automation**: Generates new stories every day at 7:00 AM local time
- **Black Mirror Style**: Tech dystopia stories with ethical dilemmas
- **Discord Integration**: Automatically posts to specified Discord channels
- **Local Archive**: All stories saved locally for backup
- **Cron Job Management**: Easy scheduling and management

## 📖 Sample Story

```markdown
## Entry 1: March 3, 2026 - "The Memory Tax"

**Log Date:** March 3, 2026, 9:00 AM UTC

In the year 2048, memories have become a commodity. The government introduced the "Memory Tax" - a system where citizens pay for their ability to remember. The richer you are, the more of your past you can retain...

**To be continued...**
```

## 🛠️ Setup

### Prerequisites
- OpenClaw installed and configured
- Discord bot with proper permissions
- Discord channel ID

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/Momo-Toto/sci-fi-novel.git
   cd sci-fi-novel
   ```

2. Make scripts executable:
   ```bash
   chmod +x daily_sci_fi_generator.sh handle_sci_fi_cron.sh test_full_system.sh
   ```

3. Configure Discord channel:
   - Update channel ID in scripts or set via environment variable
   - Ensure Discord bot has proper permissions

### Configuration
1. **Schedule**: Configured for 7:00 AM local time (13:00 UTC)
2. **Discord Channel**: Set your channel ID in the cron job
3. **Archive**: Stories saved to `sci_fi_novel_daily.md`

## 🔧 Usage

### Generate a Story Now
```bash
./daily_sci_fi_generator.sh
```

### Test Full System
```bash
./test_full_system.sh
```

### Check System Status
```bash
./check_sci_fi_status.sh
```

## ⚙️ Automation

### Cron Job Setup
The system uses OpenClaw's cron system:
```bash
# View cron jobs
openclaw cron list

# Run manually
openclaw cron run [job-id]

# Schedule: 7:00 AM local time (13:00 UTC)
```

### File Structure
```
sci-fi-novel/
├── sci_fi_novel_daily.md          # All stories archive
├── daily_sci_fi_generator.sh      # Story generator
├── handle_sci_fi_cron.sh          # Cron handler
├── test_full_system.sh            # System test
├── check_sci_fi_status.sh         # Status checker
├── README.md                      # This file
└── SCI_FI_NOVEL_SETUP.md          # Detailed setup guide
```

## 🎭 Story Generation

### Themes
- Memory taxation and manipulation
- Social credit systems
- Algorithmic control of society
- Emotional commodification
- Truth manipulation and filtering
- Neural surveillance

### Structure
Each story follows:
1. **Setting**: Dystopian tech world
2. **Protagonist**: System worker discovering flaws
3. **Conflict**: Ethical dilemma
4. **Cliffhanger**: "To be continued..."

### Content Pool
- **15+ unique titles**
- **10+ different themes**
- **10+ protagonist types**
- **10+ conflict scenarios**
- Random combinations daily

## 📊 Statistics

- **Stories Generated**: 9+ (and counting)
- **Word Count**: 300-500 words per story
- **Schedule**: Daily at 7:00 AM local time
- **Archive**: Complete history in `sci_fi_novel_daily.md`

## 🔗 Integration

### Discord
- **Channel**: Configurable Discord channel
- **Format**: Truncated preview with link to full story
- **Frequency**: Daily at scheduled time

### OpenClaw
- **Cron System**: Uses OpenClaw's built-in scheduling
- **Agent Integration**: Runs in isolated sessions
- **Tool Usage**: Leverages OpenClaw's messaging tools

## 🚀 Quick Start

1. **Clone the repo**
2. **Configure Discord channel ID**
3. **Test with `./test_full_system.sh`**
4. **Schedule cron job for daily automation**

## 📝 Documentation

- [SCI_FI_NOVEL_SETUP.md](SCI_FI_NOVEL_SETUP.md) - Detailed setup guide
- [DAILY_SYSTEMS_SETUP.md](DAILY_SYSTEMS_SETUP.md) - Multi-system setup
- [THREE_DAILY_SYSTEMS.md](THREE_DAILY_SYSTEMS.md) - Complete system overview

## 🤝 Contributing

Feel free to:
- Add new story themes and titles
- Improve story generation algorithms
- Add new integration features
- Report issues or suggest improvements

## 📄 License

This project is open source and available for personal and educational use.

## 🙏 Acknowledgments

- Inspired by Black Mirror's tech dystopia themes
- Built with OpenClaw automation platform
- Community feedback and suggestions

---

**Created by**: Momo-Toto  
**GitHub**: [Momo-Toto](https://github.com/Momo-Toto)  
**Email**: irt5032@gmail.com  
**Last Updated**: March 4, 2026