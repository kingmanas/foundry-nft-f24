// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "lib/forge-std/src/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
     DeployBasicNft public deployer;
     BasicNft public basicNft;
     address public USER = makeAddr("User");
     string public constant PUG = "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

     function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
     }

     function testNameOfNftIsCorrect() public view {
        string memory expectedName = "BlockBuddy";
        string memory realName = basicNft.name();
        //we can't directly compare strings hence we convert string into bytes by using abi.encode and then getting its hash(byest32) by keccak256 and then comparing them.
        //    string --->>> bytes --->>> hash(bytes32)   //
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(realName)));
     }

     function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
     }
}