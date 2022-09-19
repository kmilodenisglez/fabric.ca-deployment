# fabric.ca-deployment
Fabric CA Deployment Guide - following the steps described in [CA Deployment steps](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/cadeploy.html#what-order-should-i-deploy-the-cas)

> **NOTE**: In this project you can bring up the fabric-ca-server using docker or using the binary

## Table of Contents

- [Download the CA-Fabric binaries](#fabric_binaries)
- [Preparing environment](#preparing_env)
    * [Fabric CA client binary file](#server_docker_file)
    * [Fabric CA server binary file](#server_binary_file)
- [Bring up the fabric-ca-server (docker or binary)](#bringup_caserver)
  * [Fabric CA server with docker](#server_docker)
  * [Fabric CA server with binary](#server_binary)
- [Registering and enrolling identities with a CA](#registering_enrolling)
- [Documentation](#doc)

## Download the binaries <a name="fabric_binaries"></a>
The ca binaries can be downloaded from [ca-binary](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/cadeploy.html#download-the-binaries)

## Preparing environment <a name="preparing_env"></a>

### Fabric CA client binary file <a name="server_docker_file"></a>
Copy the __fabric-ca-client__ binary to __fabric-ca-client-org1/bin__ folder.

### Fabric CA server binary file <a name="server_binary_file"></a>
Copy the __fabric-ca-server__ binary to __fabric-ca-server-org1/bin__ folder.

## Bring up the fabric-ca-server (docker or binary)  <a name="bringup_caserver"></a>

### Fabric CA server with docker <a name="server_docker"></a>
In this section, Fabric-CA docker image is used to deploy an organization CA that issues identity certificates.

#### Start the fabric-ca server
start the server in debug mode

```bash
cd ./fabric-ca-server-org1
docker-compose up
```

### Fabric CA server with binary <a name="server_binary"></a>
In this section, Fabric-CA image is used to deploy an organization CA that issues identity certificates.

```bash
cd ./fabric-ca-server-org1
```

```bash
./fabric-server-binary.sh
```

## Registering and enrolling identities with a CA <a name="registering_enrolling"></a>
In another terminal
```bash
cd ./fabric-ca-client-org1
```

```bash
. registerEnroll.sh
createOrg1
```

> **NOTE**: The `createOrg1` function register and enroll a peer0, user1, org1admin in fabric-ca-client-org1/ca-folder/org1 folder.
## Documentation <a name="doc"></a>

- [CA Deployment steps](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/cadeploy.html#what-order-should-i-deploy-the-cas)
- [use CA](https://hyperledger-fabric-ca.readthedocs.io/en/latest/deployguide/use_CA.html)
- [Fabric Certification Authority](https://hackmd.io/@blockchainNCKU/By9yFQQku)
- [CLI - fabric-ca-client](https://hyperledger-fabric-ca.readthedocs.io/en/release-1.4/clientcli.html#fabric-ca-client-s-cli)