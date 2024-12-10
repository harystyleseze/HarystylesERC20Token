// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract HarystylesMainToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("HarystylesMainToken", "HSMT") {
        _mint(msg.sender, initialSupply); // Mint tokens to the deployer's address
    }
}