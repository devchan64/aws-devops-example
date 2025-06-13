#!/bin/bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../config.sh"

STACK_NAME="${ENVIRONMENT}-apigw"

echo "[TEST] Retrieving API Gateway URL from CloudFormation stack: $STACK_NAME"

# API Gateway URL 가져오기
API_URL=$(aws cloudformation describe-stacks \
  --stack-name "$STACK_NAME" \
  --query "Stacks[0].Outputs[?OutputKey=='ApiUrl'].OutputValue" \
  --output text \
  --region "$AWS_REGION" \
  $AWS_CLI_OPTS)

if [[ -z "$API_URL" || "$API_URL" == "None" ]]; then
  echo "Error: API Gateway URL을 가져올 수 없습니다."
  exit 1
fi

echo "[TEST] Sending HTTP request to API Gateway: $API_URL"
