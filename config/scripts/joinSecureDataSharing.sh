#To be tun by the peers who have not installed chaincode or joined channel


peer chaincode install -n secure-data-share -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/secure-data-share

peer channel fetch 0 secure-data-share.block -o orderer0.example.com:7050 -c secure-data-share --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b secure-data-share.block -o orderer0.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem    