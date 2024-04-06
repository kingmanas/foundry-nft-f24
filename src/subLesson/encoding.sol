
//*********Abi.Encode & Abi.EncodePacked */

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract Encoding{
    function combineStrings() public pure returns(string memory){
       return string(abi.encodePacked("Hi Mom!  " , "Miss You!"));
    }

    function encodeNumber() public pure returns(bytes memory){
      bytes memory number = abi.encode(1);
      return number;
    }

    function encodeStringPacked() public pure returns(bytes memory){
         bytes memory someString = abi.encodePacked("Block it with BlockBuddys");
         return someString;
    }
    function encodeString() public pure returns(bytes memory){
         bytes memory someString = abi.encode("Block it with BlockBuddys");
         return someString;
    }

    function decodeString() public pure returns(string memory){
        string memory someString = abi.decode(encodeString() , (string));
        return someString;
    }

    function multiEncode() public pure returns(bytes memory){
        bytes memory someString = abi.encode("some String" , "Other String");
        return someString;
    }

    function multiDecode() public pure  returns(string memory , string memory){
        (string memory someString , string memory otherString) = abi.decode(multiEncode() , (string ,string));
        return (someString , otherString);
     }

     //we can also do it for abi.encodePacked

     //How do we populate the data field..??
     

     
}