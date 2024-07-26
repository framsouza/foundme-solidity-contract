// 1. Get funds from users
// 2. Withdraw funds
// 3. Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {

    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 10e18;
    address[] public funders;
    mapping(address founder => uint256 amountFounded) public addressToAmountFounded;

    address public immutable i_owner;
    constructor() {
        i_owner = msg.sender;
    }

    // Allow users to send $ and have a minimum $ sent
    function fund() public payable  {
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Not enough ETH");
        funders.push(msg.sender);
        addressToAmountFounded[msg.sender] = addressToAmountFounded[msg.sender] + msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFounded[funder] = 0;
        }
        // Reset the array 
        funders = new address[](0);

        // Transfering tokens
        payable(msg.sender).transfer(address(this).balance);
        // Sending tokens
        bool sendSucess = payable(msg.sender).send(address(this).balance);
        require(sendSucess, "Send failed");

        (bool callSucess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSucess, "Call failed");
    }

    modifier onlyOwner(){
        if(msg.sender != i_owner) {
            revert NotOwner();
        }
        _;
    }
}
