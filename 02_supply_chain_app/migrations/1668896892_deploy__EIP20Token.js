const EIP20TokenContract = artifacts.require("EIP20Token");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(
    EIP20TokenContract,
    1000, // initial amount
    "SashaToken", // token name
    2, // decimal units
    "STK" // token symbol
  );
};
