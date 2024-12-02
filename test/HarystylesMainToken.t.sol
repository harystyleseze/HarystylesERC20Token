// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployHarystylesMainToken} from "../script/DeployHarystylesMainToken.s.sol";
import {HarystylesMainToken} from "../src/HarystylesMainToken.sol";

contract HarystylesMainTokenTest is Test {
    HarystylesMainToken public harystylesMainToken;
    DeployHarystylesMainToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployHarystylesMainToken();
        harystylesMainToken = deployer.run();

        vm.prank(msg.sender);
        harystylesMainToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, harystylesMainToken.balanceOf(bob));
    }

    function testAllowancesWorks()
}