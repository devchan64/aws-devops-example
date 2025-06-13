#!/bin/bash
set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
source "$SCRIPT_DIR/../config.sh"

ALB_NAME="${ENVIRONMENT}-alb"

echo "[TEST] Retrieving DNS name for ALB: $ALB_NAME"

# ALB DNS 이름 가져오기
ALB_DNS=$(aws elbv2 describe-load-balancers \
  --names "$ALB_NAME" \
  --query "LoadBalancers[0].DNSName" \
  --output text \
  --region "$AWS_REGION" \
  $AWS_CLI_OPTS 2>/dev/null || true)

if [[ -z "$ALB_DNS" || "$ALB_DNS" == "None" ]]; then
  echo "[ERROR] Failed to retrieve DNS name for ALB ($ALB_NAME)"
  exit 1
fi
