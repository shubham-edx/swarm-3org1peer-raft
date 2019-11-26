#To be tun by the peers who have not installed chaincode or joined channel


peer chaincode install -n text-save -v 1.0 -l node -p /opt/gopath/src/github.com/chaincode/text-save

peer channel fetch 0 text-save.block -o orderer0.example.com:7050 -c text-save --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

peer channel join -b text-save.block -o orderer0.example.com:7050 --tls --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer0.example.com/msp/tlscacerts/tlsca.example.com-cert.pem