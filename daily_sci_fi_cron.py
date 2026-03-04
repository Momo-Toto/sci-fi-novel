#!/usr/bin/env python3
"""
Daily Sci-Fi Novel Generator
Runs at 9:00 AM daily, generates a Black Mirror-style story,
appends to sci_fi_novel_daily.md, and posts to Discord.
"""

import os
import sys
import random
from datetime import datetime, timedelta
import subprocess

# Add OpenClaw workspace to path
workspace = "/home/node/.openclaw/workspace"
sys.path.insert(0, workspace)

def generate_story():
    """Generate a Black Mirror-style sci-fi story."""
    today = datetime.now()
    date_str = today.strftime("%Y-%m-%d")
    timestamp = today.strftime("%B %d, %Y, 9:00 AM UTC")
    
    # Story elements
    titles = [
        "The Memory Tax", "Digital Afterlife", "Social Credit Nightmare",
        "The Approval Algorithm", "Emotional Currency", "The Truth Filter",
        "Neural Advertising", "The Happiness Index", "Dream Surveillance",
        "The Authenticity Score"
    ]
    
    themes = [
        "A world where memories are taxed and the rich can afford to remember more.",
        "Digital consciousness uploads that become corporate property after death.",
        "A social credit system that determines every aspect of life.",
        "An algorithm that predicts and manipulates public opinion with 99.9% accuracy.",
        "Emotions become tradable commodities on a global exchange.",
        "All information passes through a government-mandated 'truth filter'.",
        "Neural implants serve personalized ads directly into your thoughts.",
        "Citizens are required to maintain a minimum 'happiness index'.",
        "Dreams are monitored for subversive thoughts and pre-crime.",
        "Everyone has an 'authenticity score' that determines their social worth."
    ]
    
    protagonists = [
        "a memory auditor", "a digital afterlife technician", "a social credit analyst",
        "an algorithm ethics researcher", "an emotional trader", "a truth filter operator",
        "a neural ad salesperson", "a happiness compliance officer", "a dream monitor",
        "an authenticity evaluator"
    ]
    
    conflicts = [
        "discovers a flaw in the system that could unravel society",
        "finds their own data has been manipulated",
        "realizes they're enforcing a system they no longer believe in",
        "discovers the system is creating the problems it claims to solve",
        "finds evidence the system is rigged for the elite",
        "realizes they've been complicit in mass manipulation",
        "discovers the system is evolving beyond human control",
        "finds their own score dropping for questioning the system",
        "realizes the monitoring goes deeper than anyone knew",
        "discovers the scores are being used for something sinister"
    ]
    
    # Generate story
    title = random.choice(titles)
    theme = random.choice(themes)
    protagonist = random.choice(protagonists)
    conflict = random.choice(conflicts)
    
    story = f"""## Entry {random.randint(2, 100)}: {date_str} - "{title}"

**Log Date:** {timestamp}

{theme}

Alex Rourke works as {protagonist}. Their job is to maintain the system, to ensure it runs smoothly. They've always believed in the system's purpose - to create order, efficiency, fairness.

But today, Alex {conflict}.

It started with a minor anomaly: a data point that didn't fit the pattern, a user whose behavior defied prediction models. At first, Alex assumed it was a glitch, a rounding error in the algorithm. But as they dug deeper, the anomaly grew. It wasn't a bug - it was a feature. A deliberate blind spot.

The system Alex has spent their career upholding contains a fundamental flaw, one that calls into question everything they've ever done. The very technology meant to ensure fairness is perpetuating inequality. The algorithm designed to create truth is manufacturing consent. The monitoring intended to provide safety is enabling control.

Now Alex faces an impossible choice: expose the truth and risk collapsing the fragile society that depends on the system, or maintain the lie and become complicit in something they now recognize as deeply wrong.

As they stare at the evidence on their screen, they realize there are others who have discovered this truth before them. Their names don't appear in any official records, but traces remain in the system's logs - users who asked too many questions, who followed anomalies too far, who disappeared shortly after filing reports about "system irregularities."

Alex has twenty-four hours before their own anomaly report triggers an automatic review. Twenty-four hours to decide whether to join the disappeared or become another cog in the machine.

The clock is ticking.

**To be continued...**

---

*Next entry: {(today + timedelta(days=1)).strftime('%B %d, %Y')}, 9:00 AM UTC*

"""
    
    return story, title

def append_to_main_file(story):
    """Append story to the main sci_fi_novel_daily.md file."""
    main_file = os.path.join(workspace, "sci_fi_novel_daily.md")
    
    # Read current content
    with open(main_file, 'r') as f:
        content = f.read()
    
    # Find where to insert (before the final --- line if it exists)
    if "---" in content:
        parts = content.rsplit("---", 1)
        new_content = parts[0] + story + "---" + parts[1]
    else:
        new_content = content + "\n" + story
    
    # Write back
    with open(main_file, 'w') as f:
        f.write(new_content)
    
    print(f"Appended to {main_file}")

def create_daily_file(story, date_str):
    """Create a separate file for today's story."""
    daily_file = os.path.join(workspace, f"sci_fi_daily_{date_str}.md")
    with open(daily_file, 'w') as f:
        f.write(story)
    print(f"Created daily file: {daily_file}")
    return daily_file

def send_to_discord(story, title):
    """Send story to Discord using OpenClaw CLI."""
    # Truncate story for Discord (Discord has message length limits)
    discord_message = f"**Daily Sci-Fi: {title}**\n\n"
    
    # Take first 3 paragraphs for Discord preview
    paragraphs = story.split('\n\n')
    preview = '\n\n'.join(paragraphs[:4])
    
    # Add link to full story
    discord_message += preview + "\n\n*[Full story available in sci_fi_novel_daily.md]*"
    
    # Use OpenClaw CLI to send to Discord
    # First, let's try to find the Discord channel
    cmd = ['openclaw', 'message', 'send', '--channel', 'discord', '--to', 'channel:openclaw-chat', discord_message]
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        if result.returncode == 0:
            print("Successfully sent to Discord")
        else:
            print(f"Failed to send to Discord: {result.stderr}")
            # Fallback: just log it
            with open(os.path.join(workspace, "discord_fallback.log"), "a") as f:
                f.write(f"{datetime.now()}: {result.stderr}\n")
    except Exception as e:
        print(f"Error sending to Discord: {e}")
        # Log the error
        with open(os.path.join(workspace, "discord_errors.log"), "a") as f:
            f.write(f"{datetime.now()}: {e}\n")

def main():
    print(f"Generating daily sci-fi story for {datetime.now().strftime('%Y-%m-%d')}")
    
    # Generate story
    story, title = generate_story()
    date_str = datetime.now().strftime("%Y-%m-%d")
    
    # Append to main file
    append_to_main_file(story)
    
    # Create daily file
    create_daily_file(story, date_str)
    
    # Send to Discord
    send_to_discord(story, title)
    
    print("Daily sci-fi story generation complete!")

if __name__ == "__main__":
    main()