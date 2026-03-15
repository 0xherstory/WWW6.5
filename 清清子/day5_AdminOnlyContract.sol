// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdminOnly {
    // 设置变量
    address public owner;
    uint256 public treasureAmount;
    mapping(address => uint256) public withdrawalAllowance;
    mapping(address => bool) public hasWithdrawn;
    
    // 设置合约拥有者
    constructor() {
        owner = msg.sender;
    }
    
    // 通过修饰符实现可复用的访问控制
    modifier onlyOwner() {
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        _;
    }
    
    /* 引入了“宝物”，用一个 `uint256` 类型的变量存储。

只有拥有者可以调用 `addTreasure()` 函数。当函数被调用时，宝箱中的数量会增加指定的数额。

`onlyOwner` 修饰符确保没有随便其Ta人可以潜入并添加（或假装添加）宝物。*/
    function addTreasure(uint256 amount) public onlyOwner {
        treasureAmount += amount;
    }
    


    /*使用一个 `mapping` （映射）来记录每个地址被允许提取的数量。

在批准前，先检查宝箱中是否有足够的宝物来覆盖提取数量。

这个逻辑的流程是：
拥有者为某个地址设置提取额度；
那个地址之后可以尝试取宝，但前提是已经被批准。

这就像银行经理给你一张写有额度的取款单。*/
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // 实际的取宝过程
    function withdrawTreasure(uint256 amount) public {

        if(msg.sender == owner){
            //情况一：拥有者自己取宝.可以提取任意数量的宝物，只要宝箱里足够。不检查Ta的额度，也不追踪Ta的提取记录，因为拥有者本身就有最高权限。
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            treasureAmount-= amount;

            return;
        }
        uint256 allowance = withdrawalAllowance[msg.sender];//情况二：普通用户取宝.如果任意条件不满足，函数将立即终止执行。用户只能提取一次，且必须经过拥有者的批准。
        
        // Check if user has an allowance and hasn't withdrawn yet
        require(allowance > 0, "You don't have any treasure allowance");
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        require(allowance >= amount, "Cannot withdraw more than you are allowed"); // condition to check if user is withdrawing more than allowed
        
        // 完成取宝操作.- 将用户标记为“已提取”；从宝箱中减去被批准的提取数量；将该用户的提取额度重置为零，防止重复提取。
        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // Only the owner can reset someone's withdrawal status.重置用户的提取状态,使该用户能够再次进行取宝。
    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }
    
    // Only the owner can transfer ownership.转移合约拥有权.函数中还加入了一个快速检查，防止新地址是空的或无效的。
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;//一旦执行后，新拥有者将获得完全控制权:包括添加宝物、批准用户、再次转移拥有权。
    }
    
    //查看宝箱信息（仅限拥有者）.它被标记为 view（仅查看，不修改数据），并受 onlyOwner 保护，确保只有拥有者才能调用。
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        return treasureAmount;
    }
}