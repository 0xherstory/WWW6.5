//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

/** 
 * @title TimeStamp
 * @dev 构建完整的拍卖系统,学习时间戳
 * 初始如何设计？？假设是c 如何实现？？
 */
contract TimeStamp{
    // 区块时间戳 数据
    uint public auctionEndTime;
    address public owner;
    string public item;


    //======1. 初始化数据池 持有者 item是啥？可能是价值 还有 投票结束时间======
    /**
     *  1. 新的 constructor？和function的区别
     *  constructor是用于初始化合约的函数，只能在合约创建时调用一次 不能之后被任何人再调用
     *  function是用于定义合约的函数，可以在合约创建后多次调用
     *  2. msg.sender 是哪来的？？
     * msg.sender 是 Solidity 内置全局变量===》调用者的地址
     * 
     */
    constructor(string memory _item, uint _biddingTime){
        owner = msg.sender;
        item = _item;
        auctionEndTime = block.timestamp + _biddingTime;
    }

    //======2. 拍卖过程======
    /**
     * 1. 新的变量需要在最初声明吗？中间也行吗？
     * olidity 里，状态变量（存在链上的变量）可以在合约里任意位置声明，不强制在开头。
     * 2. 为什么是private？什么作用呢？
     *  隐藏信息 防止其它合约直接访问 接口不暴露
     * private：只有当前合约内部能读写，子合约和外部都无法直接访问
     * 3. address是什么类型？
     * address 是 Solidity 的内置类型，表示一个 20 字节的以太坊地址（如 0x1234...）。
        用来存钱包地址、合约地址。
        msg.sender 的类型就是 address
     * 
     */
    address private highestBidder;
    uint private highestBid;


    //======3.1 出价过程======
    /**
     * 如何设计？？ 比如当前出价传递值，并且如果大于最高出价，则修改结构体，新合约者，新价格，新时间吗
     */
    function bid() external payable{
        require(block.timestamp < auctionEndTime, "Auction already ended");
        require(msg.value > highestBid, "There already is a higher bid");
        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    //======3.2 获取最高出价======
    /**
     * 又来了，只需要查看不需要付gas的view函数
     */
    function getHighestBid() external view returns (address, uint){
        return (highestBidder, highestBid);
    }


    //======3. 拍卖结束======
    bool public ended;
    /** 
     * 1. 这里为什么有个external？
     * external 表示该函数只能从合约外部调用（用户或其他合约），不能在合约内部用 endAuction() 这种方式调用
     * 所以所有function函数我都可以加external，在remix部署的时候调用吗？
     * 2. require 怎么用？？有点像判断语句加打印结合体，如果前三各require均不满足，则才是真正结束了
     * require(条件, "错误信息")：
     * 若条件为 true：继续执行后面的代码。
     * 若条件为 false：立刻回滚这笔交易，并消耗的 gas 会退回（更准确说：整笔交易不生效），同时可带上你写的「错误信息」方便调试。
     * 可以理解为：断言 + 失败时终止并报错
    */
    function endAuction() external{
        require(!ended, "Auction already ended");
        require(block.timestamp >= auctionEndTime, "Auction not yet ended");
        require(msg.sender == owner, "Only owner can end");

        ended = true;
    }


}