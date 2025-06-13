#!/bin/bash
set -e
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../config.sh"

echo "[TEST] Subnet Stack 상태 확인"
STATUS=$(aws cloudformation describe-stacks \
  --stack-name "${ENVIRONMENT}-subnet" \
  --region "$AWS_REGION" \
  $AWS_CLI_OPTS \
  --query "Stacks[0].StackStatus" --output text)

if [[ "$STATUS" != "CREATE_COMPLETE" && "$STATUS" != "UPDATE_COMPLETE" ]]; then
  echo "[ERROR] Subnet Stack 상태 이상: $STATUS"
  exit 1
fi

echo "[PASS] Subnet Stack 상태: $STATUS"
