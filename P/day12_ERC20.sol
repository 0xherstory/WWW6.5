// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleToken {
    string public name = "Simple Token";
    string public symbol = "STK";
    uint8 public decimals = 18;
    uint256 public totalSupply;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event TokensMinted(address indexed to, uint256 amount);

    constructor(uint256 initialSupply) {
        uint256 total = initialSupply * 10 ** uint256(decimals);
        totalSupply = total;
        

        _balances[msg.sender] = total;


        emit TokensMinted(msg.sender, total);
        emit Transfer(address(0), msg.sender, total);
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }


    function approve(address spender, uint256 amount) public returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }


    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        uint256 currentAllowance = _allowances[from][msg.sender];
        

        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        

        _allowances[from][msg.sender] = currentAllowance - amount;
        
  
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev 内部执行转账 [_transfer]
     * 包含：0地址检查、余额检查、记账逻辑
     */
    function _transfer(address from, address to, uint256 amount) internal {
        // 检查接收地址不能为0地址
        require(to != address(0), "ERC20: transfer to the zero address");
        // 检查用户余额
        require(_balances[from] >= amount, "ERC20: transfer amount exceeds balance");

        // 记账：扣除发送者金额，添加收款人金额
        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }
}