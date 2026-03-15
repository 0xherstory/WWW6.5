// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    // 代币的初始定义
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;

    uint256 public totalSupply;
    //账户余额
    mapping(address => uint256) public balanceOf;
    //账户授权
    mapping(address => mapping(address => uint256)) public allowance;
    // 转账事件 
    event Transfer(address indexed from, address indexed to, uint256 value);
    //授权事件
    event Approval(address indexed owner, address indexed spender, uint256 value);


    constructor(uint256 _initialSupply) {//代币的初始信息写死

        totalSupply = _initialSupply * 10 ** decimals;

        balanceOf[msg.sender] = totalSupply;

        emit Transfer(address(0), msg.sender, totalSupply);//广播初始信息

    }

    //是否转账成功，执行
    function transfer(address _to, uint256 _value) public virtual returns (bool) {

        _transfer(msg.sender, _to, _value);

        return true;

    }

    // 给授权额度，广播，执行
    function approve(address _spender, uint256 _value) public returns (bool) {

        allowance[msg.sender][_spender] = _value; //给授权额度

        emit Approval(msg.sender, _spender, _value); //广播

        return true;

    }

    //转账，请求转账额度是否在授权额度内，是，
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool) {

        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded"); //检查授权额度是否大于提取金额

        allowance[_from][msg.sender] -= _value; //授权金额扣除

        _transfer(_from, _to, _value); //执行

        return true;

    }


    function _transfer(address _from, address _to, uint256 _value) internal {

        require(_to != address(0), "Invalid address");//检查地址

        require(balanceOf[_from] >= _value, "Insufficient balance");//检查余额是否>提取金额

        balanceOf[_from] -= _value; //转账人扣除金额

        balanceOf[_to] += _value;//接收人增加金额

        emit Transfer(_from, _to, _value);//广告博通报

    }

}