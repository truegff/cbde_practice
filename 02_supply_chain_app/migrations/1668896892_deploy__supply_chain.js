const SupplyChainContract = artifacts.require("SupplyChain");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(SupplyChainContract);
};
