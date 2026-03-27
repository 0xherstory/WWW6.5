// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
contract MiniDeFiBank {

    struct User {
        uint256 depositBalance;    
        uint256 collateralBalance; 
        uint256 debt;              
        uint256 lastInterestTime;  
    }

    mapping(address => User) public users;
    uint256 public poolLiquidity; 
    
    uint256 public constant INTEREST_RATE_PER_SECOND = 1; 
    uint256 public constant COLLATERAL_RATIO = 80;        

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);
    event Borrowed(address indexed user, uint256 amount);
    event Repaid(address indexed user, uint256 amount);


    function deposit() external payable {
        require(msg.value > 0, "Amount must > 0");
        users[msg.sender].depositBalance += msg.value;
        poolLiquidity += msg.value;
        emit Deposited(msg.sender, msg.value);
    }


    function withdraw(uint256 _amount) external {
        require(users[msg.sender].depositBalance >= _amount, "Exceeds balance");
        
        users[msg.sender].depositBalance -= _amount;
        poolLiquidity -= _amount;
        
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
        emit Withdrawn(msg.sender, _amount);
    }


    function lockCollateral() external payable {
        require(msg.value > 0, "Need collateral");
        users[msg.sender].collateralBalance += msg.value;
    }


    function _calculateInterest(address _user) internal {
        User storage user = users[_user];
        if (user.debt > 0) {
            uint256 timeElapsed = block.timestamp - user.lastInterestTime;
            uint256 interest = timeElapsed * INTEREST_RATE_PER_SECOND;
            user.debt += interest;
        }
        user.lastInterestTime = block.timestamp;
    }


    function borrow(uint256 _amount) external {
        _calculateInterest(msg.sender);

        require(poolLiquidity >= _amount, "Insufficient pool liquidity");
        uint256 maxBorrow = (users[msg.sender].collateralBalance * COLLATERAL_RATIO) / 100;
        require(users[msg.sender].debt + _amount <= maxBorrow, "Exceeds collateral limit");
        users[msg.sender].debt += _amount;
        poolLiquidity -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Borrow transfer failed");
        emit Borrowed(msg.sender, _amount);
    }

    function repay() external payable {
        require(msg.value > 0, "Must send ETH to repay");
        _calculateInterest(msg.sender);
        
        User storage user = users[msg.sender];
        require(user.debt > 0, "No debt to repay");

        uint256 amountToRepay = msg.value;
        uint256 refund = 0;


        if (amountToRepay > user.debt) {
            refund = amountToRepay - user.debt;
            amountToRepay = user.debt;
        }

        user.debt -= amountToRepay;
        poolLiquidity += amountToRepay;

        if (refund > 0) {
            (bool success, ) = payable(msg.sender).call{value: refund}("");
            require(success, "Refund failed");
        }
        
        emit Repaid(msg.sender, amountToRepay);
    }
    function withdrawCollateral(uint256 _amount) external {
        _calculateInterest(msg.sender);
        User storage user = users[msg.sender];
        
        require(user.collateralBalance >= _amount, "Insufficient collateral");
        

        uint256 remainingCollateral = user.collateralBalance - _amount;
        uint256 maxBorrowAllowed = (remainingCollateral * COLLATERAL_RATIO) / 100;
        require(user.debt <= maxBorrowAllowed, "Cannot withdraw: Debt too high");

        user.collateralBalance -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Transfer failed");
    }
    function getAccountInfo(address _user) external view returns (uint256, uint256, uint256) {
        return (users[_user].depositBalance, users[_user].collateralBalance, users[_user].debt);
    }
}