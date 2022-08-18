// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract NFT is ERC721URIStorage  {
    using Strings for uint256;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    // social media struct.
    struct Media {
        string twitter;
        string linkedin;
        string facebook;
        string email;
    }

    Media media;
    
    mapping(uint256 => uint256) public tokenIdToLevels;

    constructor() ERC721 ("NFT", "NFT"){
      media = Media('301NFTtwitter', '301NFTlinkedin', '301NFTfacebook', '301NFTemail');
    }

    function getTwitter() public view returns (string memory) {
      return media.twitter;
    }
   
    function getLinkedin() public view returns (string memory) {
      return media.linkedin;
    }
   
    function getFacebook() public view returns (string memory) {
      return media.facebook;
    }
   
    function getEmail() public view returns (string memory) {
      return media.email;
    }

    function updateMedia(string memory twitter, string memory linkedin, string memory facebook, string memory email) public{
        media = Media(twitter, linkedin, facebook, email);
        uint256 currentId = _tokenIds.current();
        _setTokenURI(currentId, getTokenURI(currentId));
    }

    function generateCharacter(uint256 tokenId) public view returns(string memory){
        
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            '<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>',
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="10%" class="base" dominant-baseline="middle" text-anchor="middle">',"301NFT",'</text>',
            '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Levels: ",getLevels(tokenId),'</text>',
            '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Twitter: ",getTwitter(),'</text>',
            '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "LinkedIn: ",getLinkedin(),'</text>',
            '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">', "FaceBook: ",getFacebook(),'</text>',
            '<text x="50%" y="90%" class="base" dominant-baseline="middle" text-anchor="middle">', "Email: ",getEmail(),'</text>',
            '</svg>'
        );
        return string(
            abi.encodePacked(
                "data:image/svg+xml;base64,",
                Base64.encode(svg)
            )    
        );
    }

    function getLevels(uint256 tokenId) public view returns (string memory) {
        uint256 levels = tokenIdToLevels[tokenId];
        return levels.toString();
    }

    function getTokenURI(uint256 tokenId) public view returns (string memory){
        bytes memory dataURI = abi.encodePacked(
            '{',
                '"name": "301 NFT #', tokenId.toString(), '",',
                '"description": "The next generation NFT",',
                '"image": "', generateCharacter(tokenId), '"',
            '}'
        );
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            )
        );
    }

    function mint() public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(msg.sender, newItemId);
        tokenIdToLevels[newItemId] = 0;
        _setTokenURI(newItemId, getTokenURI(newItemId));
    }

    function train(uint256 tokenId) public{
        require(_exists(tokenId), "Please make sure token id exist!");
        require(ownerOf(tokenId) == msg.sender, "Only owner may level up!");
        uint256 currentlevel = tokenIdToLevels[tokenId];
        tokenIdToLevels[tokenId] = currentlevel + 1;
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}