# Udacity Blockchain Capstone

The capstone built upon the knowledge I gained in the course in order to build a decentralized housing product. 

# Real Estate Marketplace

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Node.js runtime environment is required.

### Installing

Install all required dependencies

```
$ npm install
```

Install truffle

```
$ npm install -g truffle
```

### Steps to run a local ethereum network, and deploy your token contract to this local network

1) Open a Terminal window, and make sure you are inside your project directory

2) Run the command `truffle develop` (to run a local ethereum network)

3) Use the command `compile` (to compile your solidity contract files)

4) Use the command `migrate --reset --network development` (to deploy your contract to the locally running ethereum network)

5) Use the command `test` (to unit tests the contract)

## Zocrates integrateion

__Zokrates__ is invoked in docker with the following command. Steps below have already been done, they are here just for documentation purpose.

Replace the ```<absolute path>``` with your path to the project.

```
../../../../zokrates compile -i square.code
```

```
../../../../zokrates setup
```

```
../../../../zokrates compute-witness -a 12 144
```

```
../../../../zokrates generate-proof
```

```
../../../../zokrates export-verifier
```

## Rinkeby network

__Verifier__ contract address

```
0x2157e095474d2e0DA2B0E69308b08404AEE10e73
```

__SolnSquareVerifier__ contract address

```
0x2B6F57921932C6Ecdea08f72998DfC05cDe3a0B0
```

## OpenSea assets

[https://testnets.opensea.io/collection/decentralizedrealestate](https://testnets.opensea.io/collection/decentralizedrealestate)

# Project Resources

* [Remix - Solidity IDE](https://remix.ethereum.org/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Truffle Framework](https://truffleframework.com/)
* [Ganache - One Click Blockchain](https://truffleframework.com/ganache)
* [Open Zeppelin ](https://openzeppelin.org/)
* [Interactive zero knowledge 3-colorability demonstration](http://web.mit.edu/~ezyang/Public/graph/svg.html)
* [Docker](https://docs.docker.com/install/)
* [ZoKrates](https://github.com/Zokrates/ZoKrates
