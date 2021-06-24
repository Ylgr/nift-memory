// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NiftMemoryTreasure is ERC721URIStorage {

    constructor() ERC721("Nift memory treasure", "NIFT-TREASURE") {
        _mint(msg.sender,1);
        _mint(msg.sender,2);
        _mint(msg.sender,3);

        _setTokenURI(1, "https://ylgr.github.io/nift-memory/treasure/freedom.json");
        _setTokenURI(2, "https://ylgr.github.io/nift-memory/treasure/wealth.json");
        _setTokenURI(3, "https://ylgr.github.io/nift-memory/treasure/happiness.json");
    }
}
