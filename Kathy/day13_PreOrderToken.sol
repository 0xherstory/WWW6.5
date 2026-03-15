// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract PreOderToken is MyToken {
    uint256 public tokenPrice;
    uint256 public saleStartTime;
    uint256 public saleEndTime;
    uint256 public minPurchse;
    uint256 public macPurchase;
    uint256 public totalRaised;
    address public projectOwner;
    bool public  finalized = false;
    bool private initialTransferDone = false;

    event TokensPurchased(address indexed buyer, uin256 etherAmount, uint256 tokenAmount);
    event SaleFinalized(uint256 totalRaised, uint256 totalTokensSold);

    constructor(
        uint256 _initialSupply,
        uint256 _tokenPrice,
        uint256 _saleDurationInSeconds,
        uint256 _minPurchase,
        uint256 _maxPurchase,
        address _projectOwner
    ) SumpleERC20(_initialSupply) {
        tokenPrice = _tokenPrice;
        saleStarTime = block.timestamp;
        saleEndTime = block.timestamp + _saleDurationInSeconds;
        minPurchase = _minPurchase;
        maxPurchase = _maxPurchase;
        projectOwner = _projectOwner;

        // transfer all the tokens to this contract
        _transfer(msg.sender, address(this), totalSupply);

        initialTransferDone = true;
    }

    function isSaleActive() public view returns (book) {
        return (!finalized && block,timestamp >= saleStartTime && block.timestamp <= saleEndTime);
    }

    function buyTokens() public payable {
        require(isSaleActive(), "Sale is not active.");
        require(msg.value >= minPurchase, "Amount is below minimum purchase.");
        require(msg.value <= maxPurchase, "Amount exeeds maxium purchase.");

        uint256 tokenAmount = (msg.value * 10**uint256(decimals)) / tokenPrice;
        require(balanceOf[address(this)] >= tokenAmount, "Not enough tokens left for sale.");

        totalRaised += msg.value;
        _transfer(address(this), msg.sender, tokenAmount);
        emit TokensPurchased(msg.sender, msg.value, tokenAmount);
    }

    function transfer(address _to, uint256 _value) public override returns (bool) {
        if(!finalized && msg.sender != address(this) && initialTransferDone) {
            require(false, "Tokens are locked until sale is finalized.");
        }
        return  super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {
        if(!finalized && _from != address(this)) {
            require(false, "Tokens are locked until sale is finalized.");
        }
        return super.transferFrom(_from, _to, _value);
    }

    function finalizeSale() public payable {
        require(msg.sender == projectOwner, "Only Owner can call the function.");
        require(block.timestamp > saleEndTime, "Sale not finished yet.");

        finalized = true;
        uint256 tokenSold = totalSupply - balanceOf[address(this)];

        (bool success, ) = projectOwner.call{value: address(this).balance}("");
        require(success, "Transfer to project owner failed.");

        emit SaleFinalized(totalRaised, tokensSold);
    }

    function timeRemaining() public view returns (uint256) {
        if (block.timestamp >= saleEndTime) {
            return 0;
        }
        return  saleEndTime - block.timestamp;
    }

    receive() external payable { 
        buyTokens();
    }
}
