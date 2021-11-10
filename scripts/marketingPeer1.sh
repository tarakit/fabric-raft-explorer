echo "For Marketings organization: "
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/marketing.workspace/users/Admin@marketing.workspace/msp
export CORE_PEER_ADDRESS=peer1.marketing.workspace:13051
export CORE_PEER_LOCALMSPID="Org4MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/marketing.workspace/peers/peer1.marketing.workspace/tls/ca.crt

peer channel join -b ./workspace.block

peer channel update \
	-o orderer1.workspace:7050 \
	-c $CHANNEL_NAME \
	-f ./channel-artifacts/Org4MSPanchors.tx \
	--tls \
	--cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem