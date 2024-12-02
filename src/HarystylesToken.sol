// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract HarystylesToken {

    mapping(address => uint256) private s_balances;

    function name() public pure returns(string memory) {
        return "Harystyles Token";
    }

    function symbol() public pure returns (string memory) {
        return "HRY";
    }

    function totalSupply() public pure returns (uint256) {
        return 100 ether; // 100000000000000000000
    }

    function decimals() public pure returns (uint8) {
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return s_balances[_owner];
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        uint256 senderBalance = s_balances[msg.sender];
        require(senderBalance >= _amount, "Insufficient balance");

        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;

        return true;
    }
}