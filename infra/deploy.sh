#!/bin/bash
set -e

if [ $# -lt 2 ]; then
  echo "Usage: $0 <component> <template_file.yaml> []"
  exit 1
fi

COMPONENT="$1"
TEMPLATE_FILE="$2"

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/config.sh"

STACK_NAME="${ENVIRONMENT}-${COMPONENT}"

echo "[DEPLOY] Stack: $STACK_NAME"
aws cloudformation deploy \
  --stack-name "$STACK_NAME" \
  --template-file "$TEMPLATE_FILE" \
  --region "$AWS_REGION" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides Environment="${ENVIRONMENT}" \
  $AWS_CLI_OPTS

echo "[DEPLOY] Completed: $STACK_NAME"
