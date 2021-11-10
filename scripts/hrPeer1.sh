
echo "For HR organization: "
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hr.workspace/users/Admin@hr.workspace/msp
export CORE_PEER_ADDRESS=peer1.hr.workspace:11051
export CORE_PEER_LOCALMSPID="Org3MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hr.workspace/peers/peer1.hr.workspace/tls/ca.crt

peer channel join -b ./workspace.block

peer channel update \
	-o orderer1.workspace:7050 \
	-c $CHANNEL_NAME \
	-f ./channel-artifacts/Org3MSPanchors.tx \
	--tls \
	--cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem
