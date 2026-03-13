//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./day9-ScientificCalculator.sol";

contract Calculator{

    address public owner;
    address public scientificCalculatorAddress;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this action");
         _; 
    }

    function setScientificCalculator(address _address)public onlyOwner{
        scientificCalculatorAddress = _address;
        }
    /* ScientificCalculator 合约：就像是一个特定的功能服务。一旦部署成功，它就在区块链上拥有了一个唯一的 0x 开头的地址。
    scientificCalculatorAddress 变量：如果本Calculator合约是一台手机，那么该变量就相当于一个快捷拨号位，存储着ScientificCalculator合约地址。在手机上按下快捷拨号位就可以调用这个高级功能。
    为什么专门写一个变量来存放，而不是把地址写死在代码里？这种方式提供了合约灵活性。如果ScientificCalculator需要升级重新部署，可以直接把新地址输入变量，不需要放弃整个Calculator合约。*/

    function add(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a+b;
        return result;
    }

    function subtract(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a-b;
        return result;
    }

    function multiply(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a*b;
        return result;
    }

    function divide(uint256 a, uint256 b)public pure returns(uint256){
        require(b!= 0, "Cannot divide by zero");
        uint256 result = a/b;
        return result;
    }

    function calculatePower(uint256 base, uint256 exponent)public view returns(uint256){
        ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);
        //external call 
        uint256 result = scientificCalc.power(base, exponent);
        return result;
    }

    function calculateSquareRoot(uint256 number)public view returns (uint256){
        bytes memory data = abi.encodeWithSignature("squareRoot(uint256)", number); // 对"squareRoot(int256)" 这个字符串进行 Keccak-256 哈希运算，然后取结果的前 4 个字节；把number这个参数转换成 32 字节宽度的十六进制；最后把 4 字节指纹 和 32 字节参数 连在一起，形成一段很长的 bytes（二进制数据），存在data变量里。
        (bool success, bytes memory returnData) = scientificCalculatorAddress.staticcall(data); // .call(data)：把打包好的数据扔给那个地址。success（bool值）：如果对方合约执行成功，它就是 true；如果对方报错（revert）或地址根本没代码，它就是 false（注意：底层调用失败不会让你的合约跟着崩溃，它只会返回 false）。returnData：这是对方合约执行完逻辑的结果（二进制格式）。
        require(success, "External call failed");
        uint256 result = abi.decode(returnData, (uint256)); // 返回的returnData是uint256类型数据，但以bytes类型回传，需要解析为uint256类型并存在result变量中
        return result;
    }



}

