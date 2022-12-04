require('dotenv').config();
const {
  PROJECT_ID_GOERLI,
  MNEMONIC_GOERLI,
  PROJECT_ID_MAINNET,
  MNEMONIC_MAINNET
} = process.env;

const HDWalletProvider = require('@truffle/hdwallet-provider');



module.exports = {

  networks: {

    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*",
      confirmations: 0,
      timeoutBlocks: 50,
      skipDryRun: false,
      production: false
    },

    goerli: {
      network_id: 5,
      provider: function () {
        return new HDWalletProvider(MNEMONIC_GOERLI, `https://goerli.infura.io/v3/${PROJECT_ID_GOERLI}`);
      },
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: false,
      production: false
    },

    mainnet: {
      network_id: 1,
      port: 8545,
      provider: function () {
        return new HDWalletProvider(MNEMONIC_MAINNET, `https://mainnet.infura.io/v3/${PROJECT_ID_MAINNET}`);
      },
      confirmations: 8,
      timeoutBlocks: 200,
      skipDryRun: false,
      production: true
    }

  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.17" // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }

  // Truffle DB is currently disabled by default; to enable it, change enabled:
  // false to enabled: true. The default storage location can also be
  // overridden by specifying the adapter settings, as shown in the commented code below.
  //
  // NOTE: It is not possible to migrate your contracts to truffle DB and you should
  // make a backup of your artifacts to a safe location before enabling this feature.
  //
  // After you backed up your artifacts you can utilize db by running migrate as follows:
  // $ truffle migrate --reset --compile-all
  //
  // db: {
  //   enabled: false,
  //   host: "127.0.0.1",
  //   adapter: {
  //     name: "indexeddb",
  //     settings: {
  //       directory: ".db"
  //     }
  //   }
  // }
};
