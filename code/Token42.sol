// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/* Import the standard ERC20 implementation from OpenZeppelin.
This provides all the basic ERC20 functionality:
- balances, total supply, transfers, allowances (approve/transferFrom) */
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/* Import the ERC20Burnable extension from OpenZeppelin.
 This adds two functions:
 - burn(amount): burn tokens from the caller's balance
 - burnFrom(account, amount): burn tokens from "account" using allowance */
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

/* Import the Ownable contract from OpenZeppelin.
This defines an "owner" address and provides:
- onlyOwner modifier to restrict function access
- transferOwnership and renounceOwnership functions */
import "@openzeppelin/contracts/access/Ownable.sol";

/* @title Token42 ERC20 Token
A simple ERC20 token created for the Tokenizer project.
Deployed on the Ethereum Sepolia test network.
Initial supply: 200 T42 minted to the deployer (owner) && Owner can mint additional tokens.
Any holder can burn their own tokens (standard ERC20Burnable behavior). */
contract Token42 is ERC20, ERC20Burnable, Ownable {
    constructor()  ERC20("Token42", "T42")  Ownable(msg.sender) {
        // I use 18 decimals (like ETH), so we need to multiply the human-readable
        // amount (200) by 10^18 to get the amount in "wei-like" token units.
        uint256 initialSupply = 200 * 10 ** uint256(decimals());

        // _mint is provided by OpenZeppelin's ERC20 implementation.
        // It increases totalSupply and adds tokens to the given address.
        _mint(_msgSender(), initialSupply);
    }

    /* Returns the number of decimal places used by the token.
    Overridden to explicitly return 18.
    Even though OpenZeppelin's ERC20 already defaults to 18 decimals,
    we override this function to make the choice explicit and visible in the code.
    @return uint8 The number of decimals (18). */
    function decimals() public pure override returns (uint8) {
        return 18;
    }

    /* Mints new tokens to a specific address.
    Only the owner can call this function (onlyOwner modifier).
    Increases totalSupply and the balance of the "to" address.
    - "amount" is expressed in the smallest unit (like wei for ETH),
    so to mint X whole tokens with 18 decimals, use X * 10**18.
    @param to The address that will receive the newly minted tokens.
    @param amount The amount of tokens to mint, in smallest token units.*/
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Inherited functions:
    //
    // The following functions are inherited from OpenZeppelin and are not
    // redefined here. They behave according to the standard ERC20, ERC20Burnable
    // and Ownable implementations:
    //
    // From ERC20:
    // - function name() public view returns (string memory);
    // - function symbol() public view returns (string memory);
    // - function totalSupply() public view returns (uint256);
    // - function balanceOf(address account) public view returns (uint256);
    // - function transfer(address to, uint256 amount) public returns (bool);
    // - function allowance(address owner, address spender) public view returns (uint256);
    // - function approve(address spender, uint256 amount) public returns (bool);
    // - function transferFrom(address from, address to, uint256 amount) public returns (bool);
    //
    // From ERC20Burnable:
    // - function burn(uint256 amount) public;
    //      Burns tokens from the caller's balance.
    //
    // - function burnFrom(address account, uint256 amount) public;
    //      Burns tokens from "account", using the caller's allowance.
    //
    // From Ownable:
    // - function owner() public view returns (address);
    // - function transferOwnership(address newOwner) public onlyOwner;
    // - function renounceOwnership() public onlyOwner;
    //
    // These functions are used exactly as defined in the OpenZeppelin library.
    // No custom logic is added on top of them in this contract.
    // --------------------------------------------
}
