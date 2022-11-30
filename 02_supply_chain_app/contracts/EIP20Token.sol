// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./EIP20Interface.sol";

contract EIP20Token is EIP20Interface {

  uint256 constant private MAX_UINT256 = 2**256-1;

  mapping (address => uint256) public balances;
  mapping (address => mapping(address => uint256)) public allowed;


  // Total number of tokens
  uint256 private _totalSupply; 

  // Descriptive name (i.e. For Dummes Sample Token)
  string private _name;

  // How many decimals to use when displaying amounts
  uint8 private _decimals;

  // Short identifier for token (i.e. FDST)
  string private _symbol;

  // Create the new token and assign initial values, including initial amount
  constructor(
    uint256 _initialAmount,
    string memory _tokenName,
    uint8 _decimalUnits,
    string memory _tokenSymbol
  ) {
    balances[msg.sender] = _initialAmount;
    _totalSupply = _initialAmount;
    _name = _tokenName;
    _decimals = _decimalUnits;
    _symbol = _tokenSymbol;
  }


  function name()        override public view returns (string memory __name) {
    return _name;
  }
  function symbol()      override public view returns (string memory __symbol) {
    return _symbol;
  }
  function decimals()    override public view returns (uint8) {
    return _decimals;
  }
  function totalSupply() override public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address _owner)                                override public view returns (uint256) {
    return balances[_owner];
  }
  function transfer(address _to, uint256 _value)                    override public      returns (bool success) {
    require(balanceOf(msg.sender) >= _value, "Insufficient funds for transfer source.");
    balances[msg.sender] -= _value;
    balances[_to]        += _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }
  function transferFrom(address _from, address _to, uint256 _value) override public      returns (bool success) {
    uint256 initialAllowance = allowance(_from, msg.sender);
    require(initialAllowance >= _value, "Not allowed.");
    require(balanceOf(_from) >= _value, "Insufficient funds for transfer source");
    balances[_from] -= _value;
    balances[_to]   += _value;
    if (initialAllowance < MAX_UINT256) {
      approve(_from, msg.sender, initialAllowance - _value);
    }
    emit Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value)                 override public      returns (bool success) {
    return approve(msg.sender, _spender, _value);
  } 
  function approve(address _owner, address _spender, uint256 _value)          public      returns (bool success) {
    allowed[_owner][_spender] = _value;
    emit Approval(_owner, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) override public view returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

}
