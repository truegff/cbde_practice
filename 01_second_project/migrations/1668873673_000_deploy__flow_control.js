const FlowControlContract = artifacts.require("FlowControl");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(FlowControlContract);
};