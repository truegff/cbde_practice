// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DataTypes {

  uint256 x = 9;
  int256 i = -68;
  uint8 j = 17;
  bool isEtereumCool = true;

  address owner = msg.sender;

  bytes32 bMsg = "hello";
  string sMsg = "hello";

  constructor() {
  }

  function getStateVariables() public view returns (uint256, int256, uint8, bool, address, bytes32, string memory) {
    return (x, i, j, isEtereumCool, owner, bMsg, sMsg);
  }

  function setbMsg(bytes32 newMessage) external {
    bMsg = newMessage;
  }

}
