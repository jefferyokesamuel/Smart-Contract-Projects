// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract Todo {
        struct Item {
            bytes32 content;
            address owner;
            bool completed;
            uint256 timestamp;
        }

        uint public constant maximumItems = 50;

        mapping(address => Item[maximumItems]) public todos;
    
        mapping(address => uint256) public lastIds;

        modifier onlyOwner (address _owner) {
            require(msg.sender == _owner);
            _;
        }

        function addItem(bytes32 _content) public{
            Item memory newItem = Item(_content, msg.sender, true, block.timestamp);
            todos[msg.sender][lastIds[msg.sender]] = newItem;
            if(lastIds[msg.sender] >= maximumItems) lastIds[msg.sender] = 0;
            else lastIds[msg.sender]++;
   }
        
        function markTodoAsCompleted(uint256 _todoId) public {
            require(_todoId < maximumItems);
            require(!todos[msg.sender][_todoId].isCompleted);
            todos[msg.sender][_todoId].isCompleted = true;
   }
}