// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployHarystylesMainToken} from "../script/DeployHarystylesMainToken.s.sol";
import {HarystylesMainToken} from "../src/HarystylesMainToken.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract HarystylesMainTokenTest is Test {
    HarystylesMainToken public harystylesMainToken;
    DeployHarystylesMainToken public deployer;

    address bob = makeAddr("bob");
    address alice = makeAddr("alice");

    uint256 public constant STARTING_BALANCE = 100 ether;

    function setUp() public {
        deployer = new DeployHarystylesMainToken();
        harystylesMainToken = deployer.run();

        // Transfer the starting balance of 100 ether to bob
        vm.prank(msg.sender);  // Ensure the correct sender is used
        harystylesMainToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(STARTING_BALANCE, harystylesMainToken.balanceOf(bob));
    }

    function testAllowancesWork() public {
        uint256 initialAllowance = 1000;

        // Bob approves Alice to spend 1000 tokens.
        vm.prank(bob);
        harystylesMainToken.approve(alice, initialAllowance);

        uint256 transferAmount = 500;

        vm.prank(alice);
        harystylesMainToken.transferFrom(bob, alice, transferAmount);

        assertEq(harystylesMainToken.balanceOf(alice), transferAmount);
        assertEq(harystylesMainToken.balanceOf(bob), STARTING_BALANCE - transferAmount);
    }

    function testTransfer() public {
        uint256 amount = 1 * 10 ** 18; // 1 token with 18 decimals

        // Save initial balance of the sender (msg.sender) and receiver (bob).
        uint256 initialBalanceSender = harystylesMainToken.balanceOf(msg.sender);
        uint256 initialBalanceReceiver = harystylesMainToken.balanceOf(bob);

        // Ensure that the sender is the test contract itself (msg.sender)
        console.log("Initial balance of sender: ", initialBalanceSender);
        console.log("Initial balance of receiver (Bob): ", initialBalanceReceiver);

        // Perform the transfer as msg.sender (the current test account).
        vm.prank(msg.sender);  // Ensure the transaction is sent by the correct address
        harystylesMainToken.transfer(bob, amount);

        // Get the final balances
        uint256 finalBalanceSender = harystylesMainToken.balanceOf(msg.sender);
        uint256 finalBalanceReceiver = harystylesMainToken.balanceOf(bob);

        // Log the balances for debugging
        console.log("Sender final balance: ", finalBalanceSender);
        console.log("Receiver final balance: ", finalBalanceReceiver);

        // Assertions
        assertEq(finalBalanceReceiver, initialBalanceReceiver + amount, "Receiver should have received the transferred amount.");
        assertEq(finalBalanceSender, initialBalanceSender - amount, "Sender should have decreased balance by the transferred amount.");
    }

    function testFailTransferExceedsBalance() public {
        uint256 amount = deployer.INITIAL_SUPPLY() + 1;
        vm.prank(msg.sender);
        harystylesMainToken.transfer(bob, amount); // This should fail
    }

    // function testFailApproveExceedsBalance() public {
    //     uint256 amount = deployer.INITIAL_SUPPLY() + 1;
    //     vm.prank(msg.sender);
    //     harystylesMainToken.approve(bob, amount); // This should fail
    // }

    // function testTransferEvent() public {
    //     uint256 amount = 1000 * 10 ** 18; // Example amount
    //     vm.prank(msg.sender);
    //     vm.expectEmit(true, true, false, true);
    //     emit Transfer(msg.sender, bob, amount);
    //     harystylesMainToken.transfer(bob, amount);
    // }

    // function testApprovalEvent() public {
    //     uint256 amount = 1000 * 10 ** 18; // Example amount
    //     vm.prank(msg.sender);
    //     vm.expectEmit(true, true, false, true);
    //     emit Approval(msg.sender, bob, amount);
    //     harystylesMainToken.approve(bob, amount);
    // }
}
