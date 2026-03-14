// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RewardVault {
    mapping(address => uint256) public collateral;
    mapping(address => uint256) public debt;

    uint256 public collateralFactor = 75;

    function deposit() external payable {
        collateral[msg.sender] += msg.value;
    }

    function borrow(uint256 amount) external {
        uint256 maxBorrow = (collateral[msg.sender] * collateralFactor) / 100;

        require(amount <= maxBorrow);

        debt[msg.sender] += amount;

        payable(msg.sender).transfer(amount);
    }

    function withdraw(uint256 amount) external {
        require(collateral[msg.sender] >= amount);

        collateral[msg.sender] -= amount;

        payable(msg.sender).transfer(amount);
    }

    receive() external payable {}
}

/**
 * 🔍 Vulnerability Explanation
 * The protocol does not enforce collateralization after borrowing.
 * Attackers can:
 * deposit → borrow → withdraw
 * The withdrawal does not check the debt position.
 * Result:
 * Protocol becomes undercollateralized.
 */