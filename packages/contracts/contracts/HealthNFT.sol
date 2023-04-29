// https://eips.ethereum.org/EIPS/eip-721, http://erc721.org/ 
// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HealthNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;
    
    constructor() ERC721("HealthNft", "HSBT") {
        _tokenIdCounter = 0;
    }

    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        require(from == address(0), "SoulboundToken: Tokens cannot be transferred");
        super.transferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        require(from == address(0), "SoulboundToken: Tokens cannot be transferred");
        super.safeTransferFrom(from, to, tokenId);
    }

    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {
        require(from == address(0), "SoulboundToken: Tokens cannot be transferred");
        super.safeTransferFrom(from, to, tokenId, _data);
    }

    function mint(address to) public onlyOwner returns(uint) {
        uint256 tokenId = _tokenIdCounter;
        _safeMint(to, tokenId);
        _tokenIdCounter = _tokenIdCounter + 1;
        return tokenId;
    }

    // function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
    //     super._burn(tokenId);
    // }

    function getTokenCounter() public view returns(uint256) {
        return _tokenIdCounter;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}