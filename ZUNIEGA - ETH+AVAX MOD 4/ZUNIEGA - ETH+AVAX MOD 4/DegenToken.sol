//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "hardhat/console.sol";
contract DegenToken is ERC20, Ownable, ERC20Burnable {
    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
    }

    function mint(address to, uint256 amount) public onlyOwner{
        _mint(to, amount); 
    }

    function decimals() override public pure returns (uint8){
        return 0;
    }

    function getBalance() external view returns (uint256){
        return this.balanceOf(msg.sender);
    }

    function transferTokens(address _receiver, uint256 _value) external{
        require(balanceOf(msg.sender)>= _value, "Insufficient Degen Tokens to transfer. Check balance first.");
        _transfer(msg.sender, _receiver, _value);
    }

    function burnTokens(uint256 _value) external{
        require(balanceOf(msg.sender)>= _value, "Insufficient Degen Tokens to burn. Check balance first");      
        _burn(msg.sender, _value);
    }

    function redeemTokens(uint256 _value) external{
        require(balanceOf(msg.sender)>= _value, "No tokens to redeem.");
        _burn(msg.sender, _value);
    }
}