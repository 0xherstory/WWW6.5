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

    //为什么这里mutability用view，而非pure？因为该函数需要读取scientificCalculatorAddress状态变量。

    /*第一个 ScientificCalculator 是合约名，也是类型说明（type）。
    在 Solidity 中，当你定义了一个 contract ScientificCalculator，你不仅仅是在写一段逻辑，你实际上是在定义一种新的数据结构（New Data Type）。
    就像 uint256 告诉编译器“这个变量是一个 256 位的正整数”一样，ScientificCalculator 这个类型告诉编译器：“scientificCalc这个自定义的局部变量包含/可调用 power 和 squareRoot 这两个函数，并且它们接收特定的参数。”
    如果没有第一个ScientificCalculator，编译器会问：“scientificCalc 是什么类型的变量？我不知道该给它分配多大的处理逻辑。”

    第二个 ScientificCalculator 是合约名，也是显示转换函数。
    address 类型是一个“低级”类型，它只包含地址数值。ScientificCalculator 类型是一个“高级”类型，它包含了合约的 ABI（应用二进制接口） 信息，即：它知道有哪些函数、参数是什么、返回值是什么。
    编译器不允许你直接在 address 上调用 power()。通过 ScientificCalculator(address)，显式把scientificCalculatorAddress由“地址类型”强制转换为“合约类型”。
    如果没有第二个ScientificCalculator，编译器会说：“类型不匹配！你不能直接把一个普通的 address 赋值给一个高贵的 ScientificCalculator 类型变量。”

    通过这两个ScientificCalculator实现了让scientificCalc变量可以调用ScientificCalculator合约中的函数。*/



    /*低级调用：与另一个合约 不导入其源代码 进行交互——也许你只知道你想调用的函数的地址和名称。
    
    ABI：
    ABI（应用二进制接口） 是智能合约与外部世界（或其他合约）进行交互的标准协议。
    A (Application)：应用程序（比如你的 Calculator 合约，或者网页前端）。
    B (Binary)：二进制。区块链不认识 squareRoot 这个单词，它只认识 0101 这种二进制数据。
    I (Interface)：接口。定义了双方沟通的“语言规范”。
    ABI将人类指令编码为机器能懂的二进制。
    
    abi.encodeWithSignature 和 abi.decode：都是 Solidity 内置的 ABI 工具。前者负责“打包”，后者负责“拆包”。*/

    function calculateSquareRoot(uint256 number)public view returns (uint256){
        bytes memory data = abi.encodeWithSignature("squareRoot(uint256)", number); // 对"squareRoot(int256)" 这个字符串进行 Keccak-256 哈希运算，然后取结果的前 4 个字节；把number这个参数转换成 32 字节宽度的十六进制；最后把 4 字节指纹 和 32 字节参数 连在一起，形成一段很长的 bytes（二进制数据），存在data变量里。
        (bool success, bytes memory returnData) = scientificCalculatorAddress.staticcall(data); // .call(data)：把打包好的数据扔给那个地址。success（bool值）：如果对方合约执行成功，它就是 true；如果对方报错（revert）或地址根本没代码，它就是 false（注意：底层调用失败不会让你的合约跟着崩溃，它只会返回 false）。returnData：这是对方合约执行完逻辑的结果（二进制格式）。
        require(success, "External call failed");
        uint256 result = abi.decode(returnData, (uint256)); // 返回的returnData是uint256类型数据，但以bytes类型回传，需要解析为uint256类型并存在result变量中
        return result;
    }

    /*使用了.call，编译器不允许写view，默认mutability关键字为non-payable：.call() 是以太坊中最强大的低级指令。由于它可以执行任何代码，编译器无法预知目标地址上的代码是否会修改状态（比如修改某个变量或转账）。Solidity 为了安全起见规定，一旦函数中出现了 .call()，这个函数就不能被标记为 view，因为它潜伏着修改状态的可能性。会按照non-payable（可写状态）消耗gas。
    可以把.call换成.staticcall，专门为只读操作设计的低级指令。*/


}


/*简单来说，Mutability（状态可变性） 在 Solidity 中决定了一个函数是否可以读取或修改区块链上的数据。
区块链上的资源（Gas 费）非常昂贵，明确告诉编译器你的函数要做什么，可以帮助优化代码并节省开销。
pure 不读不写；view 只读不写；default/non-payable 可读可写；payable 不仅可读可写，还可支付（允许接收ETH）。*/
    