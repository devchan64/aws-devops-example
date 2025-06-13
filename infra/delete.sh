#!/bin/bash
set -e

if [ $# -ne 1 ]; then
  echo "Usage: $0 <component>"
  exit 1
fi

COMPONENT="$1"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/config.sh"

STACK_NAME="${ENVIRONMENT}-${COMPONENT}"

echo "[DELETE] Stack: $STACK_NAME"
aws cloudformation delete-stack \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION" \
  $AWS_CLI_OPTS

echo "[WAIT] Waiting for stack deletion: $STACK_NAME"
aws cloudformation wait stack-delete-complete \
  --stack-name "$STACK_NAME" \
  --region "$AWS_REGION" \
  $AWS_CLI_OPTS

echo "[DELETE] Completed: $STACK_NAME"
