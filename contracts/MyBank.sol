// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";

contract MyBank {
    address public owner;
    address public bankAddress;
    mapping (address => uint) public balances;
    using Address for address payable;

    constructor() {
        owner = msg.sender;
        bankAddress = address(this);
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }


    function withdraw(uint _value) public {
        require (balances[msg.sender] > 0 && balances[msg.sender] > _value);
        
        balances[msg.sender] -= _value;
        payable(msg.sender).sendValue(_value);
    }

    function withdrawAll() public {
        require (balances[msg.sender] > 0);

        // Prevent reentrancy attack by implementing local variable
        uint currentBalance = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).sendValue(currentBalance);
    }

    function getBalance() public view returns(uint) {

        return balances[msg.sender];
    }
}