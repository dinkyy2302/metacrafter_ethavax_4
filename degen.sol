 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
//these imported links ensures that the all erc 20 token functions can called
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract StudentToken is ERC20, Ownable, ERC20Burnable {

    //The constructor correctly initializes the ERC20 token with the name "Student" and symbol "STU".
    constructor() ERC20("Student", "STU") Ownable(msg.sender) {
        //it calls msg.sender to deployer
    }

    enum CardType { Common, Uncommon, Rare, Epic, Legendary }

    struct Buyer {
        address buyerAddress;
        uint256 tokenAmount;
    }

    Buyer[] public buyerQueue;

    struct CardCollection {
        uint256 common;
        uint256 uncommon;
        uint256 rare;
        uint256 epic;
        uint256 legendary;
    }

    mapping(address => CardCollection) public userCards;

    //purchaseTokens allows users to purchase tokens by adding them to a queue.
    function purchaseTokens(address buyerAddress, uint256 tokenAmount) public {
        require(buyerAddress != address(0), "Invalid address");
        require(tokenAmount > 0, "Invalid token amount");
        buyerQueue.push(Buyer({buyerAddress: buyerAddress, tokenAmount: tokenAmount}));
    }

       // to mint or add tokens for all buyers in the queue. 
    function mintTokens() public onlyOwner {
        uint256 queueLength = buyerQueue.length;
        while (queueLength > 0) {
            Buyer memory lastBuyer = buyerQueue[queueLength - 1];
            _mint(lastBuyer.buyerAddress, lastBuyer.tokenAmount);
            buyerQueue.pop();
            queueLength--;
        }
    }


   //it will transfer tokens to recipient by checking amount
    function transferTokens(address recipient, uint256 amount) public {
        require(recipient != address(0), "Invalid recipient address");
        require(amount <= balanceOf(msg.sender), "Insufficient balance");
        _transfer(msg.sender, recipient, amount);
    }


    //Users can redeem tokens for various card types
    function redeemCard(CardType cardType) public {
        uint256 cardCost = getCardCost(cardType);
        require(balanceOf(msg.sender) >= cardCost, "Insufficient tokens to redeem card");

        if (cardType == CardType.Common) {
            userCards[msg.sender].common += 1;
        } else if (cardType == CardType.Uncommon) {
            userCards[msg.sender].uncommon += 1;
        } else if (cardType == CardType.Rare) {
            userCards[msg.sender].rare += 1;
        } else if (cardType == CardType.Epic) {
            userCards[msg.sender].epic += 1;
        } else if (cardType == CardType.Legendary) {
            userCards[msg.sender].legendary += 1;
        }
        burn(cardCost);
    }
    
    //This function burn tokens from any account
    function burnTokens(address account, uint256 amount) public onlyOwner {
        _burn(account, amount);
    }


    //This function returns the balance of the caller's tokens. 
    function getTokenBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function getCardCost(CardType cardType) internal pure returns (uint256) {
        if (cardType == CardType.Common) {
            return 10;
        } else if (cardType == CardType.Uncommon) {
            return 20;
        } else if (cardType == CardType.Rare) {
            return 30;
        } else if (cardType == CardType.Epic) {
            return 40;
        } else if (cardType == CardType.Legendary) {
            return 50;
        } else {
            revert("Invalid card type");
        }
    }

      function transfer(address to, uint256 amount) public virtual override returns (bool) {//this function is basically to transfer to which account directly
        _transfer(_msgSender(), to, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        //this account will ask user to prompt the user to add input
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), allowance(sender, _msgSender()) - amount);
        return true;
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        //to approve all the transactions
        _approve(_msgSender(), spender, amount);
        return true;
    }
}
