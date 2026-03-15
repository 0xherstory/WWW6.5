// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleERC20 {
    string public name = "SimpleToken";
    string public symbol = "SIM";//简短的交易代码
    uint8 public decimals = 18;//decimals:定义可分割程度
    uint256 public totalSupply;//追踪当前存在的代币总数。接下来在合约部署时设置

    mapping(address => uint256) public balanceOf;//每个地址有多少个代币
    mapping(address => mapping(address => uint256)) public allowance;
//嵌套映射又来了：追踪谁被允许代表谁花费了多少代币。
//这是 ERC-20 的核心功能：允许其他人（如 DApp 或智能合约）移动你的代币，但前提是你必须首先批准。
//所以下面有一个event Approval：有人授权另一个地址代表他们花费代币时，这个事件就会触发。
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);


    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        //设定即将铸造的代币总数，记住ERC20代币使用小数位来确保精确度，所以要理解这个表示
        balanceOf[msg.sender] = totalSupply;
        //最初的100%代币供应被分配给部署合约的人。
        emit Transfer(address(0),msg.sender, totalSupply);
        //发出一个transfer事件并非表示转账，而是表示代币已被“铸造”。address(0)是一种特殊说法：代币并非来自其他用户，而是被凭空创造。
    }

    function _transfer(address _from, address _to, uint256 _value) internal{
        require(_to != address(0), "Invalid address");
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer (_from, _to, _value);
    }
//核心逻辑抽离：把 transfer()/transferFrom() 中重复的「余额变更」逻辑放到 _transfer() 里，避免代码重复
     function transfer(address _to, uint256 _value) public virtual returns (bool) {
        require(balanceOf[msg.sender] >= _value, "Not enough balance");
        _transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool) {
        require(balanceOf[_from] >= _value, "Not enough balance");
        require(allowance[_from][msg.sender] >= _value, "Allowance too low");

        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }


    
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }


}