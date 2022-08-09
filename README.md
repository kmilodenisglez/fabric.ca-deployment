# fabric.ca-deployment
Fabric CA Deployment Guide - following the steps described in [CA Deployment steps](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/cadeploy.html#what-order-should-i-deploy-the-cas)

### Download the binaries

We use only the fabric-ca-client binary can be downloaded from [ca-binary](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/cadeploy.html#download-the-binaries)

### Fabric CA server docker image 
In this topic, we use the Fabric CA image to deploy an organization CA that issues identity certificates.

### Fabric CA client binary file
Before execute instructions, we will copy the Fabric CA client binary to `fabric-ca-client-org1/bin` directory.

## Steps
### Start the fabric-ca server
start the server in debug mode
```bash
cd ./fabric-ca-server-org1
docker-compose up
```

### Registering and enrolling identities with a CA
In another terminal
```bash
cd ./fabric-ca-client-org1
. registerEnroll.sh
createOrg1
```

## Documentation <a name="doc"></a>

- [CA Deployment steps](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/cadeploy.html#what-order-should-i-deploy-the-cas)
- [use CA](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/use_CA.html)
- [Fabric Certification Authority](https://hackmd.io/@blockchainNCKU/By9yFQQku)
- [CLI - fabric-ca-client](https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/clientcli.html#fabric-ca-client-s-cli)