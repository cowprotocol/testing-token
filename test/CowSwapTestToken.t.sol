// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {CowSwapTestToken} from "../src/CowSwapTestToken.sol";

contract CowSwapTestTokenTest is Test {
    CowSwapTestToken public token;
    address internal admin = address(0x42);
    address internal minterBurner = address(0x21);
    string internal name = "Token name";
    string internal symbol = "SYM";

    function setUp() public {
        token = new CowSwapTestToken(admin, minterBurner, name, symbol);
    }

    function testSetRole() public {
        bytes32 minterBurnerRole = token.MINTER_BURNER_ROLE();
        address newMinterBurner = address(1337);
        assertFalse(token.hasRole(minterBurnerRole, newMinterBurner));

        vm.expectRevert();
        token.grantRole(minterBurnerRole, newMinterBurner);

        vm.prank(admin);
        token.grantRole(minterBurnerRole, newMinterBurner);

        assertTrue(token.hasRole(minterBurnerRole, newMinterBurner));
    }

    function testMint() public {
        address user = address(1337);
        uint256 amount = 4242;

        assertEq(token.balanceOf(user), 0);
        vm.expectRevert();
        token.mint(user, amount);

        vm.prank(minterBurner);
        token.mint(user, amount);
        assertEq(token.balanceOf(user), amount);
    }

    function testBurn() public {
        address user = address(31337);
        uint256 initialBalance = 4242;
        uint256 balanceBurnt = 1337;
        vm.prank(minterBurner);
        token.mint(user, initialBalance);

        vm.expectRevert();
        token.burn(user, balanceBurnt);

        vm.prank(minterBurner);
        token.burn(user, balanceBurnt);
        assertEq(token.balanceOf(user), initialBalance - balanceBurnt);
    }

    function testName() public {
        assertEq(token.name(), name);
    }

    function testSymbol() public {
        assertEq(token.symbol(), symbol);
    }
}
