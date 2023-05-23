pragma solidity 0.6.12;

contract Lottery {
    address public owner;
    address payable[] public players;

    constructor () public{
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "This can only be done by the owner");
        _;
    }

    event playerInvested(address _player, uint _amount);
    event winnerSelected(address _winner, uint _amount);

    function random() private view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,players.length)));
    }
    // Invest money by players
    function playLottery() payable public {
        require(msg.sender != owner, "Owner can't invest");
        require(msg.value >= 0.1 ether, "Need to stake higher than 0.1 ether");
        //Keep track of investors
        players.push(msg.sender);
        emit playerInvested(msg.sender, msg.value);
    }
    // get contracts current balance
    function getBalance() public view onlyOwner returns (uint){
        return address(this).balance;
    }
    // Function should select a player at random and send the total money to the player

    function selectPlayer() public onlyOwner {
        uint rand = random();
        uint i = rand % players.length;
        address payable winner = players[i];
        emit winnerSelected(winner, address(this).balance);
        (bool sent, bytes memory data) = winner.call{value: address(this).balance}("");
        require(sent, "Transaction failed");
        players = new address payable[](0);
    }

}