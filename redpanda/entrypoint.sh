#!/bin/bash

sleep 2

export NODE_IP=$(cat /etc/hosts | grep "${HOSTNAME}" | awk '{print $1}')

(
  echo "cat << EndOfMessage"
  cat redpanda.yaml.tmp
  echo -e "\nEndOfMessage"
) | bash >redpanda.yaml

rpk redpanda start \
  --config redpanda.yaml --check=false --overprovisioned \
  --smp 1 --memory 1G --reserve-memory 0M \
  --default-log-level=info
