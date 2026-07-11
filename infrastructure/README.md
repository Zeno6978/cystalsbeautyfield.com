# AI Symphony Infrastructure

**Crystal Clear Communication LLC copyright 2026 Bobby Shepherd**  
**Licensed under Apache 2.0**

## Overview

This directory contains the complete infrastructure for the AI Symphony — a multi-model orchestration system running on two Azure VMs that coordinates Manus, DeepSeek, Claude, Gemini, and VS Code/Copilot to build software, generate video content, and maintain redundant backups.

## Architecture

| Component | Location | Purpose |
| :--- | :--- | :--- |
| Azure Backup | `azure-backup/` | Application-consistent VM backups with pre/post scripts |
| AI Router | `ai-router/` | Intelligent task routing to the optimal LLM per task type |
| Orchestrator | `orchestrator/` | Agent coordination, issue tracking, and CI/CD integration |
| Video Pipeline | `video-pipeline/` | Automated video generation and multi-platform publishing |

## VM Configuration

| VM | Azure Size | Role | OS |
| :--- | :--- | :--- | :--- |
| Orchestrator | Standard B2s (2 vCPU, 4GB) | Conducts the symphony, runs the router | Ubuntu 22.04 LTS |
| Builder | Standard D8s v3 (8 vCPU, 32GB) | Heavy AI processing, video rendering | Ubuntu 22.04 LTS |

## Quick Start

### Step 1: Set Up Azure Backup

```bash
chmod 700 azure-backup/pre-script.sh azure-backup/post-script.sh
chmod +x azure-backup/setup-backup.sh
./azure-backup/setup-backup.sh
```

### Step 2: Configure the AI Router

```bash
cd ai-router
pip install -r requirements.txt
export ANTHROPIC_API_KEY=<your-key>
export DEEPSEEK_API_KEY=<your-key>
python router.py
```

### Step 3: Launch the Orchestrator

```bash
cd orchestrator
# Edit config.json with your API keys and VM IPs
# Then start the orchestrator (smol-symphony or Contrabass)
```

### Step 4: Run the Video Pipeline

```bash
cd video-pipeline
export CREATOMATE_API_KEY=<your-key>
export YOUTUBE_API_KEY=<your-key>
python auto-poster.py
```

## Model Routing Table

| Task Type | Routed Model | Reasoning |
| :--- | :--- | :--- |
| Planning / Architecture | Claude Opus | Deepest reasoning, 1M context window |
| Algorithms / Math / PID | DeepSeek R1 | Expert chain-of-thought, 90% cheaper |
| Code Implementation | Claude Sonnet | Strong coding, balanced cost |
| File Navigation | Claude Haiku | Fast, cost-efficient pattern matching |
| Multimodal (Image/Video) | Gemini Pro | Native audio/video integration |

## Backup Schedule

The Azure Backup policy runs daily at 2:00 AM EST with 7-day retention. Application-consistent snapshots use pre/post scripts to flush databases and pause orchestrators before the snapshot is taken.

## Security

All pre/post scripts must have permissions set to `700` (root only). The `VMSnapshotScriptPluginConfig.json` must be set to `600`. API keys must never be committed to the repository — use environment variables or Azure Key Vault.
