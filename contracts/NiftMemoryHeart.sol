// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NiftMemoryHeart is ERC721URIStorage, Ownable {

    constructor() ERC721("Nift memory heart", "NIFT-HEART") {}

    IERC20 dust = IERC20(0xaae5fc57aE9B2702e165224bc7b4f700ba698b22);
    IERC721 treasure = IERC721(0xE3864Fb24851EA437043Ae62104dF4692e11B8b1);

    uint8 tokenId = 99;

    event Craft(address addr, uint256 time);
    event Revert(address addr, uint256 time);
    event WithdrawDust(uint256 amount, address receiver, uint256 time);

    function craft() public {
        treasure.transferFrom(msg.sender, address(this), 1);
        treasure.transferFrom(msg.sender, address(this), 2);
        treasure.transferFrom(msg.sender, address(this), 3);

        dust.transferFrom(msg.sender, address(this), 100 * 1e18);

        _mint(msg.sender,tokenId);

        _setTokenURI(tokenId, "https://ylgr.github.io/nift-memory/heart/heart.json");

        emit Craft(msg.sender, block.timestamp);
    }

    function revert() public {
        require(ownerOf(tokenId) == msg.sender, "Not own heart");
        _burn(tokenId);

        treasure.transferFrom(address(this), msg.sender, 1);
        treasure.transferFrom(address(this), msg.sender, 2);
        treasure.transferFrom(address(this), msg.sender, 3);

        emit Revert(msg.sender, block.timestamp);
    }

    function withdrawDust() public onlyOwner {
        uint256 amount = dust.balanceOf(address(this));

        require(
            amount > 0,
            "Token insufficient"
        );

        require(
            dust.transfer(owner(), amount),
            "Token transfer fail"
        );

        emit WithdrawDust(
            amount,
            owner(),
            block.timestamp
        );
    }


}
