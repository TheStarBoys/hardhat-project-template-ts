// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

contract Greeter {
    string private greeting;
    
    uint256 public val1;
    uint256 public val2;
    uint256 public val3;

    constructor(string memory greeting_) {
        greeting = greeting_;
    }

    function greet() public view returns (string memory) {
        return greeting;
    }

    function setGreeting(string memory newGreeting) public {
        greeting = newGreeting;
    }

    function addToA(uint256 amount) external {
        val1 += amount;
        val3 += amount;
    }

    function addToB(uint256 amount) external {
        val2 += amount;
        val3 += amount;
    }
}
