# Tokenizer – Token42 (T42)

This repository contains the implementation of **Token42 (T42)**, an ERC‑20 compatible token created for the Tokenizer project.
The goal of this project is to design, implement, document, deploy and demonstrate a simple fungible token on a public test blockchain.

## Choice of blockchain platform

For this project I chose to deploy the token on the **Ethereum Sepolia test network** rather than on BNB Chain:

- Sepolia is an official Ethereum testnet dedicated to development and testing.
- It allows deploying and interacting with smart contracts without using real funds.
- It is fully supported by common tools such as **Remix** and **Etherscan**.

The token follows the **ERC‑20** standard, which is the most widely used standard for fungible tokens on Ethereum.

## Choice of language and tools

- **Language:** `Solidity`  
  Solidity is the standard language for writing smart contracts on Ethereum. It is well documented and fully supported by the official tools and by OpenZeppelin.

- **Smart contract implementation:**  
  The token uses **OpenZeppelin**’s ERC‑20 implementation as a base.  
  OpenZeppelin is a widely used, audited library that provides secure and standard implementations of ERC‑20 and related contracts. This reduces the risk of bugs and makes the code easier to understand for anyone familiar with standard patterns.

- **IDE:** **Remix IDE (web)**  
  Remix is a browser-based IDE for Solidity. It supports:
  - Writing and compiling Solidity contracts.
  - Deploying directly to test networks such as Sepolia.
  - Interacting with deployed contracts.

- **Blockchain explorer:** **Etherscan (Sepolia)**  
  After deployment, the contract is verified on Etherscan, which allows:
  - Viewing the token’s details (name, symbol, decimals, total supply).
  - Inspecting transactions and holders.
  - Calling smart contract functions directly from the explorer.

## Token parameters

The Token42 ERC‑20 token has the following characteristics:

- **Name:** `Token42`
- **Symbol (ticker):** `T42`
- **Decimals:** `18`
- **Initial supply:** `200 T42` minted to the deployer (owner) at deployment.
- **Minting:** the owner can mint additional tokens after deployment.
- **Burning:** any token holder can burn their own tokens (standard `ERC20Burnable` behavior).

Ownership and privileges:

- The contract uses a simple **owner** model (`Ownable`).
- The **owner**:
  - Receives the initial supply.
  - Is allowed to mint new tokens.
- Regular users:
  - Can transfer tokens.
  - Can approve allowances.
  - Can burn their own tokens.

More details are provided in the documentation files in the `documentation/` folder.

## Repository structure

- `README.md`  
  This file. High-level explanation of choices (blockchain, language, tools) and a quick overview of the project.

- `code/`  
  Contains the Solidity source code of the token contract.  
  The main file is:
  - `Token42.sol`: ERC‑20 token implementation based on OpenZeppelin, with mint and burn functionality.

- `deployment/`  
  Contains files related to the deployment of the token.  
  In particular:
  - `DEPLOYMENT.md`: a detailed step-by-step guide explaining how to deploy `Token42` using Remix on the Sepolia test network and how to verify it on Etherscan.

- `documentation/`  
  Contains detailed documentation for the project:
  - Explanation of how the token works and which actions are possible.
  - Security and ownership model.
  - How to interact with the token (via Remix, Etherscan, or a wallet).
  - Any additional technical or functional details not covered in this README.

## Deployed contract information

- **Network:** Ethereum Sepolia testnet  
- **Contract address:** 0xcf5b10CEc114E8B03bca18262860d293F27cEA4E
- **Etherscan link:** https://sepolia.etherscan.io/address/0xcf5b10CEc114E8B03bca18262860d293F27cEA4E#events  

// zeroes for the correction 000000000000000000 && and we always have to be on the correct Metamask account!!