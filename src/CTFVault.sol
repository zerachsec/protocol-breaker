// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CTFVault {
    mapping(address => uint256) public balance;
    mapping(address => uint256) public rewardDebt;

    uint256 public totalDeposits;
    uint256 public accRewardPerShare;

    function deposit() external payable {
        require(msg.value > 0);

        updateRewards();

        balance[msg.sender] += msg.value;
        totalDeposits += msg.value;

        rewardDebt[msg.sender] = (balance[msg.sender] * accRewardPerShare) / 1e12;
    }

    function withdraw(uint256 amount) external {
        require(balance[msg.sender] >= amount);

        updateRewards();

        balance[msg.sender] -= amount;
        totalDeposits -= amount;

        payable(msg.sender).transfer(amount);
    }

    function claim() external {
        uint256 pending = (balance[msg.sender] * accRewardPerShare) / 1e12 - rewardDebt[msg.sender];

        require(pending > 0);

        rewardDebt[msg.sender] += pending;

        payable(msg.sender).transfer(pending);
    }

    function updateRewards() internal {
        if (totalDeposits == 0) return;

        accRewardPerShare += (address(this).balance * 1e12) / totalDeposits;
    }

    receive() external payable {}
}

/**
 * 🔍 Vulnerability Explanation
 *
 * updateRewards() uses:
 *
 * address(this).balance
 *
 * But that includes:
 * deposits
 * rewards
 * attacker transfers
 *
 * Attackers can manipulate the reward index by sending ETH directly to the contract.
 * This artificially increases rewards.
 */