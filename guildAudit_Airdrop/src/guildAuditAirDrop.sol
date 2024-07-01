// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Airdrop {
    address public owner;
    mapping(address => uint256) public claimed;

    event Airdropped(address indexed recipient, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    function claim(uint256 amount, uint8 v, bytes32 r, bytes32 s) public {
        bytes32 message = prefixed(keccak256(abi.encodePacked(msg.sender, amount)));
        require(recoverSigner(message, v, r, s) == owner, "Invalid signature");

        // Signature replay bug: No check to prevent reusing the same signature
        claimed[msg.sender] += amount;
        emit Airdropped(msg.sender, amount);
    }

    function prefixed(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

    function recoverSigner(bytes32 message, uint8 v, bytes32 r, bytes32 s)
        internal
        pure
        returns (address)
    {
        return ecrecover(message, v, r, s);
    }
}
