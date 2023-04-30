pragma solidity ^0.8.0;

contract MyContract {
    uint256 public myVar;

    function setVar(uint256 newValue) public {
        myVar = newValue;
    }
}