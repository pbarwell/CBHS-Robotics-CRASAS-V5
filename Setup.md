# CRASAS Installation Guide

CRASAS runs on [n8n](https://n8n.io), a local workflow automation tool, and uses the Google Gemini and YouTube Data APIs for video analysis and report generation. Follow these steps to get it running on your machine.

> **Tested on:** macOS 26.4 (Apple Silicon). Windows instructions are included and should work, but have not been verified.

---

## Step 1 — Install and Verify Dependencies

| # | What | Command | Notes |
|---|------|---------|-------|
| 1 | Node.js | Download via Homebrew (`brew install node @24`) or from [nodejs.org](https://nodejs.org) | v24 used; v22 or higher should work |
| 2 | Verify Node | `node --version` | Should print v24.22.1 or similar |
| 3 | n8n | `npm install -g n8n` | Installs n8n globally |
| 4 | md-to-pdf | `npm install -g md-to-pdf` | Converts reports to PDF |
| 5 | Verify n8n | `npx n8n --version` | Should print 2.12.2 or similar |
| 6 | Verify md-to-pdf | `md-to-pdf --version` | Should print 5.2.5 or similar |

---

## Step 2 — Get Your API Keys

You need two API keys. Keep these private and never share them or commit them to a public repository.

| # | Key | Instructions | Where to find it |
|---|-----|-------------|-----------------|
| 1 | YouTube Data API v3 | [Enable the YouTube Data API](https://developers.google.com/youtube/v3/getting-started) | Google Cloud Console → APIs & Services → Credentials |
| 2 | Gemini API | [Get a Gemini API key](https://ai.google.dev/gemini-api/docs/api-key) | Google AI Studio → Get API Key |
| 3 | Gemini Billing | [Enable billing](https://ai.google.dev/gemini-api/docs/billing) | Required to avoid daily rate limits — costs cents per run |

---

## Step 3 — Download the Workflow

| # | Action | Notes |
|---|--------|-------|
| 1 | Download `CBHS_Robotics_CRASAS.json` from this repository | Use the green Code button → Download ZIP, or clone the repo |
| 2 | Place it anywhere accessible on your machine | You will import it into n8n in Step 6 |

---

## Step 4 — Configure the Start Script

Download the start script for your operating system from this repository.

### macOS — `crasas-start.command`

Open the file in TextEdit and fill in your API keys:

```bash
GEMINI_API_KEY=YOUR_GEMINI_API_KEY \
```

Then make it executable by running this once in Terminal:

```bash
chmod +x /path/to/crasas-start.command
```

You can then launch CRASAS by double-clicking the `.command` file in Finder.

### Windows — `crasas-start.bat`

Open the file in Notepad and fill in your API keys:

```bat
set GEMINI_API_KEY=YOUR_GEMINI_API_KEY
```

Run it by double-clicking the `.bat` file in Explorer, or by running it from Command Prompt.

> **Note:** If you see a SmartScreen warning, click **More info → Run anyway**. The script is not signed. Also be aware that the command taskkill /F /IM node.exe kills all Node processes including any Node-based tools.

---

## Step 5 — Set Your Reports Folder

Before importing the workflow, open `CBHS_Robotics_CRASAS.json` in a text editor and find the path placeholder in the Save Report node. Replace it with a folder path of your choice:
/Path/To/Your/Folder

**MacOS example:**
/Users/yourname/Documents/CRASAS Reports

**Windows example:**
C:\Users\yourname\Documents\CRASAS Reports

> Make sure the folder exists before running the workflow — n8n will not create it automatically.

---

## Step 6 — Import the Workflow into n8n

| # | Action |
|---|--------|
| 1 | Run your start script to launch n8n |
| 2 | Press 'o' or open your browser and go to `http://127.0.0.1:5678` |
| 3 | Create a free local account when prompted |
| 4 | Click the **+** button to create a new workflow |
| 5 | Click the three-dot menu (⋯) → **Import from file** |
| 6 | Select `CBHS_Robotics_CRASAS.json` |
| 7 | The workflow will appear — click **Save** |

---

## Step 7 — Add Your API Keys to the Workflow

The two API keys need to be pasted directly into the workflow nodes.

| # | Node | Replace | Change to |
|---|------|---------|-----------|
| 1 | YouTube Search (both nodes) | YOUR_YOUTUBE_DATA_KEY | Your YouTube Data API v3 key |
| 2 | Gemini Vision Caption | YOUR_GEMINI_API_KEY | Your Gemini API key |
| 3 | Prompt and Summary | YOUR_GEMINI_API_KEY | Your Gemini API key |

---

## Step 8 — Run CRASAS

| # | Action |
|---|--------|
| 1 | Launch n8n using your start script |
| 2 | Open `http://127.0.0.1:5678` in your browser |
| 3 | Open the CRASAS workflow |
| 4 | Click **Execute Workflow** |
| 5 | The pipeline takes 10–20 minutes depending on how many videos are analysed |
| 6 | Find your report in the folder you configured in Step 5 |

---

## Stopping n8n

**macOS:** Press `Ctrl+C` in the Terminal window where n8n is running.

**Windows:** Close the Command Prompt window where n8n is running.
