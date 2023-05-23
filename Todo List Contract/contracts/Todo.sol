// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Todo {
    struct item {
        bytes32 content;
        address owner;
        bool completed;
        uint256 timestamp;
    }

    uint public constant maximumItems = 50;

    mapping(address => item[maximumItems]) public todos;
   
   mapping(address => uint256) public lastIds;
   
}