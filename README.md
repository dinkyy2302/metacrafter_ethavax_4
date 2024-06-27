## StudentToken Smart Contract

### Overview

An Ethereum blockchain-based ERC20 token implementation is the `StudentToken} contract. It also has other features like minting, burning, and redeeming tokens for different kinds of cards. The agreement makes use of OpenZeppelin's libraries to guarantee uniformity and security.

###  Features of the contract

1. **Token Initialization**:
   - The name "Student" and the symbol "STU" are used to initialize the contract.
    - The owner is designated as the deployer.

2. **Token purchasing**:
   - By adding their purchasing information to a queue, users can buy tokens.

3. **Token Minting**:
   -Every buyer in line can have tokens minted for them by the contract owner.

4. **Token Transfer**:
   - Users have the ability to send tokens to different addresses.
   - The ERC20 standard's `transfer`, `transferFrom`, and `approve} methods are superseded by the contract.

5. **Token Burning**:
   - Tokens can be burned by users to redeem different kinds of cards.
    - Tokens from any account can be burned by the owner.

6. **Card Redemption**:
    -Tokens can be exchanged for Common, Uncommon, Rare, Epic, and Legendary cards, among other card types.
    - There is a token cost associated with each sort of card.

7. **Balance Check**:
   -Users are able to view the balance of their tokens.


### Usage

1. **Deploying the Contract**:
    - The contract deployer is set as the initial owner.
    - Use a Solidity-compatible environment such as Remix to deploy the contract.

2. **Purchasing Tokens**:
    - Users can call `purchaseTokens` with their address and the amount of tokens they wish to purchase.

3. **Minting Tokens**:
    - The owner can call `mintTokens` to mint tokens for all buyers in the queue.

4. **Transferring Tokens**:
    - Users can transfer tokens using the `transferTokens` function.
    - Additionally, users can use the standard `transfer` and `transferFrom` functions.

5. **Redeeming Cards**:
    - Users can redeem tokens for various card types using the `redeemCard` function.

6. **Burning Tokens**:
    - The owner can burn tokens from any account using the `burnTokens` function.

7. **Checking Balance**:
    - Users can check their token balance using the `getTokenBalance` function.

### Security Considerations

- **OnlyOwner**: Certain functions are restricted to the owner to prevent unauthorized actions.
- **Require Statements**: Various checks are in place to ensure valid inputs and sufficient balances.
- **OpenZeppelin Libraries**: The contract uses well-tested and secure implementations from OpenZeppelin to minimize risks.

### License

This project is licensed under the MIT License.

### Author

### DINKY KHURANA
