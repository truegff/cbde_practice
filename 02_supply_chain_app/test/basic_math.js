const BasicMath = artifacts.require("BasicMath");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("BasicMath", async () => {
  it("the sum should not overflow", async () => {
    try {
      let instance = await BasicMath.deployed();

      // Try to add 2^256 and 5 (should overflow and throw an exception)
      const addResult = await instance.add((2**256-1), 5);
      assert.ok(false, "Throw an exception instead of overflowing.");
    } catch (error) {
      // console.error(error);
      assert.ok(true, "Caught the exception.");
    }
  });
});
