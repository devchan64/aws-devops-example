#!/bin/bash
CLUSTER_NAME="${ENVIRONMENT}-ecs-cluster"
CLUSTER_STATUS=$(aws ecs describe-clusters --clusters "$CLUSTER_NAME" --query "clusters[0].status" --output text 2>/dev/null)

if [[ "$CLUSTER_STATUS" == "ACTIVE" ]]; then
  echo "ECS Cluster is active: $CLUSTER_NAME"
  exit 0
else
  echo "ECS Cluster not found or inactive: $CLUSTER_NAME"
  exit 1
fi
