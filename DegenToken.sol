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
