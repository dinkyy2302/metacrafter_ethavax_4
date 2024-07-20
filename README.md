
# DegenToken Smart Contract

## Overview

An ERC20 token implementation for a student reward scheme is the `DegenToken} smart contract. The contract permits the minting, burning, and redemption of tokens for extracurricular and academic points. Additionally, it supports event management, in which students can participate in events and earn tokens for doing certain tasks.

## Features

- **ERC20 Token**: Typical token features, including the ability to manufacture, burn, and transfer tokens.
- **Student Registration**: Token redemption and activity participation are restricted to enrolled students.
- **Redeeming Tokens**: Pupils can exchange tokens for extracurricular and academic points.
- **Event Management**: The administrator may set up activities that grant tokens and extra credit to students.
- **Study and Game Awards**: Points awarded for finishing studies and taking part in games.
- **Bonus Credits**: The administrator has the authority to award extracurricular and academic bonuses.

## Contract Structure

### `DegenToken`

- **Inheritance**: Inherits from `ERC20`, `Ownable`, and `ERC20Burnable` contracts.
- **Events**:
  - `TokensMinted(address indexed to, uint256 amount)`
  - `TokensRedeemed(address indexed from, uint256 amount, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints)`
  - `EventCreated(uint256 eventId, string eventName, uint256 tokensRewarded, uint256 extraCurricularPointsRewarded)`
  - `EventAttended(address indexed student, uint256 eventId, uint256 tokensEarned)`
  - `StudyCompleted(address indexed student, uint256 tokensEarned)`
  - `GamePlayed(address indexed student, uint256 tokensEarned, uint256 extraCurricularPointsEarned)`
  - `StudentRegistered(address indexed student)`
  - `BonusCreditsGranted(address indexed student, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints)`

### Functions

- **Registration**:
  - {registerStudent(address student)}: Add a new pupil to the roll.
  - {onlyRegistered}: A modifier to guarantee that specific functions can only be called by registered students.

**Token Management**: - {mint(address to, uint256 amount)}: Mint new tokens.
  Redeem tokens for credits and points using the formula {redeemTokens(uint256 amount, uint256 mathCredit, uint256 scienceCredit, uint256 historyCredit, uint256 literatureCredit, uint256 extraCurricularPoints)}.

**Event Management**: - {createEvent(string memory name, uint256 tokensRewarded, uint256 extraCurricularPointsRewarded)}: Generate a new event.
  - {attendEvent(uint256 eventId)}: Participate in an event to receive incentives.

**Rewards**: Tokens are awarded for finishing studies when you {completeStudy(address student, uint256 tokensEarned)}.
  Give tokens and points to students who play games by using the `playGame(address student, uint256 tokensEarned, uint256 extraCurricularPointsEarned)} function.
  * {grantBonusCredits(address student, uint256 extraCurricularPoints, uint256 historyCredit, uint256 scienceCredit, uint256 mathCredit, uint256 literatureCredit)}: Approve extra credit.

- **Utility**:
  - `StudentPosition(uint256 marks)`: Determine the student's grade based on marks.
  - `passOrfail()`: Check if a student has passed based on aggregated marks.

## Installation
You can use remix ide, hardhat , truffle , i am using remix ide and after that we will show the transactions on snowtrace testnet by connecting our metamask wallet.

## Usage

1. **Deploy the Contract**: Use Remix or Truffle to deploy the `DegenToken` contract to your desired Ethereum network.
2. **Interact with the Contract**:
   - Register students using the `registerStudent` function.
   - Mint tokens and manage events using the available functions.
   - Redeem tokens for credits and points as needed.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Author
DINKY KHURANA
