// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract SupplyChain {

  struct product {
    string modelNumber;
    string partNumber;
    string serialNumber;
    address productOwner;
    uint32 cost;
    uint32 manufacturerTimeStamp;
  }

  // Products by product ID (product_id)
  mapping(uint32 => product) private products;


  struct ownership {
    uint32 productId;
    uint32 ownerId;
    uint32 trxTimeStamp;
    address productOwner;
  }
  // Ownerships by ownership ID (owner_id)
  mapping(uint32 => ownership) private ownerships;

  // Ownerships by product ID (product_id)
  mapping(uint32 => uint32[]) private productTrack;


  struct participant {
    string username;
    string password;
    string participantType;
    address participantAddress;
  }
  // Participants by product ID (product_id)
  mapping(uint32 => participant) public participants;


  uint32 private product_id     = 0;
  uint32 private participant_id = 0;
  uint32 private owner_id       = 0;

  event TransferOwnership(uint32 productId);


  constructor() {
  }

  function addParticipant(
    string calldata _name,
    string calldata _pass,
    address _pAddress,
    string calldata _pType
  ) public returns (uint32)
  {
    uint32 userId = participant_id++;

    {
      participant storage p = participants[userId];
      p.username = _name;
      p.password = _pass;
      p.participantAddress = _pAddress;
      p.participantType = _pType;
    }

    return userId;
  }

  function getParticipant(
    uint32 _participant_id
  ) public view returns (
    string memory __participantUsername,
    address       __participantAddress,
    string memory __participantType
  )
  {
    participant storage p = participants[_participant_id];
    return (
      p.username,
      p.participantAddress,
      p.participantType
    );
  }
  
  function addProduct(
    uint32 _ownerParticipantId,
    string calldata _modelNumber,
    string calldata _partNumber,
    string calldata _serialNumber,
    uint32 _productCost
  ) public returns (
    uint32 __productId
  )
  {
    participant storage p = participants[_ownerParticipantId];
    bytes memory encodedOwnerParticipant = abi.encodePacked(p.participantType);
    bytes32 ownerParticipantHash = keccak256(encodedOwnerParticipant);
    
    require(ownerParticipantHash == manufacturerHash, "Only Manufacturers' are allowed to add products.");

    uint32 productId = product_id++;

    {          
      product storage prod = products[productId];
      prod.modelNumber           = _modelNumber;
      prod.partNumber            = _partNumber;
      prod.serialNumber          = _serialNumber;
      prod.cost                  = _productCost;
      prod.productOwner          = p.participantAddress;
      prod.manufacturerTimeStamp = uint32(block.timestamp);
    }

    return productId;
  }

  function getProduct(
    uint32 _productId
  ) public view returns (
    string memory __modelNumber,
    string memory __partNumber,
    string memory __serialNumber,
    uint32        __cost,
    address       __productOwner,
    uint32        __manufacturerTimeStamp
  )
  {
    product storage p = products[_productId];
    return (
      p.modelNumber,
      p.partNumber,
      p.serialNumber,
      p.cost,
      p.productOwner,
      p.manufacturerTimeStamp
    );
  }

  modifier onlyOwner(uint32 _productId) {
    require(msg.sender == products[_productId].productOwner, "Not allower. You're not the owner of the product.");
    _;
  }


  bytes32 constant manufacturerHash = keccak256('Manufacturer');
  bytes32 constant supplierHash = keccak256('Supplier');
  bytes32 constant consumerHash = keccak256('Consumer');

  function newOwner(
    uint32 _user1Id,
    uint32 _user2Id,
    uint32 _productId
  ) onlyOwner(_productId) public returns(bool success)
  {
    participant memory p1 = participants[_user1Id];
    participant memory p2 = participants[_user2Id];
    uint32 ownership_id = owner_id++;

    bytes memory p1TypeEncoded = abi.encodePacked(p1.participantType);
    bytes32 p1TypeHash = keccak256(p1TypeEncoded);
    
    bytes memory p2TypeEncoded = abi.encodePacked(p2.participantType);
    bytes32 p2TypeHash = keccak256(p2TypeEncoded);
 
    if (
      (p1TypeHash == manufacturerHash && p2TypeHash == supplierHash)
      ||
      (p1TypeHash == supplierHash && p2TypeHash == supplierHash)
      ||
      (p1TypeHash == supplierHash && p2TypeHash == consumerHash)
    )
    {
      {
        ownership storage o = ownerships[ownership_id];
        o.productId = _productId;
        o.productOwner = p2.participantAddress;
        o.ownerId = _user2Id;
        o.trxTimeStamp = uint32(block.timestamp);
      }

      products[_productId].productOwner = p2.participantAddress;
      productTrack[_productId].push(ownership_id);

      emit TransferOwnership(_productId);

      return (true);
    }

    return (false);
  }

  function getProvenance(
    uint32 _productId
  ) external view returns (
    uint32[] memory __ownership_ids
  )
  {
    return productTrack[_productId];
  }

  function getOwnership(
    uint32 _regId
  ) public view returns (
    uint32 __productId,
    uint32 __ownerId,
    address __productOwner,
    uint32 __trxTimeStamp
  )
  {
    ownership memory r = ownerships[_regId];
    return (
      r.productId,
      r.ownerId,
      r.productOwner,
      r.trxTimeStamp
    );
  }

  function hash(string memory _str) private pure returns(bytes32 __hash) {
    bytes memory encoded = abi.encode(_str);
    return keccak256(encoded);
  }

  function equals(string memory _a, string memory _b) private pure returns(bool __success) {
    return hash(_a) == hash(_b);
  }

  function authenticateParticipant(
    uint32 _uid,
    string calldata _uname,
    string calldata _upass,
    string calldata _utype
  ) public view returns (bool)
  {
    participant memory p = participants[_uid];
    return equals(p.participantType, _utype)
      && equals(p.username, _uname)
      && equals(p.password, _upass);
  }
}
