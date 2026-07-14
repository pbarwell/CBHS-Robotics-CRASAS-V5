# CBHS Robotics CRASAS V5 — Tinkering Guide

This guide is designed for users who want to modify and customize the workflow's prompting strategy, adapt it for different games, or implement new scouting features.

---

## Customizing AI Prompts

The core intelligence of the workflow relies on two main prompt locations:

### 1. Vision Caption Prompt
* **Location**: `Gemini Vision Caption` node under `jsCode` -> `const prompt = ...`
* **Purpose**: Instructs Gemini on how to analyze YouTube robotics matches/reveals.
* **Customization Advice**:
  - **Tuning Anti-Hallucination**: If the AI incorrectly identifies mechanisms, update the `CRITICAL RULE CONSTRAINTS & ANTI-HALLUCINATION` block in the prompt with more explicit instructions (e.g., prohibiting description of hidden components like internal gearing or sensors unless visible).
  - **Exclusion Filters**: Update the `If this footage shows...` line to skip videos that don't match the active VEX game.

### 2. Meta Scouting Report Prompt
* **Location**: `Prompt and Summary` node under `jsCode` -> `systemPrompt` and `userPrompt` variables.
* **Purpose**: Synthesizes the individual video captions into a cohesive markdown intelligence report.
* **Customization Advice**:
  - **Layout Changes**: You can modify the markdown headers under the table of contents block (`## Contents` and section headings) to add or remove sections. Make sure the instructions in `userPrompt` match the section headers exactly.

---

## Changing Games

When the VEX V5 Robotics Competition season updates:
1. **Search Terms**: Update the search query parameters (`q` value) in both `YouTube Search` nodes to search for the new game name.
2. **Game Rules & Limits**: Update the `VERIFIED GAME DESCRIPTION` and the `POSSESSION RULE` inside the prompts in both `Gemini Vision Caption` and `Prompt and Summary` nodes to prevent the AI from applying old game rules to new videos.

---

## Adding New Features

### 1. Tracking a Specific Team's Progress
If you want to track a particular team (e.g., Team `2976A` or a key rival team `XXXX`):
* **Option A (AI-driven)**: Add a specific instruction in the `userPrompt` of the `Prompt and Summary` node:
  ```javascript
  `Search the provided video data specifically for Team XXXX. If found, add a dedicated subsection inside 'High-Value Teams and Channels' analyzing their design choices and match strategies.`
  ```
* **Option B (Rule-driven)**: Modify the javascript in the `Merge Stats` node to ensure videos containing their team number in the title/description are never filtered out, even if they are very short or long:
  ```javascript
  const isTargetTeam = meta.title.includes('XXXX') || meta.description.includes('XXXX');
  // Adjust skip logic
  skipVideo: isTargetTeam ? false : (seconds > 1080 || seconds < 10)
  ```

### 2. Separating Design Reveals from Match Strategy Reports
To create separate digests for reveals/CAD vs. actual competition matches:
* Insert an n8n **Filter** node after `Merge Stats` to route videos where the classification is `"Official Reveal / Rules"` or `"CAD / Design Concept"` to one report template, and competition videos to another.
