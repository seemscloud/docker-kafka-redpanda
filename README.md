```bash
sysctl -w fs.aio-max-nr=1048576

`IFS=',' ; for i in ${NODES} ; do echo -e "    - host:\n        address: $(dig +short $i)\n        port: ${RPC_PORT}" ; done`
```