//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./MyToken.sol";

contract PreOrderToken is MyToken {

    uint256 public tokenPrice; //代币价格
    uint256 public saleStartTime; //售卖的起始时间
    uint256 public saleEndTime; //售卖的结束时间
    uint256 public minPurchase; //最小售卖额
    uint256 public maxPurchase;//最大售卖额
    uint256 public totalRaised;//总售卖的金额
    address public projectOwner; //项目创建则
    bool public finalized = false; //s会否结束
    bool private initialTransferDone = false; //是否已已经转移到合约地址中

    event TokensPurchased(address indexed buyer, uint256 etherAmount, uint256 tokenAmount); // 记录有人购买的明细
    event SaleFinalized(uint256 totalRaised, uint256 totalTokensSold);//记录总售卖数量

    constructor(  //构建初始信息，供应量，销售时常，代币价格，上限下限，创建人
        uint256 _intitialSupply,
        uint256 _tokenPrice,
        uint256 _saleDurationInSeconds,
        uint256 _minPurchase,
        uint256 _maxPurchase,
        address _projectOwner
    )
    MyToken(_intitialSupply){
        tokenPrice = _tokenPrice;
        saleStartTime = block.timestamp;
        saleEndTime = block.timestamp + _saleDurationInSeconds;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
        projectOwner = _projectOwner;
    

    _transfer(msg.sender, address(this), totalSupply);
    initialTransferDone = true;//代币已转交
}

    //检查销售是否已经开始
    function isSaleActive()public view returns(bool){
        return(!finalized && block.timestamp >= saleStartTime && block.timestamp <= saleEndTime);
    }
    //购买代币
    function buyTokens() public payable{
        require(isSaleActive(), "Sale is not active");//是否开始
        require(msg.value >= minPurchase, "Amount is below min purchase");//金额是否大于最小额度
        require(msg.value <= maxPurchase, "Amount is above max purchase");//是否小于最大额度
        uint256 tokenAmount = (msg.value * 10**uint256(decimals))/ tokenPrice;//发送的ETH转化成对应的代币数量
        require(balanceOf[address(this)] >= tokenAmount, "Not enough tokens left for sale");//请求账户余额是否足够购买
        totalRaised+= msg.value;//总销售额增加
        _transfer(address(this),msg.sender,tokenAmount); 
        emit TokensPurchased(msg.sender, msg.value, tokenAmount);
        
    }
    //销售过程中锁定相关操作
    function transfer(address _to, uint256 _value)public override returns(bool){
        if(!finalized && msg.sender != address(this) && initialTransferDone){
            require(false, "Tokens are locked until sale is finalized");
        }

        return super.transfer(_to, _value);
    }
    //结束销售
    function transferFrom(address _from, address _to, uint256 _value)public override returns(bool){
        if(!finalized && _from != address(this)){
            require(false, "Tokens are locked until sale is finalized");
        }
        return super.transferFrom(_from, _to, _value);
    }

    //创建人查看销售情况
    function finalizeSale() public payable{
        require(msg.sender == projectOwner, "Only owner can call this function");
        require(!finalized,"Sale is already finalized");
        require (block.timestamp > saleEndTime, "Sale not finished yet");
        finalized = true;
        uint256 tokensSold = totalSupply - balanceOf[address(this)];
        (bool sucess,) = projectOwner.call{value:  address(this).balance}("");
        require(sucess, "Transfer failed");
        emit SaleFinalized(totalRaised, tokensSold);
    }
    //检查销售是否结束，如果没有返回，剩余时间
    function timeRemaining() public view  returns(uint256){
        if(block.timestamp >= saleEndTime){
            return 0;
        }
        return (saleEndTime - block.timestamp);
    }
    //检查剩余的代币
    function tokensAvailable()public view returns(uint256){
        return balanceOf[address(this)];
    }

    receive() external payable{
        buyTokens();
    }
    }





