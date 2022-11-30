const DataTypesContract = artifacts.require("DataTypes");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(DataTypesContract);
};