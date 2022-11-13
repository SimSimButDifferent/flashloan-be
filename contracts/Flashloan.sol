// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10; // .10 because thats the version a lot of the aave contracts that will be used are on.

import {FlashLoanSimpleReceiverBase} from "https://github.com/aave/aave-v3-core/...";
import {IPoolAddressesProvider} from "https://github.com/aave/aave-v3-core/...";
import {IERC20} from "https://github.com/aave/aave-v3-core/...";

contract FlashLoan is FlashLoanSimpleReceiverBase {
    address payable owner;

    constructor(address _addressProvider) FlashLoanSimpleReceiverBase(IPoolAddressesProvider(_addressProvider)) {
        owner = payable(msg.sender)
    }

    function executeOperation(
    address asset,
    uint256 amount,
    uint256 premium,
    address initiator,
    bytes calldata params
  ) external override returns (bool) {
    // we have the borrowed funds
    // Logic
    uint256 amountOwed = amount + premium;
    IERC20(asset).approve(address(POOL), amountOwed);

    return true;
  }

  function requestFlashLoan(address _token, uint256 _amount) {
    address recieverAddress = address(this);
    address asset = _token;
    uint256 amount = _amount;
    bytes memory params = "";
    uint16 referralCode = 0;


    POOL.flashLoanSimple(
        receiverAddress,
        asset,
        amount,
        params,
        referralCode
        );
    }


}
