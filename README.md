# Airdrop Contract Project

This project contains a simple airdrop contract developed during my internship with Guild Audit. The primary objective of this project is to understand and demonstrate a signature replay bug and its exploitation using Foundry.

## Project Structure

- `src/Airdrop.sol`: The airdrop contract.
- `script/Exploit.s.sol`: The script to exploit the signature replay bug.
- `test/Airdrop.t.sol`: The test contract containing tests for the airdrop contract.

## Airdrop Contract

The airdrop contract allows users to claim airdrops using a signed message from the owner. However, it contains a signature replay bug that allows malicious users to reuse the same signature multiple times to claim more airdrops.

### Features

- **Claim Airdrop**: Users can claim a specified amount of airdrop using a signed message from the owner.
- **Event Emitted**: An event `Airdropped` is emitted when a user claims an airdrop.

### Functions

- `claim(uint256 amount, uint8 v, bytes32 r, bytes32 s)`: Allows users to claim airdrop using a signed message from the owner.

## Testing and Exploitation

The project includes tests and a script written using Foundry's testing framework to demonstrate and exploit the signature replay bug.

### Invariant Tests

- **Signature Replay Bug**: Tests that an attacker can reuse a valid signature to claim airdrop multiple times.

### Exploit Script

The exploit script demonstrates how a malicious user can exploit the signature replay bug to claim the airdrop multiple times using the same signature.

## Setup and Usage

1. **Install Foundry**

   Follow the installation instructions from the [Foundry GitHub page](https://github.com/foundry-rs/foundry):

   ```sh
   curl -L https://foundry.paradigm.xyz | bash
   foundryup

2. **Clone the Repository**
    git clone https://github.com/Bryanmankind/guildAudits_stakingContract.git
    cd guildAudit_Airdrop

3. **Run the Tests**
    forge test
