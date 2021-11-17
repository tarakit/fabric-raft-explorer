#!/bin/bash

export IMAGE_TAG=latest

echo $IMAGE_TAG
export PATH=$PATH:/home/kitta/fabric-samples/bin
# if [[ -d "./crypto-config" ]]
# then
	echo "Step 1 :>>"
	echo "===================== Generating Artifacts ========================"
	cryptogen generate --config=./crypto-config.yaml

	echo "Step 2 :>>"
	echo "===================== Generating Genesis Block ========================"
	export FABRIC_CFG_PATH=$PWD
	configtxgen -profile Raft -channelID workspace-sys-channel -outputBlock ./channel-artifacts/genesis.block

	echo "Step 3 :>>"
	echo "===================== Create Channel Transaction Artifact ========================
	Note: This step and step 4 doesn’t make any actual blockchain transaction, instead generates transaction artifacts that will aid in performing transactions in step 6 and 7."
	export CHANNEL_NAME=workspace
	# FourOrgsChannel is the Channel name declared in config.yaml > Profile section
	configtxgen -profile FourOrgsChannel -outputCreateChannelTx ./channel-artifacts/workspace.tx -channelID $CHANNEL_NAME

	echo "Step 4 :>>"
	echo "===================== Create Anchor Peers Artifacts ========================"
	echo "For developer organization"

	configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP

	echo "For accounts organization"

	configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP

	echo "For hr organization"

	configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org3MSP

	echo "For marketing organization"

	configtxgen -profile FourOrgsChannel -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org4MSP

	echo " <<<<<<<<<<<<< END CREATING ANCHOR PEER FOR EACH ORGANIZATIONs >>>>>>>>>>>>>>>" 

# fi

/////////////////////?/////////////////////?/////////////////////?/////////////////////?
echo "Step 5 :>>"
echo "===================== Starting Network ========================"
export COMPOSE_PROJECT_NAME=net
export IMAGE_TAG=latest
export SYS_CHANNEL=workspace-sys-channel

docker-compose -f docker-compose.yaml up -d
echo "Done ||||||||| Please check ./scripts for peer channel install"

# echo "Step 6 :>>"
# echo "===================== Create WORKSPACE Channel ========================"
# echo "Exec into CLI docker container , in " 
# docker exec -it cli bash
# echo "Again setup env for channel's name to [workspace] as before"
# echo "We are going to set the required variables so that we can perfom blockchian transactions as developers admin"
# export CHANNEL_NAME=workspace2
# export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/developers.workspace/users/Admin@developers.workspace/msp
# export CORE_PEER_ADDRESS=peer1.developers.workspace:7051
# export CORE_PEER_LOCALMSPID="Org1MSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/developers.workspace/peers/peer1.developers.workspace/tls/ca.crt

# peer channel create     -o orderer1.workspace:7050     -c $CHANNEL_NAME     -f ./channel-artifacts/$CHANNEL_NAME.tx     --outputBlock ./$CHANNEL_NAME.block     --tls     --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem

# ls 
# echo ">>>>>>>> Check out for the file CHANNEL_NAME.block <<<<<<<<"


# echo "Step 7 :>>"
# echo "===================== Start Joing this peer to a fresh Channel created ========================"
# echo "For Developers organization: "
# peer channel join -b ./workspace.block
# echo "print the peer channel list to see joined channel in this peer"
# peer channel list

# echo "For Accounts organization: "
# export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/accounts.workspace/users/Admin@accounts.workspace/msp
# export CORE_PEER_ADDRESS=peer1.accounts.workspace:9051
# export CORE_PEER_LOCALMSPID="Org2MSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/accounts.workspace/peers/peer1.accounts.workspace/tls/ca.crt

# peer channel join -b ./workspace.block

# peer channel update \
# 	-o orderer1.workspace:7050 \
# 	-c $CHANNEL_NAME \
# 	-f ./channel-artifacts/Org2MSPanchors.tx \
# 	--tls \
# 	--cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem

# echo "For HR organization: "
# export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hr.workspace/users/Admin@hr.workspace/msp
# export CORE_PEER_ADDRESS=peer1.hr.workspace:11051
# export CORE_PEER_LOCALMSPID="Org3MSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hr.workspace/peers/peer1.hr.workspace/tls/ca.crt

# peer channel join -b ./workspace.block

# peer channel update \
# 	-o orderer1.workspace:7050 \
# 	-c $CHANNEL_NAME \
# 	-f ./channel-artifacts/Org3MSPanchors.tx \
# 	--tls \
# 	--cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem


# echo "For Marketings organization: "
# export CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/marketing.workspace/users/Admin@marketing.workspace/msp
# export CORE_PEER_ADDRESS=peer1.marketing.workspace:13051
# export CORE_PEER_LOCALMSPID="Org4MSP"
# export CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/marketing.workspace/peers/peer1.marketing.workspace/tls/ca.crt

# peer channel join -b ./workspace.block

# peer channel update \
# 	-o orderer1.workspace:7050 \
# 	-c $CHANNEL_NAME \
# 	-f ./channel-artifacts/Org4MSPanchors.tx \
# 	--tls \
# 	--cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/workspace/orderers/orderer1.workspace/msp/tlscacerts/tlsca.workspace-cert.pem