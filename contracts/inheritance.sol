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

}