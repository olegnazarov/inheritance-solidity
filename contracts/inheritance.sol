// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract GrandDadTreasury {

    uint256 public balance;
    uint8 public grandChildCount;
    address public owner;

    struct Grandchild {
        string grandChildName;
        uint256 birthDate;
        bool alreadyWithdraw;
        bool grandChildStatus;
    }

    address[] public grandChildsArray;

    mapping(address => Grandchild) public grandChilds;

    constructor {
        owner = msg.sender;
        grandChildCount = 0;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function addGrandChild(address wallet, string grandChildName, uint256 birthDate) public onlyOwner {
        require(birthDate > 0, "Wrong DOB");
        require(grandChilds[wallet].exist == false, "Wallet already exists");
        grandChilds[wallet] = Grandchild(grandChildName, birthDate, false, true);
        grandChildsArray.push(wallet);
        grandChildCount++;
    }

}