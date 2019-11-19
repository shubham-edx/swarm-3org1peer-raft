### Create Channel

`export CHANNEL_NAME=your_channel_name`
`./bin/configtxgen -profile ChannelConfig -outputCreateChannelTx ./channel-artifacts/#CHANNEL_NAME.tx -channelID #CHANNEL_NAME`

### Deploy with 

`docker stack deploy -c docker-swarm-compose-tls.yaml fabric-overlay && docker stack deploy -c cli.yaml fabric-overlay`