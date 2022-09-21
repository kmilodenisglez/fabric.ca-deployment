#!/usr/bin/env sh

if ! command -v fabric-ca-server version &> /dev/null
then
    # look for binaries in local /bin directory
    export PATH="${PWD}"/bin:"$PATH"
fi

export FABRIC_CA_HOME="${PWD}"/org1
export FABRIC_CA_SERVER_CA_NAME=ca-org1
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_OPERATIONS_LISTENADDRESS=0.0.0.0:17054
export FABRIC_CA_SERVER_CSR_CN=ca.org1.example.com
export FABRIC_CA_SERVER_CSR_HOSTS=localhost,127.0.0.1,0.0.0.0,*.example.com
export FABRIC_CA_SERVER_DEBUG=true

fabric-ca-server start -d -b admin:adminpw --port 7054