// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./day12-SimpleERC20.sol";
contract SimplifiedTokenSale is SimpleERC20{

    uint256 public tokenPrice;
    uint256 public saleStartTime;
    uint256 public saleEndTime;
    uint256 public minPurchase;
    uint256 public maxPurchase;
    uint256 public totalRaised;//目前为止接收的 ETH总额
    address public projectOwner;//发售结束后接收 ETH 的钱包地址
    bool public finalized = false;//发售是否已经正式关闭
    bool private initialTransferDone = false;//用于确保合约在锁定转账前已收到所有代币

    event TokenPurchased(address indexed buyer, uint256 etherAmount, uint256 tokenAmount);
    event SaleFinalized(uint256 totalRaised, uint256 totalTokensSold);

    constructor (
        uint256 _initialSupply,
        uint256 _tokenPrice,
        uint256 _saleDurationInSeconds,
        uint256 _minPurchase,
        uint256 _maxPurchase,
        address _projectOwner
    ) SimpleERC20(_initialSupply){
        tokenPrice = _tokenPrice;
        saleStartTime = block.timestamp;
        saleEndTime = block.timestamp + _saleDurationInSeconds;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
        projectOwner = _projectOwner;

        _transfer(msg.sender, address(this), totalSupply);
        initialTransferDone = true;
    }

    

    

    //检查发售是否正在进行：
   function isSaleActive() public view returns (bool) {
    // 直接返回表达式的布尔结果，覆盖所有代码路径
       return (!finalized && block.timestamp >= saleStartTime && block.timestamp <= saleEndTime);
    }



    //用户在发售期间购买代币的函数：
    function buyTokens() public payable{
        require(isSaleActive(), "Sale is not active");
        require(msg.value >= minPurchase, "Amount is below minimum purchase");
        require(msg.value <= maxPurchase, "Amount exceeds maximum purchase");

        uint256 tokenAmount = (msg.value * 10**uint256(decimals)) / tokenPrice;
        require (balanceOf[address(this)] >= tokenAmount, "Not enough tokens left for sale");

        totalRaised += msg.value;
        _transfer(address(this), msg.sender, tokenAmount);
        emit TokenPurchased(msg.sender, msg.value, tokenAmount);
    }

    function transfer(address _to, uint256 _value) public override returns (bool) {
        if (!finalized && msg.sender != address(this) && initialTransferDone) {
        require(false, "Tokens are locked until sale is finalized");
        }
    return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {
        if (!finalized && _from != address(this)) {
        require(false, "Tokens are locked until sale is finalized");
        }
    return super.transferFrom(_from, _to, _value);
    }

    //结束代币发售：
    function finalizeSale() public payable {
        require(msg.sender == projectOwner, "Only Owner can call the function");
        require(!finalized, "Sale already finalized");
        require(block.timestamp > saleEndTime, "Sale not finished yet");

        finalized = true;
        uint256 tokensSold = totalSupply - balanceOf[address(this)];

        (bool success, ) = projectOwner.call{value: address(this).balance}("");
        require(success, "Transfer to project owner failed");

        emit SaleFinalized(totalRaised, tokensSold);
    }

    function timeRemaining() public view  returns(uint256){
        if(block.timestamp >= saleEndTime){
            return 0;
        }
        return (saleEndTime - block.timestamp);
    }

    function tokensAvailable()public view returns(uint256){
        return balanceOf[address(this)];
    }

    receive() external payable{
        buyTokens();
    }

}