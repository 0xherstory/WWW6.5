// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//拍卖行合约
contract AuctionHouse {

// 1. 定义核心全局变量

    address public owner; //所有人地址
    string public item;//拍卖物品
    uint256 public auctionEndTime; //在 Solidity 中，uint 是 uint256 的别名。也就是说，在你的 AuctionHouse 合约中写 uint public auctionEndTime; 和写 uint256 public auctionEndTime; 在编译器眼中是完全一样的。
    //注意： 使用较小的类型（如 uint8）并不总是更省 Gas。在函数内部使用 uint8 时，EVM 仍会将其补齐到 256 位进行计算，反而可能增加 Gas 消耗。只有在 struct（结构体） 中通过“紧凑打包”多个小变量时，才能有效节省存储费用。
    address private highestBidder; //最高竞价者的身份应该匿名
    uint256 private  highestBid; //最高价格
    bool public ended;  //逻辑判断开关，买卖结束点，如果ended为true，禁止用户继续出价
    mapping (address => uint256) public bids; //映射：通过地址查金额
    address[] public bidders; //数组：记录所有出价人的地址列表

// 2. 构造函数：合约的初始化or出厂设置，只在部署的那一刻执行一次。constructor(参数，接收外部传进来的配置信息){逻辑代码，执行区}

    constructor(string memory _item, uint _biddingTime) {
       owner = msg.sender; //谁部署了这个合约，谁就是这个合约的 owner（老板）。
       item = _item;
       auctionEndTime = block.timestamp + _biddingTime; //这是一个内置变量，代表当前的 Unix 时间戳（即从 1970 年到现在过了多少秒）。你可以把它理解为“现在的时间”。_biddingTime，竞价的时间
    }

// 3. 拍卖功能与限制要求
//  external，让合同外的人访问
//  *与实际金钱有关的功能需要认真检查

//  个人理解应该要实现的完整拍卖功能逻辑：
//  - 不同地址的拍卖者将拍卖额增加，如果出价金额较低，就拒绝出价。（√）
//  - 出现拍卖行为后,拍卖等待时间延后，直到拍卖时间截止则完成，（？）
//  - 拍卖的物品所有权转移到最高竞价者的人身上，完成公布和货币金额的转移。（？）

    function bid (uint256 amount) external {
        require( block.timestamp < auctionEndTime, " Auction time has already ended."); //拍卖deadline，判断要求当前时间不超过设定的拍卖时间，如果超过了就代表拍卖结束了。
        require( amount > 0, "bid amount must greater than 0" );//拍卖额大于零
        require( amount > bids[msg.sender], "Bid must be higher than your previews bid"); //[] 是查询动作，是在“翻开账本的某一页”。去 bids 账本里，把 msg.sender 这个人的竞价翻出来进行比较。
        
    //新面孔登记
    if (bids[msg.sender] == 0 ) {
        bidders.push(msg.sender);
    } 

    // 操作的账本对应的出价金额，
    bids[msg.sender] = amount;

    //*更新“全场最高价”，增量逻辑
    if (amount > highestBid) {
        highestBid = amount;
        highestBidder = msg.sender;
        }
    }

    // 终止拍卖
    // external: 声明该函数只能由外部（如钱包、前端）调用，省 Gas 且安全
    function endAuction () external {
        // 检查：当前区块链的时间戳是否已经大于或等于我们设定的结束时间
        // 如果不满足，报错并提示 "Auction hasn't ended yet."
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        
        // 检查：ended 变量是否为 false（!ended 表示“非结束状态”）
        // 作用：防止有人重复调用这个函数（即防止“双重结束”）
        require(!ended, "Auction end already called.");

        // 状态变更：将开关设为 true，标记拍卖正式关闭
        ended = true;
    }

    // 查看最终赢家
    // view: 声明该函数只读，不修改区块链上的任何数据，调用它不需要花手续费（Gas）
    // returns (address, uint): 声明该函数会返回两个值：赢家的地址和他的最高出价
    function getWinner() external view returns (address, uint) {
        // 检查：只有在拍卖确实结束后（ended 为 true），才能查看赢家
        // 逻辑：防止拍卖中途数据泄露或被过早引用
        require(ended, "Auction has not ended yet.");

        // 返回我们在 bid 函数中实时更新好的那两个全局变量
        return (highestBidder, highestBid);
    }

    // 获取所有参与者名单
    // returns (address[] memory): 返回一个地址数组，“memory”表示这个数组是临时生成的
    function getAllBidders() external view returns (address[] memory) {
        // 直接返回我们之前定义的 bidders 数组
        // 前端通常用这个函数来展示“参与者列表”
        return bidders;
    }

    

}

// 本集案例YouTube学习链接：https://www.youtube.com/watch?v=OI9x4G6Tu-k&list=PL3gCWoU4wyU35lrmNNrQpk_-UIlmmco6M

// gemini评论：⚠️ 一个需要注意的“坑”：增量 vs 总额
// 你注释里提到了**“增量逻辑”**，在智能合约开发中，这里有一个非常微妙的区别：
// 如果这是单纯的“报数”：用户调用 bid(100)，那么 bids[msg.sender] 变成了 100。
// 如果涉及到“真金白银”发送 ETH, 如果用户之前已经投了 80，现在想加到 100，他这次调用函数时应该多转 20 块钱还是重新转 100 块钱？
// 在你目前的逻辑中，amount 是直接覆盖的。如果用户发送的是真币（msg.value），你通常需要写成 bids[msg.sender] += msg.value;。
