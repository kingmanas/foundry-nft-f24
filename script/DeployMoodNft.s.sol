// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script , console} from "lib/forge-std/src/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "lib/openzeppelin-contracts/contracts/utils/Base64.sol";

contract DeployMoodNft is Script{
  function run() external returns(MoodNft){
    string memory sadSvg = vm.readFile("./img/Sad.svg");
    string memory happySvg = vm.readFile("./img/Happy.svg");

    vm.startBroadcast();
    MoodNft moodNft = new MoodNft(
      svgToImageURI(sadSvg),
      svgToImageURI(happySvg)
    );
    vm.stopBroadcast();
    return moodNft;
  }

  function svgToImageURI(string memory svg) public pure returns(string memory){
    string memory baseURI = "data:image/svg+xml;base64,";
    string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));

    return string(abi.encodePacked(baseURI , svgBase64Encoded));
  }
  }