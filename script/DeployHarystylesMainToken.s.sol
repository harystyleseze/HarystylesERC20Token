// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import { script } from "lib/forge-std/src/Script.sol";
import { HarystylesMainToken } from "../src/HarystylesMainToken.sol";

contract DeployHarystylesMainToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function run() external {
        vm.startBroadcast();
        new HarystylesMainToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
    }

}