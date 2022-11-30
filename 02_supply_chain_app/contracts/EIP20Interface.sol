// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

abstract contract EIP20Interface {

  function name()        virtual public view returns (string memory __name);
  function symbol()      virtual public view returns (string memory __symbol);
  function decimals()    virtual public view returns (uint8);
  function totalSupply() virtual public view returns (uint256);

  function balanceOf(address _owner)                                virtual public view returns (uint256);
  function transfer(address _to, uint256 _value)                    virtual public      returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) virtual public      returns (bool success);

  function approve(address _spender, uint256 _value)   virtual public      returns (bool success); 
  function allowance(address _owner, address _spender) virtual public view returns (uint256 remaining);

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}
