## DegenToken - MetaCrafterETH-AVAX-Module4

A token designed for a gaming platform on the Avalanche network.

## Description

DegenToken (DGN) is an ERC20 token developed for a gaming platform on the Avalanche network. This smart contract includes minting, burning, transferring tokens, and a custom decimal implementation. DegenToken provides a straightforward way to manage in-game currency and integrates seamlessly with the Avalanche blockchain. This DegenToken is just for demonstration purposes only.

## Getting Started

Before starting, I recommended watching this video first provided by [MetaCris](https://www.youtube.com/watch?v=dX1EDrGFo2M)

1) Create a MetaMask wallet first.
   
2) Copy this code inside remix

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable, ERC20Burnable {
    enum Item {
        Knife,
        Glove,
        Helmet,
        Shield,
        Armor,
        Boots,
        Belt,
        Ring,
        Amulet,
        Cloak
    }

    mapping(Item => uint256) public itemPrices;
    mapping(address => Item) public redeemedItems;

    event ItemRedeemed(address indexed user, Item item, uint256 price);

    constructor() ERC20("Degen", "DGN") {
        _mint(msg.sender, 1000000);

        itemPrices[Item.Knife] = 100;//0
        itemPrices[Item.Glove] = 200;
        itemPrices[Item.Helmet] = 150;
        itemPrices[Item.Shield] = 180;
        itemPrices[Item.Armor] = 130;
        itemPrices[Item.Boots] = 210;
        itemPrices[Item.Belt] = 170;
        itemPrices[Item.Ring] = 160;
        itemPrices[Item.Amulet] = 90;
        itemPrices[Item.Cloak] = 220;//9
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function decimals() override public pure returns (uint8) {
        return 0;
    }

    function getBalance() external view returns (uint256) {
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Insufficient Degen Tokens to transfer. Check balance first.");
        _transfer(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "Insufficient Degen Tokens to burn. Check balance first.");
        _burn(msg.sender, _value);
    }

    function redeemTokens(uint256 _value) external {
        require(balanceOf(msg.sender) >= _value, "No tokens to redeem.");
        _burn(msg.sender, _value);
    }

    function redeem(Item item) external {
        uint256 itemPrice = itemPrices[item];
        require(itemPrice > 0, "Item does not exist");
        require(balanceOf(msg.sender) >= itemPrice, "Insufficient balance to redeem this item");

        _burn(msg.sender, itemPrice);

        redeemedItems[msg.sender] = item;

        emit ItemRedeemed(msg.sender, item, itemPrice);
    }

    function getRedeemedItem(address account) external view returns (Item) {
        return redeemedItems[account];
    }
}


```

3) After you compile, go to the Deployment and Section tab and change the environment to "Injected Provider". 

4) Deploy the contract. 

5) Start to explore the different functions.

## FUNCTIONS
1) MINT - get degen tokens
   
2) BURN - burn degen tokens

3) REDEEM - redeem items by using degen tokens

   ** TO REDEEM ITEMS, YOU NEED TO USE THE VALUE OF INDEX (0-9) ** 

4) GET BALANCE - see your total balance of degen tokens
   
## ADDITIONAL INFO 

If you are getting an error in which you do not have AVAX tokens, you can use this link: https://core.app/en/tools/testnet-faucet/?subnet=c&token=c 

In the coupon textbox, type "avaxstrong". After doing this, you will receive 2 AVAX coins.

If you are still having problems deploying your contract, please watch this link: https://www.youtube.com/watch?v=BlRfDZos_hI&t=377s


## AUTHORS 

ZUNIEGA, Kane Nathaniel O.
## FEU INSTITUTE OF TECHNOLOGY

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

