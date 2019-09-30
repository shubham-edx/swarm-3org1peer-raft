# this script will installe the chaincode and instantiate it.

peer channel create -o orderer0.example.com:7050 -c mychannel -f ../channel-artifacts/mychannel.tx  --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b mychannel.block -o orderer0.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer chaincode install -n shrim -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/shrim

peer chaincode instantiate -o orderer0.example.com:7050 -C mychannel -n shrim -l node -v 1.0 -c '{"Args":[""]}' -P "OR ('Org1MSP.member','Org2MSP.member','Org3MSP.member')" --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
