pragma solidity ^0.5.10;

contract OwnerPauseStopExample {
    
    address payable public owner;
    bool public isPaused = false;
    uint256 public balance;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function setPaused(bool paused) public {
        require(msg.sender == owner, "Only the owner can change paused contract status!");
        isPaused = paused;
    }
    
    function sendMoney() public payable {
        balance += msg.value;
    }
    
    function withdrawAllFunds(address payable toAddress) public {
        require(toAddress == owner, "Only the owner can withdraw the funds!");
        require(!isPaused, "Contract must not be paused!");
        
        balance = 0;
        toAddress.send(address(this).balance);
    }
    
    function destroyContract() public {
        require(msg.sender == owner, "Only the owner can destroy the contract!");
        
        selfdestruct(address(owner));
    }
    
}