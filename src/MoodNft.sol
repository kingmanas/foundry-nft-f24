// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {ERC721} from "lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";


contract MoodNft is ERC721{

    error MoodNft__CantFlipMoodIfNotOwner();
     
     uint256 private s_tokenCounter;
     string private s_sadSvgImageUri;
     string private s_happySvgImageUri;

     enum Mood {
        Happy,
        Sad
     }

     mapping(uint256 => Mood) private s_tokenIdToMood;

     constructor(string memory sadSvg, string memory happySvg) ERC721("Mood Nft" , "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvg;
        s_happySvgImageUri = happySvg;
     }

     function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.Happy;
        s_tokenCounter++;
        
     }

     function flipMood(uint256 tokenId) public{
        if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender){
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        if(s_tokenIdToMood[tokenId] == Mood.Happy){
            s_tokenIdToMood[tokenId] = Mood.Sad;
        }else{
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }
     }

     function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
     }

     function tokenURI(uint256 tokenId)public view override returns(string memory)
     {
        string memory imageURI;
        if(s_tokenIdToMood[tokenId] == Mood.Happy){
              imageURI = s_happySvgImageUri;
        }else{
            imageURI = s_sadSvgImageUri;
        }

         return string(abi.encodePacked( _baseURI() , Base64.encode(bytes(abi.encodePacked('{"name": "', name(), '", "description": "An Nft that eflects mood of owners", "attributes":[{"trait_type": "moodiness", "value": 100}], "image": "', imageURI,'"}')))));
     }
}

