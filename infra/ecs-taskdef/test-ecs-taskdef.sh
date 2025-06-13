#!/bin/bash

set -e

ENVIRONMENT=${ENVIRONMENT:-dev}
FAMILY_NAME="${ENVIRONMENT}-ecs-taskdef-hello"

echo "[INFO] Verifying ECS Task Definition: $FAMILY_NAME"

# Describe the latest task definition revision
output=$(aws ecs describe-task-definition --task-definition "$FAMILY_NAME" 2>&1)

if echo "$output" | grep -q "taskDefinitionArn"; then
  echo "[SUCCESS] Task Definition '$FAMILY_NAME' exists and is valid."
  exit 0
else
  echo "[ERROR] Failed to validate Task Definition '$FAMILY_NAME'."
  echo "$output"
  exit 1
fi
