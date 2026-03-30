# Token42 (T42) – Project Documentation

## 1. Overview

**Token42 (T42)** is a simple ERC‑20 compatible fungible token implemented in Solidity and deployed on the Ethereum Sepolia test network.

This documentation explains:

- What Token42 is and how it behaves.
- How ownership and privileges are managed.
- How to deploy the contract using Remix on Sepolia.
- How to verify and interact with the contract using Etherscan.
- How to use the token in a wallet.

## 2. Technical specification

- **Blockchain:** Ethereum (Sepolia test network)
- **Standard:** ERC‑20
- **Name:** `Token42`
- **Symbol (ticker):** `T42`
- **Decimals:** `18`
- **Initial supply at deployment:** `200 T42` minted to the deployer (the owner)
- **Minting:**
  - The contract owner can mint additional tokens after deployment.
- **Burning:**
  - Any holder can burn their own tokens.
  - A spender can burn tokens from another account if they have sufficient allowance (standard `ERC20Burnable` behavior).
- **Ownership model:** Simple owner pattern (`Ownable` from OpenZeppelin)
  - Owner is the account that deploys the contract.
  - Owner can mint new tokens.
  - Owner can transfer ownership or renounce ownership (standard OpenZeppelin behavior).

Implementation details:

- The contract is based on **OpenZeppelin** libraries:
  - `ERC20`
  - `ERC20Burnable`
  - `Ownable`
- Solidity version: `^0.8.20`.

---

## 3. Contract interface and main functions

### 3.1 Standard ERC‑20 functions

The contract implements all standard ERC‑20 functions, including:

- `name() -> string`
- `symbol() -> string`
- `decimals() -> uint8`
- `totalSupply() -> uint256`
- `balanceOf(address account) -> uint256`
- `transfer(address to, uint256 amount) -> bool`
- `allowance(address owner, address spender) -> uint256`
- `approve(address spender, uint256 amount) -> bool`
- `transferFrom(address from, address to, uint256 amount) -> bool`

**Typical usage:**

- `transfer` – send tokens from the caller to another address.
- `approve` – allow a spender to spend up to `amount` tokens from the caller’s balance.
- `transferFrom` – used by the spender to move tokens on behalf of the owner, within the approved allowance.

### 3.2 Minting function (owner only)

- `mint(address to, uint256 amount)`

Behavior:

- Can only be called by the **owner**.
- Increases the total supply by `amount`.
- Adds `amount` tokens to the `to` address.

Use cases:

- The owner can distribute new tokens over time if needed.

### 3.3 Burning functions

Provided by `ERC20Burnable`:

- `burn(uint256 amount)`
  - The caller burns `amount` of their own tokens.
- `burnFrom(address account, uint256 amount)`
  - Burns tokens from `account`, provided the caller has enough allowance from `account`.

This allows holders to voluntarily reduce the supply of their own tokens.

### 3.4 Ownership functions

Provided by `Ownable`:

- `owner() -> address`
- `transferOwnership(address newOwner)`
- `renounceOwnership()`

Only the owner can call `transferOwnership` and `renounceOwnership`.

## 4. Ownership and security model

### 4.1 Owner privileges

The **owner** has the following special privileges:

- Can **mint** new tokens by calling `mint(to, amount)`.
- Can transfer ownership to another address or renounce ownership.

The owner **does not** have special powers to:

- Arbitrarily take tokens from users’ balances.
- Bypass standard ERC‑20 rules.

### 4.2 Regular user capabilities

Any token holder can:

- Transfer tokens (`transfer`).
- Approve another address to spend on their behalf (`approve`).
- Use `burn` to destroy some of their own tokens.
- Allow a spender to burn tokens on their behalf using `burnFrom`, via allowance.

## 5. Deployment with Remix on Sepolia

This section explains how to deploy Token42 using **Remix** and an Ethereum wallet (for example, MetaMask) connected to the **Sepolia** test network.

> For more detailed version see `deployment/DEPLOYMENT.md`.

### 5.1 Prerequisites

1. A web browser (Chrome, Firefox, etc.).
2. Access to **Remix IDE** (web).
3. A wallet extension such as **MetaMask**, configured for:
   - The **Sepolia** test network.
   - Some Sepolia test ETH (from a Sepolia faucet).

### 5.2 Creating the contract file in Remix

1. Open **Remix IDE** in your browser.
2. In the **File Explorer** panel, create a new workspace if needed.
3. Create a new file inside the workspace, for example:
   - `contracts/Token42.sol`
4. Paste the Solidity contract code from `code/Token42.sol` in this file.

### 5.3 Configuring the Solidity compiler

1. Open the **Solidity Compiler** plugin in Remix.
2. Set the compiler version to a version compatible with the contract:
   - For example: `0.8.20`.
3. Make sure the "Enable optimization" setting matches what you want to use later for verification (by default it can be disabled or enabled; just remember your choice).
4. Click **Compile Token42.sol**.
5. Fix any compilation warnings/errors if they appear.

### 5.4 Connecting Remix to Sepolia

1. Open the **Deploy & Run Transactions** plugin in Remix.
2. In the **Environment** dropdown, choose the option that connects to your wallet (for example `Injected Provider - MetaMask`).
3. Make sure your wallet is set to the **Sepolia** network.
4. Remix should now show your Sepolia address and balance.

### 5.5 Deploying the contract

1. In **Deploy & Run Transactions**:
   - Ensure `Token42` is selected in the contract dropdown.
2. There are **no constructor parameters** to configure manually, since the name, symbol, decimals, and initial supply are fixed in the contract.
3. Check that the **Account** field is set to the address that should become the owner.
4. Click **Deploy**.
5. Confirm the transaction in your wallet (MetaMask).
6. Wait for the transaction to be mined. Remix will then display the deployed contract instance under **Deployed Contracts**.

## 6. Verifying the contract on Etherscan (Sepolia)

After deployment, you should verify the contract on **Etherscan** for the Sepolia network.

### 6.1 Opening the contract on Etherscan

1. Go to the **Sepolia Etherscan** website.
2. Paste your deployed contract address in the search bar.
3. Open the contract page.

### 6.2 Starting verification

1. On the contract page, find and click the **"Verify and Publish"** (or similar) button.
2. Select:
   - The same **compiler version** you used in Remix (for example `0.8.20`).
   - The same **optimization settings** (enabled/disabled).

### 6.3 Providing the source code

1. Copy the full content of `Token42.sol` (including the `pragma solidity` line and all imports).
2. Paste it into the source code field on Etherscan.
3. If Etherscan shows additional fields for imports or settings, fill them according to how the contract was compiled in Remix.

### 6.4 Completing verification

1. Submit the verification form.
2. If everything matches correctly, Etherscan will mark the contract as **verified**.
3. The source code and ABI will now be publicly visible.


## 7. Interacting with the token via Etherscan

Once verified, Etherscan allows you to interact with the contract directly from the browser.

### 7.1 Viewing token information

On the contract page you can see:

- **Name**: `Token42`
- **Symbol**: `T42`
- **Decimals**: `18`
- **Total Supply**: the current total number of tokens (initially `200 T42`, then updated if the owner mints more).

### 7.2 Using the Read Contract tab

In the **Read Contract** tab, you can:

- Check balances with `balanceOf(address)`.
- See total supply with `totalSupply()`.
- View the `owner()` address.

### 7.3 Using the Write Contract tab

In the **Write Contract** tab (you must connect your wallet):

- As a **regular user**:
  - Call `transfer` to send tokens to another address.
  - Call `approve` to allow a spender to use your tokens.
  - Call `burn` to destroy some of your own tokens.
- As the **owner**:
  - Call `mint` to create new tokens and assign them to a chosen address.
  - Use ownership functions (`transferOwnership`, `renounceOwnership`) if desired.

Each of these actions will create a transaction that must be confirmed in your wallet.

---

## 8. Using the token in a wallet (e.g., MetaMask)

After deployment, you can add Token42 to your wallet.

### 8.1 Adding Token42 to MetaMask

1. Open your wallet (MetaMask).
2. Make sure you are on the **Sepolia** network.
3. Click **"Import tokens"** (or equivalent).
4. Enter:
   - **Token contract address** 
5. Confirm the import.

Your balance of Token42 (for that account) will now be displayed.

---

## 9. Summary of possible actions

- **Owner:**
  - Receive the initial supply of `200 T42`.
  - Mint additional tokens to any address.
  - Transfer or renounce ownership.
  - Use all standard ERC‑20 and burn functions like any user.

- **Any token holder:**
  - Check their balance.
  - Transfer tokens to others.
  - Approve a spender and use `transferFrom`.
  - Burn their own tokens (and allow others to burn their tokens via `burnFrom` if they give allowance).
