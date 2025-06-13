#!/bin/bash
set -e
source "$(dirname "$0")/../config.sh"

aws iam get-role --role-name "${ENVIRONMENT}-exec-role" >/dev/null &&
aws iam get-role --role-name "${ENVIRONMENT}-task-role" >/dev/null
