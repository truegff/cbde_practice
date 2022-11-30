const HelloWorldContract = artifacts.require("HelloWorld");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(HelloWorldContract);
};