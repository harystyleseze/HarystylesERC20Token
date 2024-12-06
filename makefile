-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

install :; forge install Cyfrin/foundry-devops@0.0.11 --no-commit --no-commit && forge install foundry-rs/forge-std@v1.5.3 --no-commit && forge install openzeppelin/openzeppelin-contracts@v4.8.3 --no-commit

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test

snapshot :; forge snapshot

format :; forge fmt

# Start Anvil with --no-eip1559 flag to avoid EIP-1559 fees
anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1 --port 8546 --gas-price 20000000000 --disable-min-priority-fee --block-base-fee-per-gas 0

# NETWORK_ARGS := --rpc-url http://localhost:8545 --private-key $(DEFAULT_ANVIL_KEY) --broadcast --gas-price 20000000000
NETWORK_ARGS := --rpc-url http://localhost:8546 --private-key $(DEFAULT_ANVIL_KEY) --broadcast

ifeq ($(findstring --network holesky,$(ARGS)),--network holesky)
	NETWORK_ARGS := --rpc-url $(HOLESKY_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast
endif

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
	NETWORK_ARGS := --rpc-url $(SEPOLIA_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY) -vvvv
endif

ifeq ($(findstring --network ephemery,$(ARGS)),--network ephemery)
	NETWORK_ARGS := --rpc-url $(EPHEMERY_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast
endif

# Deployment command
deploy:
	@forge script script/DeployHarystylesMainToken.s.sol:DeployHarystylesMainToken $(NETWORK_ARGS) --gas-price 20000000000 --block-base-fee-per-gas 0 -- --no-eip1559
