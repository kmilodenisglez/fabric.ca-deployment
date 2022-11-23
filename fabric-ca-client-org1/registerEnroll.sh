#!/usr/bin/env sh

function createOrg1() {
  export PATH="${PWD}"/bin:"$PATH"
  echo "Copy ca-cert root certificate"
  cp ../fabric-ca-server-org1/org1/ca-cert.pem ${PWD}/root-cert

  echo "Enrolling the CA admin"
  mkdir -p ca-folder/org1

  export FABRIC_CA_CLIENT_HOME=${PWD}/ca-folder/org1/

  set -x
  fabric-ca-client enroll -u https://admin:adminpw@localhost:7054 --caname ca-org1 --tls.certfiles "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

    echo 'NodeOUs:
    Enable: true
    ClientOUIdentifier:
      Certificate: cacerts/localhost-7054-ca-org1.pem
      OrganizationalUnitIdentifier: client
    PeerOUIdentifier:
      Certificate: cacerts/localhost-7054-ca-org1.pem
      OrganizationalUnitIdentifier: peer
    AdminOUIdentifier:
      Certificate: cacerts/localhost-7054-ca-org1.pem
      OrganizationalUnitIdentifier: admin
    OrdererOUIdentifier:
      Certificate: cacerts/localhost-7054-ca-org1.pem
      OrganizationalUnitIdentifier: orderer' > "${PWD}/ca-folder/org1/msp/config.yaml"

  # Since the CA serves as both the organization CA and TLS CA, copy the org's root cert that was generated by CA startup into the org level ca and tlsca directories

  # Copy org1's CA cert to org1's /msp/tlscacerts directory (for use in the channel MSP definition)
  mkdir -p "${PWD}/ca-folder/org1/msp/tlscacerts"
  cp "${PWD}/root-cert/ca-cert.pem"  "${PWD}/ca-folder/org1/msp/tlscacerts/ca.crt"

  # Copy org1's CA cert to org1's /tlsca directory (for use by clients)
  mkdir -p "${PWD}/ca-folder/org1/tlsca"
  cp "${PWD}/root-cert/ca-cert.pem" "${PWD}/ca-folder/org1/tlsca/tlsca.org1.example.com-cert.pem"

  # Copy org1's CA cert to org1's /ca directory (for use by clients)
  mkdir -p "${PWD}/ca-folder/org1/ca"
  cp "${PWD}/root-cert/ca-cert.pem" "${PWD}/ca-folder/org1/ca/ca.org1.example.com-cert.pem"

  echo "Registering peer0"
  set -x
  fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Registering user"
  set -x
  fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/root-cert/ca-cert.pem"   --id.affiliation org1.department1 --id.attrs '"abac.manufacturer=true"' --id.attrs '"abac.administrator=true"'
  { set +x; } 2>/dev/null

  echo "Registering the org admin"
  set -x
  fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles  "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

  echo "Generating the peer0 msp"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 --mspdir "${PWD}/ca-folder/org1/peers/peer0/msp" --csr.hosts peer0.org1.example.com,127.0.0.1,localhost --tls.certfiles "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/ca-folder/org1/msp/config.yaml"  "${PWD}/ca-folder/org1/peers/peer0/msp/config.yaml"

  echo "Generating the peer0-tls certificates"
  set -x
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:7054 --caname ca-org1 -M "${PWD}/ca-folder/org1/peers/peer0/tls" --enrollment.profile tls --csr.hosts peer0.org1.example.com,127.0.0.1,localhost --tls.certfiles "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

  # Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
  cp "${PWD}/ca-folder/org1/peers/peer0/tls/tlscacerts/"* "${PWD}/ca-folder/org1/peers/peer0/tls/ca.crt"
  cp "${PWD}/ca-folder/org1/peers/peer0/tls/signcerts/"* "${PWD}/ca-folder/org1/peers/peer0/tls/server.crt"
  cp "${PWD}/ca-folder/org1/peers/peer0/tls/keystore/"* "${PWD}/ca-folder/org1/peers/peer0/tls/server.key"

  echo "Generating the user msp"
  set -x
  fabric-ca-client enroll -u https://user1:user1pw@localhost:7054 --caname ca-org1 -M "${PWD}/ca-folder/org1/users/user1/msp" --tls.certfiles "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/ca-folder/org1/msp/config.yaml"  "${PWD}/ca-folder/org1/users/user1/msp/config.yaml"

  echo "Generating the org admin msp"
  set -x
  fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:7054 --caname ca-org1 -M "${PWD}/ca-folder/org1/users/admin/msp" --tls.certfiles "${PWD}/root-cert/ca-cert.pem"
  { set +x; } 2>/dev/null

  cp "${PWD}/ca-folder/org1/msp/config.yaml"  "${PWD}/ca-folder/org1/users/admin/msp/config.yaml"
}