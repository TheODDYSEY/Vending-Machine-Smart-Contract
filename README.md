# Vending Machine Smart Contract
![Vending Machine Smart Contract](./vending-machine.png)

## Overview

This Solidity-based smart contract simulates a vending machine for purchasing virtual donuts using Ethereum. The owner of the vending machine can restock it, and users can purchase donuts by paying in Ether.

## Features

- **Owner-controlled restocking**: Only the contract owner can add more donuts.
- **Purchasing donuts**: Users can buy donuts by sending 2 ETH per donut.
- **Balance checking**: Anyone can check the available donuts in the vending machine.

## Key Functions

- `getVendingMachineBalance()`: Returns the number of donuts left in the vending machine.
- `restock(uint amount)`: Allows the owner to restock the vending machine.
- `purchase(uint amount)`: Allows users to purchase donuts (2 ETH per donut).

## Usage

1. **Deploy** the contract with an initial stock of 100 donuts.
2. **Restock** donuts (owner only):
   ```solidity
   vendingMachine.restock(50); // Add 50 donuts
   ```
3. **Purchase** donuts (any user):
   ```solidity
   vendingMachine.purchase{value: 4 ether}(2); // Buy 2 donuts for 4 ETH
   ```
4. **Check balance**:
   ```solidity
   vendingMachine.getVendingMachineBalance(); // Check stock
   ```

## Contributors

This project was built with the contributions of the following students:

- **Moses Sabila** – Smart contract implementation, project structuring.
- **Yvette Mukenyi** – Testing and debugging.
- **Nelissa Gitau** – Documentation and project setup assistance.
- **Dave Avina** – Design and integration.

