// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Survey.sol"; // adjust if Survey.sol is elsewhere

contract DeploySurvey is Script {
    function run() external {
        // start broadcasting with the private key you pass via CLI
        vm.startBroadcast();

        Survey survey = new Survey();
        console.log("Survey deployed at:", address(survey));

        vm.stopBroadcast();
    }
}
