// SPDX-License-Identifier: MIT           
pragma solidity ^0.8.20;                  

contract SimpleERC20 {                    
   
    string public name = "Web3 Compass";  // 代币名称
    string public symbol = "COM";         // 代币符号
    uint8 public decimals = 18;           // 小数位数
    uint256 public totalSupply;           // 总供应量

    
    mapping(address => uint256) public balanceOf;         // 余额
    mapping(address => mapping(address => uint256)) public allowance;     // 授权

    //  事件
    event Transfer(address indexed from, address indexed to, uint256 value);   // 转账事件
    event Approval(address indexed owner, address indexed spender, uint256 value); // 授权事件

    //  构造函数 
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * (10 ** uint256(decimals));  
        balanceOf[msg.sender] = totalSupply;                       
        emit Transfer(address(0), msg.sender, totalSupply);        
    }

    // 核心功能 
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Not enough balance");  // 检查余额够不够
        _transfer(msg.sender, _to, _value);       // 执行转账
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;   // 设置授权额度
        emit Approval(msg.sender, _spender, _value); // 记录授权事件
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(balanceOf[_from] >= _value, "Not enough balance");    // 查余额
        require(allowance[_from][msg.sender] >= _value, "Allowance too low");  // 查授权额度
        allowance[_from][msg.sender] -= _value;         // 扣授权额度
        _transfer(_from, _to, _value);          // 转账
        return true;
    }

    
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0), "Invalid address");    
        balanceOf[_from] -= _value;       // 扣余额
        balanceOf[_to] += _value;       // 加余额
        emit Transfer(_from, _to, _value);     // 记录转账
    }
}