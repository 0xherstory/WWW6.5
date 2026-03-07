// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

// 带管理员权限的ERC20代币合约（匹配contract-5需求）
contract AdminToken {
    // 代币基础信息（ERC20标准）
    string public name = "AdminToken";      // 代币名称
    string public symbol = "ATK";           // 代币符号
    uint8 public decimals = 18;             // 小数位数（行业标准18）
    uint256 public totalSupply;             // 总发行量

    // 权限控制核心变量
    address public admin;                   // 管理员地址（部署者）
    bool public paused;                     // 合约暂停开关

    // 余额&授权映射
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    // 事件（ERC20标准+自定义）
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value); // 增发事件
    event Pause(bool indexed status);               // 暂停事件

    // ========== 核心：admin only 权限修饰器 ==========
    // 修饰器：仅管理员能调用
    modifier onlyAdmin() {
        require(msg.sender == admin, "Admin only"); // 非管理员调用会报错
        _; // 执行被修饰的函数逻辑
    }

    // 修饰器：合约未暂停才能调用
    modifier notPaused() {
        require(!paused, "Contract paused");
        _;
    }

    // ========== 构造函数（部署时执行） ==========
    constructor(uint256 _initialSupply) {
        admin = msg.sender; // 部署合约的账户 = 管理员
        // 初始化总发行量（按18位小数放大，符合ERC20标准）
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        balanceOf[admin] = totalSupply; // 管理员拥有全部代币
    }

    // ========== 普通用户功能（带暂停控制） ==========
    // 转账：合约未暂停才能用
    function transfer(address _to, uint256 _value) public notPaused returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // 余额足够
        require(_to != address(0), "Invalid recipient address");         // 接收地址有效

        balanceOf[msg.sender] -= _value; // 转出者余额减少
        balanceOf[_to] += _value;        // 接收者余额增加

        emit Transfer(msg.sender, _to, _value); // 触发转账事件
        return true;
    }

    // 授权：允许他人操作自己的代币，合约未暂停才能用
    function approve(address _spender, uint256 _value) public notPaused returns (bool success) {
        require(_spender != address(0), "Invalid spender address"); // 授权地址有效

        allowance[msg.sender][_spender] = _value; // 记录授权额度
        emit Approval(msg.sender, _spender, _value); // 触发授权事件
        return true;
    }

    // 代转账：用授权额度转账，合约未暂停才能用
    function transferFrom(address _from, address _to, uint256 _value) public notPaused returns (bool success) {
        require(balanceOf[_from] >= _value, "Insufficient balance");       // 转出者余额足够
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded"); // 授权额度足够
        require(_to != address(0), "Invalid recipient address");           // 接收地址有效

        balanceOf[_from] -= _value; // 转出者余额减少
        balanceOf[_to] += _value;   // 接收者余额增加
        allowance[_from][msg.sender] -= _value; // 扣减授权额度

        emit Transfer(_from, _to, _value); // 触发转账事件
        return true;
    }

    // ========== 管理员专属功能（admin only） ==========
    // 增发代币：仅管理员能调用，合约未暂停才能用
    function mint(address _to, uint256 _value) public onlyAdmin notPaused returns (bool success) {
        require(_to != address(0), "Invalid recipient address"); // 接收地址有效
        uint256 mintAmount = _value * (10 ** uint256(decimals)); // 按小数位放大

        totalSupply += mintAmount; // 总发行量增加
        balanceOf[_to] += mintAmount; // 接收者余额增加

        emit Mint(_to, mintAmount); // 触发增发事件
        emit Transfer(address(0), _to, mintAmount); // 零地址转账=增发（ERC20标准）
        return true;
    }

    // 暂停/恢复合约：仅管理员能调用
    function setPause(bool _status) public onlyAdmin returns (bool success) {
        paused = _status; // 修改暂停状态
        emit Pause(_status); // 触发暂停事件
        return true;
    }

    // 更换管理员：仅当前管理员能调用
    function transferAdmin(address _newAdmin) public onlyAdmin returns (bool success) {
        require(_newAdmin != address(0), "Invalid admin address"); // 新管理员地址有效
        admin = _newAdmin; // 更换管理员
        return true;
    }
}