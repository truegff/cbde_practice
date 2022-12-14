const SupplyChain = artifacts.require("SupplyChain");

/*
 * uncomment accounts to access the test accounts made available by the
 * Ethereum client
 * See docs: https://www.trufflesuite.com/docs/truffle/testing/writing-tests-in-javascript
 */
contract("SupplyChain", function (/* accounts */) {
  it("should assert true", async function () {
    await SupplyChain.deployed();
    return assert.isTrue(true);
  });
});

async function invoke(contract, methodName, ...parameters) {
    let method = contract[methodName];
    let result = await method.call.apply(this, parameters);
    await method.apply(this, parameters);
    return result;
}

contract("SupplyChain", async accounts => {
  it('should create a Participant', async () => {
    let instance = await SupplyChain.deployed();

    let participantIdBN;
    let participant;


    participantIdBN = await invoke(instance, 'addParticipant', "A", "passA", "0xccc00f129AD3316defdE4E1bb4c33B41aEC9be30", "Manufacturer");
    participant = await instance.participants(participantIdBN.toNumber());
    assert.equal(participant[0], "A");
    assert.equal(participant[2], "Manufacturer");

    participantIdBN = await invoke(instance, 'addParticipant', "B", "passB", "0x1f0fa5e75e69653c39d5c60bdA713BFF3F3bA5b1", "Supplier");
    participant = await instance.participants(participantIdBN.toNumber());
    assert.equal(participant[0], "B");
    assert.equal(participant[2], "Supplier");

    participantIdBN = await invoke(instance, 'addParticipant', "C", "passC", "0x0925D81C9d639b8994ea74330AC24ca72d6135d6", "Consumer");
    participant = await instance.participants(participantIdBN.toNumber());
    assert.equal(participant[0], "C");
    assert.equal(participant[2], "Consumer");
  });

  it("should return Participant details", async() => {
    let instance;
    let participantDetails;
    
    instance = await SupplyChain.deployed();
    participantDetails = await instance.getParticipant(0);
    assert.equal(participantDetails[0], "A");

    instance = await SupplyChain.deployed();
    participantDetails = await instance.getParticipant(1);
    assert.equal(participantDetails[0], "B");

    instance = await SupplyChain.deployed();
    participantDetails = await instance.getParticipant(2);
    assert.equal(participantDetails[0], "C");
  });
});