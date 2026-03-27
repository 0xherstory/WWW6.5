// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract SimpleAMM {
    IERC20 public immutable tokenA;
    IERC20 public immutable tokenB;

    uint256 public reserveA;
    uint256 public reserveB;

    uint256 public totalSupply; 
    mapping(address => uint256) public balanceOf; 

    event Mint(address indexed sender, uint256 amountA, uint256 amountB, uint256 liquidity);
    event Burn(address indexed sender, uint256 amountA, uint256 amountB, uint256 liquidity);
    event Swap(address indexed sender, uint256 amountIn, uint256 amountOut, bool isAtoB);

    constructor(address _tokenA, address _tokenB) {
        tokenA = IERC20(_tokenA);
        tokenB = IERC20(_tokenB);
    }


    function _sqrt(uint256 y) internal pure returns (uint256 z) {
        if (y > 3) {
            z = y;
            uint256 x = y / 2 + 1;
            while (x < z) {
                z = x;
                x = (y / x + x) / 2;
            }
        } else if (y != 0) {
            z = 1;
        }
    }

    function _min(uint256 x, uint256 y) internal pure returns (uint256) {
        return x < y ? x : y;
    }

    function addLiquidity(uint256 _amountA, uint256 _amountB) external returns (uint256 liquidity) {
        tokenA.transferFrom(msg.sender, address(this), _amountA);
        tokenB.transferFrom(msg.sender, address(this), _amountB);

        if (totalSupply == 0) {

            liquidity = _sqrt(_amountA * _amountB);
        } else {

            liquidity = _min(
                (_amountA * totalSupply) / reserveA,
                (_amountB * totalSupply) / reserveB
            );
        }

        require(liquidity > 0, "Liquidity must > 0");
        
        balanceOf[msg.sender] += liquidity;
        totalSupply += liquidity;
        
        reserveA = tokenA.balanceOf(address(this));
        reserveB = tokenB.balanceOf(address(this));

        emit Mint(msg.sender, _amountA, _amountB, liquidity);
    }


    function removeLiquidity(uint256 _liquidity) external returns (uint256 amountA, uint256 amountB) {
        require(balanceOf[msg.sender] >= _liquidity, "Insufficient LP balance");


        amountA = (_liquidity * reserveA) / totalSupply;
        amountB = (_liquidity * reserveB) / totalSupply;

        balanceOf[msg.sender] -= _liquidity;
        totalSupply -= _liquidity;

        tokenA.transfer(msg.sender, amountA);
        tokenB.transfer(msg.sender, amountB);

        reserveA = tokenA.balanceOf(address(this));
        reserveB = tokenB.balanceOf(address(this));

        emit Burn(msg.sender, amountA, amountB, _liquidity);
    }

    function getAmountOut(uint256 _amountIn, bool _isAtoB) public view returns (uint256) {
        (uint256 resIn, uint256 resOut) = _isAtoB ? (reserveA, reserveB) : (reserveB, reserveA);
        require(_amountIn > 0, "Amount In must > 0");
        require(resIn > 0 && resOut > 0, "Pool is empty");

        uint256 amountInWithFee = _amountIn * 997; 
        uint256 numerator = amountInWithFee * resOut;
        uint256 denominator = (resIn * 1000) + amountInWithFee;
        
        return numerator / denominator;
    }

    function swap(uint256 _amountIn, bool _isAtoB, uint256 _minAmountOut) external returns (uint256 amountOut) {
        amountOut = getAmountOut(_amountIn, _isAtoB);
        require(amountOut >= _minAmountOut, "Slippage protection: price changed");

        if (_isAtoB) {
            tokenA.transferFrom(msg.sender, address(this), _amountIn);
            tokenB.transfer(msg.sender, amountOut);
        } else {
            tokenB.transferFrom(msg.sender, address(this), _amountIn);
            tokenA.transfer(msg.sender, amountOut);
        }

        reserveA = tokenA.balanceOf(address(this));
        reserveB = tokenB.balanceOf(address(this));

        emit Swap(msg.sender, _amountIn, amountOut, _isAtoB);
    }
}