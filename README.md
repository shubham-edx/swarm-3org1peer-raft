# Caliper Swarm Sample 3Org1Peer (Multi-Host Caliper)

## About the network

This directory contains a sample __Fabric v1.4.1__ network with the following properties.

## Topology
* The network has 3 participating organizations.
* The network has 3 orderer nodes in Raft mode.
* Each organization has 1 peer in the network.
* The peers use __GoLevelDB__ as the world-state database.
* A channel named `mychannel` is created and the peers are joined.
* A sample chaincode is installed and instantiated. See the [configuration section](#platform-configurations) for details.

## Communication protocol
* The `docker-swarm-compose-tls.yaml` file specifies a network __with TLS__ communication.

The configuration files names (with or without the `-tls` part) indicate which network type it relies on. They are not distinguished further in the next sections.

## Platform configurations

The following network configuration files are available for the different platforms, containing the listed chaincodes that will be deployed (installed and instantiated).

### Fabric
* `fabric-go(-tls).json` (__golang__ implementations) 
  * `marbles` __with__ CouchDB index metadata and rich query support.
  * `drm`
  * `simple`
  * `smallbank`
  
# Running the Benchmark
We use Docker Swarm to manage the containers.
## 1- Create a Swarm

First create a Docker Swarm on the host in which you will run the benchmark from (Replace the IP with your's):
Depending on your Host machine you might be able to use different ips. For example if all of your hosts are on the same network (e.g, a Cloud provider) you can also use the internal IP of your host.
```sh
$ docker swarm init --listen-addr HOST1-REACHABLE-PUBLIC-IP:2377
```
You should see this as the output:
```sh
# To add a worker to this swarm, run the following command:
#    docker swarm join --token xxxxxxxxxxxxx IP:2377
```
Now your Host1 has joined the swarm as a manager. 
## 2- Join other hosts to the swarm

Copy the given command (`docker swarm join --token xxxxxxxxxxxxx IP:2377`) and run it on the other hosts:

```sh
# This node joined a swarm as a worker.
```
Repeat the same process for as many nodes as you want to run your Caliper benchmark on.

** Important: All the hosts should have the caliper repo in the same directory as the HOST1. This is how the system gets access to the crypto material.
For example:

```sh
#home/HOST1/caliper/packages/caliper-samples/network/fabric-v1.4.1/swarm-3org1peer-raft/
#home/HOST2/caliper/packages/caliper-samples/network/fabric-v1.4.1/swarm-3org1peer-raft/
#home/HOST3/caliper/packages/caliper-samples/network/fabric-v1.4.1/swarm-3org1peer-raft/
```

## 3- Check the Swarm Status
On HOST1 which is the swarm manager run the following command and this will give you a list of the hosts in the Swarm:
```sh
$ docker node ls
```
You should get this as the output:
```sh
ID        HOSTNAME         STATUS   AVAILABILITY     MANAGER STATUS    ENGINE VERSION
xxx *   caliper-latest      Ready     Active             Leader           18.09.8
xxx     caliper-latest2     Ready     Active                              18.09.8
```

You will use the `HOSTNAME` to assign the containers (`Peers`, `Orderers`, `CAs`) to certain Hosts.

## 4- Assign Containers to Hosts

Open `docker-swarm-compose-tls.yaml` in an editor. In this file, the containers (`Peers`, `Orderers`, `CAs`) are each defined as a Service under `Services:`. At the bottom of the service definition you can find the container deployment details:
```yaml
 deploy:
    placement:
        constraints: [node.hostname ==  YOUR-HOSTNAME]
```

Replace the `YOUR-HOSTNAME` with the desired host in all of the services (e.g., assigning all of the containers from one Org to a different host).

### 4-1- Alternative Container Placement 
Alternatively you could use the following identifiers to control your container placement:

| Name|	matches	| example|
| ------ | ------ | ------ |
| node.id |	Node ID| `node.hostname ==  w1rxedpb1`|
| node.hostname| Node hostname|	`node.hostname ==  YOUR-HOSTNAME`|
| node.role| Node role | `node.role == manager` |


## 5- Runing the Benchmark

You can now run the benchmark with the following command in the HOST1 under caliper directory:

```sh
$ caliper benchmark run -w ./packages/caliper-samples -c benchmark/simple/config.yaml -n network/fabric-v1.4.1/swarm-3org1peer-raft/fabric-ccp-go-tls.yaml
