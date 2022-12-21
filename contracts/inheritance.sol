// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract GrandFatherTreasury {

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

    constructor() {
        owner = msg.sender;
        grandChildCount = 0;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function addGrandChild(address wallet, string memory grandChildName, uint256 birthDate) public onlyOwner {
        require(birthDate > 0, "Wrong DOB");
        require(grandChilds[wallet].grandChildStatus == false, "Such a grandchild already exists");
        grandChilds[wallet] = Grandchild(grandChildName, birthDate, false, true);
        grandChildsArray.push(wallet);
        grandChildCount++;
    }

    function withdraw() public {
        address payable wallet = payable(msg.sender);
        require(grandChilds[wallet].grandChildStatus == true, "This is not the grandchild.");
        require(block.timestamp > grandChilds[wallet].birthDate, "The birthday is not yet here");
        require(grandChilds[wallet].alreadyWithdraw == false, "Funds already withdrawn earlier");
        uint256 amount = balance / grandChildCount;
        grandChilds[wallet].alreadyWithdraw == true;
        (bool success, ) = wallet.call{value: amount}("");
        require success;
    }

    function balanceOf() public view returns(uint256) {
        return address(this).balance;
    }

}