# Token42 Deployment Guide (Remix + Sepolia + Etherscan)

This document explains step by step how to deploy the **Token42 (T42)** contract to the **Ethereum Sepolia test network** using **Remix**, and how to verify it on **Etherscan**.

---

## 1. Prerequisites
Before starting, you need:
1. A web browser (Chrome, Firefox, etc.).
2. Access to **Remix IDE** in the browser.
3. A wallet extension such as **MetaMask**, configured for:
   - The **Sepolia** test network.
   - Some Sepolia test ETH (obtainable from a Sepolia faucet).

---

## 2. Importing the Token42 contract into Remix

1. Open **Remix IDE** in your browser.
2. In the **File Explorer** (left panel), create or open a workspace.
3. Create a new file, for example:
   - `contracts/Token42.sol`
4. Copy the entire content of `code/Token42.sol` from this repository and paste it into `contracts/Token42.sol` in Remix.

Make sure the pasted code starts with the pragma line and includes all imports:

- `@openzeppelin/contracts/token/ERC20/ERC20.sol`
- `@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol`
- `@openzeppelin/contracts/access/Ownable.sol`

In Remix, you may use the built-in OpenZeppelin package support (for example via npm or GitHub imports), or paste the OpenZeppelin contracts into your workspace if needed. The important point is that the imports resolve correctly in Remix.

---

## 3. Configuring the Solidity compiler

1. Open the **Solidity Compiler** plugin in Remix (icon that looks like a Solidity logo on the left sidebar).
2. Set the **Compiler** version to a version compatible with the contract, for example:
   - `0.8.20`
3. (Optional) Decide whether to enable optimization.  
   If you change this, remember the setting, because you must use the same configuration during contract verification on Etherscan.
4. Click **"Compile Token42.sol"**.
5. Ensure the compilation completes without errors.

If there are warnings, read them and confirm they are expected. There should be no compilation errors.

---

## 4. Connecting Remix to the Sepolia network

1. Open the **Deploy & Run Transactions** plugin (icon that looks like an Ethereum logo in Remix).
2. In the **Environment** dropdown, choose an option that connects to your wallet, for example:
   - `Injected Provider - MetaMask`
3. In your wallet (MetaMask):
   - Select the **Sepolia** network.
4. Remix should now display your Sepolia account address and its test ETH balance.

If Remix is not connected, check the browser’s wallet connection and make sure the correct network is selected.

---

## 5. Deploying the Token42 contract

1. In **Deploy & Run Transactions**:
   - Ensure the **Contract** dropdown is set to `Token42`.
2. The `Token42` constructor does not take any parameters:
   - The name (`"Token42"`), symbol (`"T42"`), decimals (`18`), and the initial supply (200 T42 to the deployer) are all set directly inside the contract code.
3. Check the **Account** field (this will be the future owner of the token and initial holder of the 200 T42).
4. Click **Deploy**.
5. Confirm the transaction in your wallet (MetaMask).
6. Wait until the transaction is mined. After that:
   - A new instance of `Token42` will appear under **Deployed Contracts** in Remix.

Note: If the deployment fails due to gas issues, increase the gas limit in your wallet and try again.

---

## 6. Recording the deployed contract address

1. In the **Deployed Contracts** section of Remix, locate the deployed `Token42` instance.
2. Copy the **contract address** displayed there.
3. Save this address in:
   - The `Deployed contract information` section of `README.md`.
   - The "Deployed contract information" section of `documentation/TOKEN42_DOCUMENTATION.md`.

You will also use this address to open the contract on Etherscan.

---

## 7. Verifying the contract on Etherscan (Sepolia)

### 7.1 Open the contract page on Etherscan

1. Open the **Sepolia Etherscan** website in your browser.
2. Paste the deployed contract address into the search bar and press Enter.
3. You should see the contract page showing basic information such as address, creator, and transactions.

### 7.2 Start the verification process

1. On the contract page, look for a button or tab similar to **"Verify and Publish"**.
2. Click it to start the source code verification process.

### 7.3 Verification settings

On the verification form:

1. Select the **compiler version** that matches the one used in Remix:
   - Example: `0.8.20`.
2. Set the **optimization** setting to match your Remix compilation settings:
   - If optimization was enabled in Remix, enable it here too.
   - If it was disabled, disable it here.

### 7.4 Providing the source code

1. Open `Token42.sol` in Remix or from this repository.
2. Copy the entire content of the file, including the `pragma` line and all import statements.
3. Paste it into the source code field on Etherscan.
4. If Etherscan provides fields for multiple files or import settings, adjust them according to how your project is structured in Remix. The simplest setup is to have all imports resolved in Remix exactly the same way.

### 7.5 Complete the verification

1. Submit the verification form.
2. Wait for Etherscan to process the submission.
3. If the configuration matches (compiler version, optimization, and source code), the contract should be marked as **verified**.
4. Once verified, Etherscan will:
   - Display the source code in the **Code** tab.
   - Provide an **"ABI"** and user interface for the contract’s functions.

---

## 8. Interacting with Token42 after deployment

Once the contract is deployed and verified, you can interact with it in several ways:

### 8.1 Using Remix

In Remix, under **Deployed Contracts**:

- Expand the `Token42` instance.
- Use the available functions:
  - `balanceOf(address)` to check balances.
  - `transfer(address,uint256)` to send tokens.
  - `approve(address,uint256)` and `transferFrom(address,address,uint256)` for allowance-based transfers.
  - `burn(uint256)` and `burnFrom(address,uint256)` for burning tokens.
  - `mint(address,uint256)` (onlyOwner) to create new tokens.

Each call that modifies the blockchain will require a transaction confirmation in your wallet.

### 8.2 Using Etherscan (Write/Read Contract)

On the Etherscan contract page:

- Use the **Read Contract** tab to:
  - View the token name, symbol, decimals, total supply, owner, and balances.
- Use the **Write Contract** tab (after connecting your wallet) to:
  - Call `transfer`, `approve`, `burn`, and other functions as needed.
  - As the owner, call `mint`, `transferOwnership`, or `renounceOwnership`.

### 8.3 Adding the token to a wallet (MetaMask)

1. Open your wallet and ensure it is on the **Sepolia** network.
2. Use the **"Import tokens"** feature.
3. Enter:
   - **Token contract address:** the deployed Token42 contract address.
   - **Token symbol:** `T42`
   - **Decimals:** `18`
4. Confirm the import. Your Token42 balance will now be visible in the wallet.

---

## 9. Summary

This file describes all the steps required to:

1. Import and compile the `Token42` contract in Remix.
2. Connect Remix to the Sepolia test network using a wallet such as MetaMask.
3. Deploy the contract and obtain its address.
4. Verify the contract on Etherscan (Sepolia).
5. Interact with the token using Remix, Etherscan, or a wallet.

Following these steps should be sufficient for the evaluator to confirm that the deployment part of the project is correctly implemented.
