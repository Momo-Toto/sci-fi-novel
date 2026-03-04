#!/bin/bash

# Daily Sci-Fi Story Generator
# Runs daily at 9:00 AM UTC

WORKSPACE="/home/node/.openclaw/workspace"
cd "$WORKSPACE"

# Get today's date
TODAY=$(date +"%Y-%m-%d")
PRETTY_DATE=$(date +"%B %d, %Y")
TIMESTAMP="$PRETTY_DATE, 9:00 AM UTC"
TOMORROW=$(date -d "+1 day" +"%B %d, %Y")

# Arrays of story elements
TITLES=("The Memory Tax" "Digital Afterlife" "Social Credit Nightmare" 
        "The Approval Algorithm" "Emotional Currency" "The Truth Filter"
        "Neural Advertising" "The Happiness Index" "Dream Surveillance"
        "The Authenticity Score" "The Echo Chamber" "Silent Consensus"
        "Digital Ghosts" "The Reality Filter" "Thought Commerce")

THEMES=(
  "In a world where memories are taxed, the wealthy can afford to remember their past while the poor live in an eternal present."
  "Digital consciousness uploads have become routine, but the uploaded minds are becoming corporate property with no rights."
  "A social credit system determines everything from job prospects to romantic matches, creating a perfectly efficient but soulless society."
  "An algorithm predicts public opinion with such accuracy that elections are now merely ceremonial confirmations of its predictions."
  "Human emotions are mined, processed, and sold as luxury experiences for the elite."
  "All information passes through government-mandated filters that remove 'unnecessary complexity' and 'potentially upsetting content'."
  "Neural implants serve personalized advertisements directly into your subconscious thoughts during dreams."
  "Citizens are required by law to maintain a minimum happiness index, with mandatory therapy for those who fall below."
  "Dreams are monitored for subversive thoughts, with 'pre-cognitive crime' units arresting people for thoughts they haven't yet acted on."
  "Every person has an authenticity score that determines their social worth, but the system can't tell real authenticity from performance."
)

PROTAGONISTS=(
  "a memory auditor for the Cognitive Revenue Service"
  "a digital afterlife technician"
  "a social credit analyst"
  "an algorithm ethics researcher"
  "an emotional commodity trader"
  "a truth filter operator"
  "a neural advertising salesperson"
  "a happiness compliance officer"
  "a dream monitor analyst"
  "an authenticity evaluation specialist"
)

CONFLICTS=(
  "discovers their own memories have been altered"
  "finds evidence the system is creating the problems it claims to solve"
  "realizes they've been enforcing a system they no longer believe in"
  "discovers a flaw that could unravel the entire social structure"
  "finds the system is rigged exclusively for the benefit of the elite"
  "realizes they've been complicit in mass psychological manipulation"
  "discovers the technology is evolving beyond human control or understanding"
  "finds their own score dropping for merely questioning the system"
  "realizes the surveillance goes much deeper than anyone publicly acknowledges"
  "discovers the scores are being used for something far more sinister than stated"
)

# Randomly select elements
TITLE_INDEX=$((RANDOM % ${#TITLES[@]}))
THEME_INDEX=$((RANDOM % ${#THEMES[@]}))
PROTAGONIST_INDEX=$((RANDOM % ${#PROTAGONISTS[@]}))
CONFLICT_INDEX=$((RANDOM % ${#CONFLICTS[@]}))

TITLE="${TITLES[$TITLE_INDEX]}"
THEME="${THEMES[$THEME_INDEX]}"
PROTAGONIST="${PROTAGONISTS[$PROTAGONIST_INDEX]}"
CONFLICT="${CONFLICTS[$CONFLICT_INDEX]}"

# Get next entry number (count existing entries)
# Use a more robust counting method
if [ -f "sci_fi_novel_daily.md" ]; then
    ENTRY_NUMBER=$(grep -c "^## Entry " sci_fi_novel_daily.md)
    ENTRY_NUMBER=$((ENTRY_NUMBER + 1))
else
    ENTRY_NUMBER=1
fi

# Generate story
STORY="## Entry $ENTRY_NUMBER: $TODAY - \"$TITLE\"

**Log Date:** $TIMESTAMP

$THEME

Jamie Chen works as $PROTAGONIST. For years, they believed in the system's noble purpose: to create order from chaos, fairness from inequality, truth from misinformation. They were good at their job—methodical, precise, unquestioning.

But this morning, Jamie $CONFLICT.

It began with an anomaly so small it should have been invisible: a data point that didn't fit the pattern, a statistical ghost in the machine. At first, Jamie assumed it was a glitch, a rounding error in the vast computational architecture that managed society. They filed the appropriate reports, flagged the irregularity, and moved on.

But the anomaly didn't disappear. It replicated. It grew. Like a crack in a dam, it spread through the system's foundations. What Jamie initially dismissed as a technical error revealed itself as something far more disturbing: a fundamental flaw in the system's design. Not a bug, but a feature. Not an accident, but intention.

The technology Jamie had dedicated their career to perfecting wasn't solving humanity's problems—it was perpetuating them in more efficient forms. The algorithm meant to ensure fairness was encoding bias. The system designed to reveal truth was manufacturing consent. The monitoring intended to provide safety was enabling control on a scale previously unimaginable.

Now Jamie faces a choice that will define not only their future but potentially the future of society itself: expose the truth and risk collapsing the fragile stability that billions depend on, or bury the evidence and become another cog in a machine they now recognize as monstrous.

As they stare at the damning data on their screen, they notice something else—records of others who found similar anomalies. Their names appear in logs followed by termination codes, transfer notices to non-existent departments, or simply blank spaces where careers should be. They were the canaries in the digital coal mine, and their silence was the warning Jamie almost missed.

The system has already flagged Jamie's unusual query patterns. They have until tomorrow morning's audit cycle to decide: join the disappeared or learn to love the machine.

The choice is theirs. The consequences belong to everyone.

**To be continued...**

---

*Next entry: $TOMORROW, 9:00 AM UTC*

"

# Append to main file
echo "$STORY" >> sci_fi_novel_daily.md

# Create daily file
echo "$STORY" > "sci_fi_daily_$TODAY.md"

# Create Discord message (truncated)
DISCORD_MESSAGE="**Daily Sci-Fi: $TITLE**

$THEME

Jamie Chen works as $PROTAGONIST. For years, they believed in the system's noble purpose...

*Read the full story in sci_fi_novel_daily.md*"

# Save Discord message to file (for cron job to pick up)
echo "$DISCORD_MESSAGE" > "discord_message_$TODAY.txt"

echo "Generated: $TITLE"
echo "Appended to sci_fi_novel_daily.md"
echo "Created sci_fi_daily_$TODAY.md"
echo "Discord message saved to discord_message_$TODAY.txt"

# If running in cron context, send to Discord
if [ "$1" = "--send-to-discord" ]; then
    echo "Attempting to send to Discord..."
    # This would be called by the cron job through OpenClaw
    echo "Message would be sent to Discord channel: openclaw-chat"
fi