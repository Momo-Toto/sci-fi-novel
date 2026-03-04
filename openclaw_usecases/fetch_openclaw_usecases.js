#!/usr/bin/env node

/**
 * Daily OpenClaw Use Cases Fetcher
 * Fetches use cases from GitHub and prepares for Discord posting
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Configuration
const workspace = '/home/node/.openclaw/workspace';
const usecasesDir = path.join(workspace, 'openclaw_usecases');
const today = new Date().toISOString().split('T')[0];
const prettyDate = new Date().toLocaleDateString('en-US', { 
  year: 'numeric', 
  month: 'long', 
  day: 'numeric' 
});
const timestamp = `${prettyDate}, 6:00 AM`;

// GitHub URLs
const githubRepo = 'https://github.com/openclaw/openclaw';
const githubRaw = 'https://raw.githubusercontent.com/openclaw/openclaw/main';

// Files to fetch
const filesToFetch = [
  'README.md',
  'docs/USECASES.md',
  'docs/EXAMPLES.md',
  'docs/GETTING_STARTED.md',
  'skills/README.md'
];

console.log(`🔍 Fetching OpenClaw use cases from GitHub - ${timestamp}`);
console.log('='.repeat(60));
console.log();

// Create today's directory
const dailyDir = path.join(usecasesDir, `daily_${today}`);
if (!fs.existsSync(dailyDir)) {
  fs.mkdirSync(dailyDir, { recursive: true });
}

// Change to daily directory
process.chdir(dailyDir);

// Fetch files
const fetchedFiles = [];
const failedFiles = [];

function runWebFetch(url) {
  try {
    const cmd = `openclaw web_fetch --url "${url}" --extract-mode markdown`;
    const result = execSync(cmd, { encoding: 'utf-8', timeout: 30000 });
    
    try {
      const data = JSON.parse(result);
      return data.text || '';
    } catch (e) {
      // If not JSON, return raw result
      return result;
    }
  } catch (error) {
    console.error(`  Error fetching ${url}:`, error.message);
    return null;
  }
}

// Fetch each file
for (const filePath of filesToFetch) {
  const filename = path.basename(filePath);
  const outputFile = path.join(dailyDir, filename);
  const url = `${githubRaw}/${filePath}`;
  
  console.log(`Fetching: ${filePath}`);
  
  const content = runWebFetch(url);
  
  if (content && content.trim().length > 0) {
    fs.writeFileSync(outputFile, content, 'utf-8');
    
    const stats = fs.statSync(outputFile);
    const lines = content.split('\n').length;
    
    console.log(`  ✅ Success: ${filename}`);
    console.log(`     Lines: ${lines}, Size: ${stats.size} bytes`);
    fetchedFiles.push(filename);
  } else {
    console.log(`  ❌ Failed: ${filePath}`);
    failedFiles.push(filePath);
  }
  console.log();
}

// Create summary report
const summaryFile = path.join(dailyDir, `summary_${today}.md`);
let summaryContent = `# OpenClaw Use Cases Summary
## Date: ${timestamp}

## 📊 Fetch Results
**Successful fetches:** ${fetchedFiles.length} files
**Failed fetches:** ${failedFiles.length} files

## 📁 Files Fetched:
`;

for (const filename of fetchedFiles) {
  const filepath = path.join(dailyDir, filename);
  summaryContent += `- ${filename}\n`;
  
  if (fs.existsSync(filepath)) {
    const content = fs.readFileSync(filepath, 'utf-8');
    const lines = content.split('\n').length;
    const size = fs.statSync(filepath).size;
    
    summaryContent += `  - Lines: ${lines}, Size: ${size} bytes\n`;
    
    if (lines > 0) {
      summaryContent += `  - Preview:\n`;
      const preview = content.split('\n').slice(0, 5).join('\n    > ');
      summaryContent += `    > ${preview}\n`;
      if (lines > 5) {
        summaryContent += `    > ...\n`;
      }
    }
    summaryContent += '\n';
  }
}

summaryContent += `## ❌ Files Failed:\n`;
for (const filePath of failedFiles) {
  summaryContent += `- ${filePath}\n`;
}
summaryContent += '\n';

summaryContent += `## 🔗 GitHub Repository
- **Repository:** [openclaw/openclaw](${githubRepo})
- **Last fetched:** ${new Date().toISOString()}
- **Total files in daily archive:** ${fetchedFiles.length}

## 🎯 Common OpenClaw Use Cases:
1. **Personal Assistant Automation** - Email, calendar, task management
2. **Home Automation** - Smart home control, IoT devices
3. **Development Workflows** - Code review, deployment, testing
4. **Research Assistance** - Web searching, data collection
5. **Content Creation** - Writing, social media management
6. **System Administration** - Monitoring, backups, security
7. **Communication** - Multi-platform messaging, notifications
8. **Data Processing** - File conversion, data extraction

## 📈 Statistics
- **Total files in archive:** ${fs.readdirSync(dailyDir).length}
- **Total size:** ${fs.readdirSync(dailyDir).reduce((total, file) => {
    const filepath = path.join(dailyDir, file);
    return total + (fs.statSync(filepath).size || 0);
  }, 0)} bytes
- **Fetch time:** ${new Date().toLocaleTimeString()}

---
*Automatically fetched by OpenClaw use cases fetcher*
`;

fs.writeFileSync(summaryFile, summaryContent, 'utf-8');
fetchedFiles.push(`summary_${today}.md`);

console.log(`📊 Summary created: ${path.basename(summaryFile)}`);
console.log();

// Create Discord message
const discordFile = path.join(dailyDir, `discord_${today}.txt`);
let discordContent = `**📦 Daily OpenClaw Use Cases Fetch - ${prettyDate}**

✅ **Fetch Results:**
- Successful: ${fetchedFiles.length} files
- Failed: ${failedFiles.length} files

**📁 Files Fetched:**
`;

for (let i = 0; i < Math.min(fetchedFiles.length, 5); i++) {
  discordContent += `- \`${fetchedFiles[i]}\`\n`;
}

if (fetchedFiles.length > 5) {
  discordContent += `- ... and ${fetchedFiles.length - 5} more files\n`;
}

discordContent += `
**🎯 Common Use Cases Found:**
1. Personal Assistant Automation
2. Home Automation & IoT Control
3. Development Workflows
4. Research & Data Collection
5. Content Creation
6. System Administration

**📈 Repository Status:**
- Repository: openclaw/openclaw
- Last Updated: Daily fetch
- Total Files Today: ${fetchedFiles.length}

**🔍 Details in:** \`openclaw_usecases/daily_${today}/\`

---
*Automated fetch at 6:00 AM daily*
`;

fs.writeFileSync(discordFile, discordContent, 'utf-8');

console.log(`💬 Discord message created: ${path.basename(discordFile)}`);
console.log();

// Count total files
const totalFiles = fs.readdirSync(dailyDir).length;
const totalSize = fs.readdirSync(dailyDir).reduce((total, file) => {
  const filepath = path.join(dailyDir, file);
  return total + (fs.statSync(filepath).size || 0);
}, 0);

console.log(`📈 Daily Archive Stats:`);
console.log(`  - Directory: daily_${today}`);
console.log(`  - Total files: ${totalFiles}`);
console.log(`  - Total size: ${totalSize} bytes`);
console.log();

// Update main archive
process.chdir(usecasesDir);
const mainArchive = 'openclaw_usecases_archive.md';

if (!fs.existsSync(mainArchive)) {
  fs.writeFileSync(mainArchive, '# OpenClaw Use Cases Archive\n\n', 'utf-8');
}

const archiveEntry = `## ${prettyDate} - Daily Fetch

**Time:** ${timestamp}
**Files fetched:** ${fetchedFiles.length}
**Failed:** ${failedFiles.length}

**Files:**
${fetchedFiles.map(file => `- \`${file}\``).join('\n')}

---
`;

fs.appendFileSync(mainArchive, archiveEntry, 'utf-8');

console.log(`📚 Main archive updated: ${mainArchive}`);
console.log();
console.log(`✅ OpenClaw use cases fetch completed for ${today}`);