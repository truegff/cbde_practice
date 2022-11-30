// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract FlowControl {
  constructor() {
  }

  function shouldProvideDozenDiscount1Noob(uint256 purchasedQty) private pure returns (bool) {
    bool discount = false;
    if (purchasedQty >= 12) {
      discount = true;
    } else {
      discount = false;
    }
    return (discount);
  }

  function shouldProvideDozenDiscount2Ternary(uint256 purchasedQty) private pure returns (bool) {
    return purchasedQty >= 12;
  }

  function shouldProvideDozenDiscount3NoobWhile(uint256 purchasedQty) private pure returns (bool) {
    bool giveDozenPrice = false;
    uint256 numDonunts = 1;

    while (numDonunts < purchasedQty) {
      numDonunts++;
      if (numDonunts >= 12) {
        giveDozenPrice = true;
        break;
      }
    }

    return (giveDozenPrice);
  }

  function shouldProvideDozenDiscount4NoobDoWhile(uint256 purchasedQty) private pure returns(bool) {
    bool giveDozenPrice = false;
    uint256 numDonuts = 1;

    do {
      numDonuts++;
      if (numDonuts >= 12) {
        giveDozenPrice = true;
        break;
      }
    } while (numDonuts < purchasedQty);

    return (giveDozenPrice);
  }

  function shouldProvideDozenDiscount5For(uint256 purchasedQty) private pure returns(bool) {
    bool giveDozenPrice = false;

    for (uint256 numDonuts = 0; numDonuts <= purchasedQty; numDonuts++) {
      if (numDonuts >= 12) {
        giveDozenPrice = true;
      }
    }

    return (giveDozenPrice);
  }


}
