#!/bin/bash
# ./infra/check.sh ecs-cluster

RESOURCE_NAME=$1
ENVIRONMENT=${ENVIRONMENT:-dev}
STACK_NAME="${ENVIRONMENT}-${RESOURCE_NAME}"

echo "[INFO] Checking if CloudFormation stack '${STACK_NAME}' exists..."

STACK_STATUS=$(aws cloudformation describe-stacks \
  --stack-name "${STACK_NAME}" \
  --query "Stacks[0].StackStatus" \
  --output text 2>/dev/null)

if [[ $? -ne 0 || "$STACK_STATUS" == "DELETE_COMPLETE" ]]; then
  echo "[ERROR] Stack '${STACK_NAME}' does not exist or has been deleted."
  exit 1
fi

echo "[INFO] Stack '${STACK_NAME}' exists with status: $STACK_STATUS"
exit 0
