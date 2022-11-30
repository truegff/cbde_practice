// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract HelloWorld {

    string private helloMessage = "Hello world";


    function getHelloMessage() public view returns(string memory message) {
        return helloMessage;
    }

}