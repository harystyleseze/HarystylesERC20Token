// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script } from "lib/forge-std/src/Script.sol";
import { HarystylesMainToken } from "../src/HarystylesMainToken.sol"; // Path to the token contract

contract DeployHarystylesMainToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether; // Amount of tokens to mint at deployment

    function run() external returns (HarystylesMainToken) {
        // Start broadcasting the deployment transaction
        vm.startBroadcast();

        // Deploy the HarystylesMainToken contract with the initial supply
        HarystylesMainToken token = new HarystylesMainToken(INITIAL_SUPPLY);

        // Stop broadcasting the transaction
        vm.stopBroadcast();

        // Return the deployed contract instance
        return token;
    }
}