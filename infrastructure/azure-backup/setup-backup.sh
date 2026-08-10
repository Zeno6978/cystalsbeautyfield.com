#!/bin/bash
# Azure Backup Setup Script
# Crystal Clear Communication LLC copyright 2026 Bobby Shepherd

RESOURCE_GROUP="ai-symphony-rg"
VAULT_NAME="symphony-backup-vault"
POLICY_NAME="Daily-AppConsistent-Policy"

echo "Setting up Azure Backup for AI Symphony VMs..."

# 1. Create Recovery Services Vault
az backup vault create --resource-group $RESOURCE_GROUP --name $VAULT_NAME --location eastus

# 2. Create Backup Policy (Daily at 2 AM, retain for 7 days)
az backup policy create --resource-group $RESOURCE_GROUP --vault-name $VAULT_NAME \
  --name $POLICY_NAME --backup-management-type AzureIaasVM \
  --policy "{\"properties\":{\"backupManagementType\":\"AzureIaasVM\",\"schedulePolicy\":{\"schedulePolicyType\":\"SimpleSchedulePolicy\",\"scheduleRunFrequency\":\"Daily\",\"scheduleRunTimes\":[\"2026-07-11T02:00:00Z\"]},\"retentionPolicy\":{\"retentionPolicyType\":\"LongTermRetentionPolicy\",\"dailySchedule\":{\"retentionTimes\":[\"2026-07-11T02:00:00Z\"],\"retentionDuration\":{\"count\":7,\"durationType\":\"Days\"}}}}}"

# 3. Enable Backup for Orchestrator VM
az backup protection enable-for-vm --resource-group $RESOURCE_GROUP \
  --vault-name $VAULT_NAME --vm orchestrator-vm --policy-name $POLICY_NAME

# 4. Enable Backup for Builder VM
az backup protection enable-for-vm --resource-group $RESOURCE_GROUP \
  --vault-name $VAULT_NAME --vm builder-vm --policy-name $POLICY_NAME

echo "Azure Backup configured successfully."
