# Testing token

A simple token contract that is used to test CoW Swap features.
This token is worthless. It can be minted and destroyed at any times and for any reason from team-owned accounts.

## Development

### Install

This project uses Foundry for development and testing.
Instructions on how to install this framework can be found [here](https://book.getfoundry.sh/getting-started/installation.html).

Other required NPM-based dev toolings can be installed using yarn.

```sh
yarn install
```

### Build

```sh
forge build
```

### Deploy

Run the following commands to deploy the contract in the specified network and verify it on the chain explorer.

```sh
export INFURA_API_KEY=<your Infura key here>
forge create --rpc-url goerli \
    --constructor-args <address of the contract admin> <address of an address that can freely mint and burn token> \
    --private-key <your_private_key> \
    --etherscan-api-key <your_etherscan_api_key> \
    --verify \
    src/CowSwapTestToken.sol:CowSwapTestToken
```

Valid parameters for `rpc-url` are `mainnet`, `goerli`, `gnosischain`.
All networks except latter require an Infura API key.
You can also specify your own RPC URL.

### Code formatting

```sh
yarn fmt
```

### Test

```sh
forge test
```
Add an increased number of verbosity flags for debugging. For example:
```sh
forge test -vvv
```

For seeing line coverage results, run:
```
forge coverage
```
