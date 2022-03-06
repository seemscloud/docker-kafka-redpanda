#!/bin/bash

# NODE_ID=`shuf -i 1-100000 -n 1`
MY_IP=`cat /etc/hosts  | grep "${HOSTNAME}" | awk '{print $1}'`

if [[ "${NODE_TYPE}" = "root" ]]; then
  rpk config bootstrap --id "${NODE_ID}" --self "${MY_IP}"
  rpk redpanda start
elif [[ "${NODE_TYPE}" = "node" ]]; then
  ROOT_IP=`dig +short "${ROOT_NODE}"`
  rpk config bootstrap --id "${NODE_ID}" --self "${MY_IP}" --ips "${ROOT_IP}"
  rpk redpanda start
fi
