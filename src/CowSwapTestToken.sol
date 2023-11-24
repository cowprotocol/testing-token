// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {AccessControl} from "lib/openzeppelin-contracts/contracts/access/AccessControl.sol";
import {ERC20Permit} from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

/// @title CoW Swap Test Token v1
/// @author CoW Swap Developers
/// @notice This is a test token contract used by the CoW Swap team to test
/// CoW Swap's features. **This token has no value.** It can be printed and
/// burnt at any time and for any reason by the team.
contract CowSwapTestToken is ERC20, AccessControl, ERC20Permit {
    bytes32 public constant MINTER_BURNER_ROLE =
        keccak256("MINTER_BURNER_ROLE");

    constructor(
        address admin,
        address balanceManager,
        string memory name,
        string memory symbol
    ) ERC20(name, symbol) ERC20Permit(name) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(MINTER_BURNER_ROLE, balanceManager);
    }

    function mint(
        address to,
        uint256 amount
    ) public onlyRole(MINTER_BURNER_ROLE) {
        _mint(to, amount);
    }

    function burn(
        address from,
        uint256 amount
    ) public onlyRole(MINTER_BURNER_ROLE) {
        _burn(from, amount);
    }
}
