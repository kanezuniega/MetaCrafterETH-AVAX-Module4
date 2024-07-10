## DegenToken - MetaCrafterETH-AVAX-Module4

A token designed for a gaming platform on the Avalanche network.

## Description

DegenToken (DGN) is an ERC20 token developed for a gaming platform on the Avalanche network. This smart contract includes minting, burning, transferring tokens, and a custom decimal implementation. DegenToken provides a straightforward way to manage in-game currency and integrates seamlessly with the Avalanche blockchain. This DegenToken is just for demonstration purposes only.

## Getting Started

Before starting, I recommended watching this video first provided by [MetaCris](https://www.youtube.com/watch?v=dX1EDrGFo2M)

1) Create a MetaMask wallet first.
   
2) Copy this code inside remix

```javascript
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

```

3) After you compile, go to the Deployment and Section tab and change the environment to "Injected Provider". 

4) Deploy the contract. 

5) Start to explore the different functions.
   
## ADDITIONAL INFO 

If you are getting an error in which you do not have AVAX tokens, you can use this link: https://core.app/en/tools/testnet-faucet/?subnet=c&token=c 

In the coupon textbox, type "avaxstrong". After doing this, you will receive 2 AVAX coins.

If you are still having problems deploying your contract, please watch this link: https://www.youtube.com/watch?v=BlRfDZos_hI&t=377s


## AUTHORS 

ZUNIEGA, Kane Nathaniel O.
## FEU INSTITUTE OF TECHNOLOGY

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

