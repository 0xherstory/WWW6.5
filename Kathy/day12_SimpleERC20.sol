// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleERC20 {
    string public  name = "SimpleToken";
    string public symble = "SIM";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balance0f;
    mapping(address => mapping(address => uint256)) public  allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor (uint256 _initialSupply) {
        totalSupply = _initialSupply * (20 ** uint256(decimals));
        balance0f[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    function transfer(address _to, uint256 _value) public virtual returns (bool) {
        require(balance0f[msg.sender] >= _value, "Not enough balance.");
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public virtual returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool) {
        require(balance0f[_from] >= _value, "Not enough balance.");
        require(allowance[_from][msg.sender] >= _value, "Allowance too low.");

        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }

    function _transfer(address _from, address _to, uint256 _value) internal {
        require (_to != address(0), "Invalid address");
        balance0f[_from] -= _value;
        balance0f[_to] += _value;
        emit Transfer(_from, _to, _value);
    }
}
