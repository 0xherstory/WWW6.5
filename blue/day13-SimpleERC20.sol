// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleERC20 {
    // 定义代币名称
    string public name = "SimpleToken";

    // 代币符号，类似股票代码，例如 ETH、USDT
    string public symbol = "SIM";

    // 小数位数
    uint8 public decimals = 18;

    // 当前系统中存在的代币总数量
    uint256 public totalSupply;

    // 记录每个地址拥有多少代币
    // address → 余额
    mapping(address => uint256) public balanceOf;

    // 授权表（双层映射）
    // 例如：Alice 允许交易所最多花她 100 SIM
    mapping(address => mapping(address => uint256)) public allowance;

    // 转账: 当代币发生转移时记录一条日志
    // indexed 表示这个字段可以被区块链快速搜索
    event Transfer(address indexed from, address indexed to, uint256 value);

    // 授权: 当某个地址批准别人使用自己的代币时触发
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 构造函数：合约部署时自动执行一次
    constructor(uint256 _initialSupply) {

        // 设置代币总量
        // 因为有 decimals，所以需要乘 10^18
        // 例如：100 → 100 * 10^18
        totalSupply = _initialSupply * (10 ** uint256(decimals));

        // msg.sender 是部署合约的地址
        // 把所有初始代币都给创建者
        balanceOf[msg.sender] = totalSupply;

        // 触发一次 Transfer 事件
        // address(0) 表示“从无到有”，即新发行代币
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // 普通转账函数
    // 调用者把自己的代币发送给别人
    function transfer(address _to, uint256 _value) public returns (bool) {

        // require 是安全检查
        // 如果余额不足，交易会回滚
        require(balanceOf[msg.sender] >= _value, "Not enough balance");

        // 调用内部函数执行转账
        _transfer(msg.sender, _to, _value);

        return true;
    }

    // 授权函数
    // 允许另一个地址使用自己的代币
    function approve(address _spender, uint256 _value) public returns (bool) {

        // 在授权表中记录额度
        allowance[msg.sender][_spender] = _value;

        // 触发授权事件
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // 代付转账函数
    // 允许被授权的人从 owner 账户转出代币
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {

        // 检查被转走代币的地址余额是否足够
        require(balanceOf[_from] >= _value, "Not enough balance");

        // 检查授权额度是否足够
        require(allowance[_from][msg.sender] >= _value, "Allowance too low");

        // 使用额度后减少授权余额
        allowance[_from][msg.sender] -= _value;

        // 执行转账
        _transfer(_from, _to, _value);

        return true;
    }

    // 内部转账函数
    // internal 表示只能在合约内部调用
    function _transfer(address _from, address _to, uint256 _value) internal {

        // 防止转到空地址
        // address(0) 常被当作“销毁地址”
        require(_to != address(0), "Invalid address");

        // 从发送者余额中扣除
        balanceOf[_from] -= _value;

        // 给接收者增加余额
        balanceOf[_to] += _value;

        // 记录转账事件
        emit Transfer(_from, _to, _value);
    }
}
