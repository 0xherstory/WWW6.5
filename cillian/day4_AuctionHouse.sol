//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract AuctionHouse {
    
    address public owner; //发起人地址
    string public item; //拍卖物品
    uint public auctionEndTime; //拍卖结束时间
    address[] public bidders; //竞拍人列表
    mapping(address => uint) public bids; //竞拍人对应竞拍价
    uint private highestBid; //最高竞拍价
    address private highestBidder; //最高竞拍价者
    bool public ended; //是否结束，初始默认值为0（false）

    //构造函数，只在代码提交时运行一次，在这里我们生成发起人、拍卖物品、拍卖时间
    constructor(string memory _item, uint _biddingtime) {
        owner = msg.sender; //msg.sender是solidity里的全局变量，可以获取调用者地址
        item = _item;
        auctionEndTime = block.timestamp + _biddingtime; //block.timestamp是solidity里的全局变量，可以获取时间（秒）
    }

    //竞拍者出价
    function bid(uint amount) external { //external是solidity里的可见性修饰符，声明此函数只供外部使用，不像public要把参数复制到内存（memory），因此比较节省gas
        //满足竞拍未结束
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        //满足竞拍价高于0
        require(amount > 0, "Bid amount must be more than zero.");
        //满足竞拍者此次竞拍价高于之前出价
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");
        //满足以上条件，可以录入竞拍价bids[msg.sender]
        
        //要先检验竞拍人是否存在于已有列表中，若不存在则加进去。因为数组只能用索引数字来访问并且不能越界，所以这里我们无法用bidders[]来判断，就用bids[msg.sender]竞拍价是否为0来间接判断
        if(bids[msg.sender] == 0){  //在mapping中，无论key是否存在，value都有一个默认值，unit类型的默认值为0
            bidders.push(msg.sender); 
        }

        bids[msg.sender] = amount;

        //判断此次竞拍价是否最高
        if(amount > highestBid){
            highestBid = amount;
            highestBidder = msg.sender;
        }        
    }

        //时间到了结束拍卖
        function endAuction() external{
            //满足时间未到
            require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
            //满足拍卖未结束
            require(!ended, "Auction has already concluded.");
            ended = true;
        }

        //查看竞拍者列表
        function getBidders() external view returns(address[] memory){
            return bidders;
        }

        //查看最高价和最高价竞拍者
        function getWinner() external view returns(uint, address){
            //满足拍卖结束了
            require(ended, "Auction hasn't ended yet.");
            return(highestBid, highestBidder);
        }

}