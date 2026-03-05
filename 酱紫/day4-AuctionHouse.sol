// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//拍卖行合约
contract AuctionHouse {

//定义核心变量
    address public owner; //所有人地址
    string public item;//拍卖物品
    uint256 public auctionEndTime; //在 Solidity 中，uint 是 uint256 的别名。也就是说，在你的 AuctionHouse 合约中写 uint public auctionEndTime; 和写 uint256 public auctionEndTime; 在编译器眼中是完全一样的。
    //注意： 使用较小的类型（如 uint8）并不总是更省 Gas。在函数内部使用 uint8 时，EVM 仍会将其补齐到 256 位进行计算，反而可能增加 Gas 消耗。只有在 struct（结构体） 中通过“紧凑打包”多个小变量时，才能有效节省存储费用。
    address private highestBidder; //最高竞价者的身份应该匿名
    uint256 private  highestBid; //最高价格
    bool public ended;  //逻辑判断开关，买卖结束点，如果ended为true，禁止用户继续出价
    mapping (address => uint256) public bids; //映射参数者的地址
    address[] public bidders; //地址数组

//构造函数：合约的初始化or出厂设置，只在部署的那一刻执行一次。constructor(参数，接收外部传进来的配置信息){逻辑代码，执行区}
//传入时间参数
    constructor(string memory _item, uint _biddingTime) {
       owner = msg.sender; //逻辑：谁部署了这个合约，谁就是这个合约的 owner（老板）。
       item = _item;
       auctionEndTime = block.timestamp + _biddingTime; //这是一个内置变量，代表当前的 Unix 时间戳（即从 1970 年到现在过了多少秒）。你可以把它理解为“现在的时间”。
    }
//拍卖功能
//external，让合同外的人访问,
//
    function bid (uint256 amount) external {




    }
}
