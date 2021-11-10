#!/bin/bash
# /////////////////////?/////////////////////?/////////////////////?/////////////////////?
echo "Step 5 :>>"
echo "===================== Starting Network ========================"
export COMPOSE_PROJECT_NAME=net
export IMAGE_TAG=latest
export SYS_CHANNEL=workspace-sys-channel
# export CHANNEL_NAME=workspace

echo "Step 6 :>>"
echo "===================== Create WORKSPACE Channel ========================"
echo "Exec into CLI docker container , in " 
docker exec -it cli bash
echo "Again setup env for channel's name to [workspace] as before"
echo "We are going to set the required variables so that we can perfom blockchian transactions as developers admin"
export CHANNEL_NAME=workspace
export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/developers.workspace/users/Admin@developers.workspace/msp
export CORE_PEER_ADDRESS=peer1.developers.workspace:7051
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/developers.workspace/peers/peer1.developers.workspace/tls/ca.crt

peer channel create     -o orderer1.workspace:7050     -c $CHANNEL_NAME     -f ./channel-artifacts/$CHANNEL_NAME.tx     --outputBlock ./$CHANNEL_NAME.block     --tls     --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem

ls 
echo ">>>>>>>> Check out for the file CHANNEL_NAME.block <<<<<<<<"


echo "Step 7 :>>"
echo "===================== Start Joing this peer to a fresh Channel created ========================"
echo "For Developers organization: "
peer channel join -b ./workspace.block
echo "print the peer channel list to see joined channel in this peer"
peer channel list
