// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract NiftMemoryTreasure is ERC721URIStorage, Ownable {

    constructor() ERC721("Nift memory artifact", "NIFT-ARTIFACT") {}

    IERC20 dust = IERC20("");
    IERC721 treasure = IERC721("");

    event Craft(address addr, uint256 time);
    event Revert(address addr, uint256 time);
    event WithdrawDust(uint256 amount, address receiver, uint256 time);

    function craft() public {
        treasure.transferFrom(msg.sender, this, 1);
        treasure.transferFrom(msg.sender, this, 2);
        treasure.transferFrom(msg.sender, this, 3);

        dust.transferFrom(msg.sender, this, 100 * 1e18);

        _mint(msg.sender,1);

        _setTokenURI(1, "https://ylgr.github.io/nift-memory/artifact/artifact.json");

        emit Craft(msg.sender, block.timestamp);
    }

    function revert() public {
        require(_owners[1] == msg.sender, "Not own artifact");
        _burn(1);

        treasure.transferFrom(this, msg.sender, 1);
        treasure.transferFrom(this, msg.sender, 2);
        treasure.transferFrom(this, msg.sender, 3);

        emit Revert(msg.sender, block.timestamp);
    }

    function withdrawDust() public onlyOwner {
        IERC20 token = IERC20(_token);
        uint256 amount = token.balanceOf(address(this));

        require(
            amount > 0,
            "Token insufficient"
        );

        require(
            token.transfer(owner(), amount),
            "Token transfer fail"
        );

        emit WithdrawDust(
            amount,
            owner(),
            block.timestamp
        );
    }


}
