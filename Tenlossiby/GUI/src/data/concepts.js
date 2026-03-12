export const gasEstimates = {
    increment: 21000,
    reset: 21000,
    addData: 40000,
    retrieveData: 0,
    addCandidate: 50000,
    vote: 35000,
    placeBid: 45000,
    endAuction: 25000,
    addTreasure: 30000,
    approveWithdrawal: 40000,
    withdrawTreasure: 50000,
    resetWithdrawalStatus: 25000,
    transferOwnership: 35000,
    getTreasureDetails: 0,
    addMembers: 45000,
    depositAmountEther: 35000,
    withdrawAmount: 40000,
    getMembers: 0,
    addFriend: 45000,
    depositIntoWallet: 35000,
    recordDebt: 45000,
    payFromWallet: 50000,
    transferEther: 35000,
    transferEtherViaCall: 40000,
    withdraw: 35000,
    checkBalance: 0
};

export const ethPricePerGwei = 0.00000004;

export const conceptDefinitions = {
    function: {
        name: "函数交互",
        icon: "🎯",
        unlockAt: 1,
        message: "你刚刚调用了 Solidity 中的第一个函数！在区块链上，用户与合约的所有交互都是通过函数完成的。",
        code: `function click() public {\n    // 你的点击在这里触发\n}`
    },
    increment: {
        name: "自增操作",
        icon: "➕",
        unlockAt: 2,
        message: "你发现了 `++` 这个操作符的作用！它的意思是\"在原来的基础上加 1\"。",
        code: `count++;  // 等同于 count = count + 1;`
    },
    uint256: {
        name: "uint256 变量",
        icon: "🔢",
        unlockAt: 3,
        message: "你刚刚修改了一个 `uint256` 类型的变量。`uint` = 无符号整数（只能存正数），`256` = 能存超级大的数字。",
        code: `uint256 public count;  // 能存储超大数字`
    },
    contract: {
        name: "contract 结构",
        icon: "🏗️",
        unlockAt: 4,
        message: "欢迎来到你的第一个 `contract`！你现在看到的交互界面，就是这个\"合约\"的前端。没有它，就没有智能合约世界！",
        code: `contract ClickCounter {\n    uint256 public count;\n    \n    function click() public {\n        count++;\n    }\n}`
    },
    string: {
        name: "string 类型",
        icon: "📝",
        unlockAt: 1,
        message: "你刚刚使用了 `string` 类型！它可以存储文本数据，比如名字、描述等信息。",
        code: `string name;  // 存储文本数据\nstring bio;   // 存储简介`
    },
    private: {
        name: "private 变量",
        icon: "🔒",
        unlockAt: 2,
        message: "你发现了 `private` 关键字！表示这个变量只能在合约内部访问，外部无法直接读取。",
        code: `string private name;  // 只能在合约内部访问`
    },
    memory: {
        name: "memory 存储",
        icon: "💾",
        unlockAt: 3,
        message: "你使用了 `memory` 关键字！表示数据存储在内存中，只在函数执行期间存在，执行完毕后自动清除。",
        code: `function add(string memory _name) public {\n    // _name 存储在内存中，临时使用\n}`
    },
    view: {
        name: "view 函数",
        icon: "👁️",
        unlockAt: 4,
        message: "你调用了 `view` 函数！它只读取数据不修改状态，因此不消耗 Gas，这是优化合约的重要方法。",
        code: `function retrieve() public view returns (string memory) {\n    return name;  // 只读取，不修改\n}`
    },
    parameters: {
        name: "函数参数",
        icon: "📥",
        unlockAt: 5,
        message: "你使用了函数参数！参数让函数能够接收外部传入的数据，使函数更加灵活。",
        code: `function add(string memory _name, string memory _bio) public {\n    // _name 和 _bio 是参数\n}`
    },
    returns: {
        name: "返回值",
        icon: "📤",
        unlockAt: 6,
        message: "你使用了 `returns` 关键字！它定义了函数返回的数据类型，让函数能够向调用者返回结果。",
        code: `function retrieve() public view returns (string memory, string memory) {\n    return (name, bio);  // 返回多个值\n}`
    },
    array: {
        name: "数组类型",
        icon: "📋",
        unlockAt: 1,
        message: "你刚刚创建了数组！`candidateNames` 数组用来存储所有候选人的姓名。",
        code: `string[] public candidateNames;  // 声明字符串数组\ncandidateNames.push("Alice");  // 添加第一个候选人`
    },
    push: {
        name: "push 方法",
        icon: "➕",
        unlockAt: 2,
        message: "你使用了 `push` 方法！它在数组末尾添加新元素，每次添加候选人都会用到它。",
        code: `candidateNames.push("Alice");  // 添加 Alice 到数组末尾\ncandidateNames.push("Bob");    // 添加 Bob 到数组末尾`
    },
    mapping: {
        name: "映射类型",
        icon: "🗺️",
        unlockAt: 3,
        message: "你发现了 `mapping` 映射！它用候选人姓名作为键，票数作为值，存储投票结果。",
        code: `mapping(string => uint256) voteCount;  // 声明映射\nvoteCount["Alice"] = 0;  // 初始化票数为0`
    },
    compound_assignment: {
        name: "复合赋值",
        icon: "⚡",
        unlockAt: 4,
        message: "你使用了 `+=` 复合赋值运算符！每次投票都会将候选人的票数加1。",
        code: `voteCount["Alice"] += 1;  // 票数加1，等同于 voteCount["Alice"] = voteCount["Alice"] + 1;`
    },
    constructor: {
        name: "构造函数",
        icon: "🏗️",
        unlockAt: 1,
        message: "你刚刚调用了构造函数！它只在合约部署时执行一次，用于初始化合约的状态变量。",
        code: `constructor(string memory _item, uint _biddingTime) {\n    owner = msg.sender;\n    item = _item;\n    auctionEndTime = block.timestamp + _biddingTime;\n}`
    },
    msg_sender: {
        name: "msg.sender",
        icon: "📧",
        unlockAt: 2,
        message: "你使用了 `msg.sender`！它表示当前调用合约的地址，可以是用户钱包或其他合约。",
        code: `address public owner = msg.sender;  // 部署者成为所有者\nfunction bid() external {\n    bids[msg.sender] = amount;  // 记录竞拍者出价\n}`
    },
    block_timestamp: {
        name: "block.timestamp",
        icon: "⏰",
        unlockAt: 3,
        message: "你使用了 `block.timestamp`！它返回当前区块的时间戳（Unix时间，秒），常用于时间相关的逻辑。",
        code: `uint public auctionEndTime = block.timestamp + _biddingTime;  // 设置拍卖结束时间\nrequire(block.timestamp < auctionEndTime, "Auction has ended.");  // 检查时间`
    },
    require: {
        name: "条件检查",
        icon: "✅",
        unlockAt: 4,
        message: "你使用了 `require` 语句！它在条件不满足时回滚交易，是合约安全的重要机制。",
        code: `require(amount > 0, "Bid amount must be greater than zero.");\nrequire(block.timestamp < auctionEndTime, "Auction has already ended.");`
    },
    external: {
        name: "external 函数",
        icon: "🌐",
        unlockAt: 5,
        message: "你使用了 `external` 函数！它只能从合约外部调用，比 `public` 更节省 Gas。",
        code: `function bid(uint amount) external {\n    // 只能从外部调用，不能在合约内部调用\n}`
    },
    address_type: {
        name: "地址类型",
        icon: "🏠",
        unlockAt: 6,
        message: "你使用了 `address` 类型！它存储以太坊地址（钱包地址或合约地址），是区块链交互的核心。",
        code: `address public owner;  // 所有者地址\naddress private highestBidder;  // 最高出价者地址\nmapping(address => uint) public bids;  // 地址到出价的映射`
    },
    bool_type: {
        name: "布尔类型",
        icon: "🔘",
        unlockAt: 7,
        message: "你使用了 `bool` 类型！它只有 `true` 或 `false` 两个值，用于标记状态。",
        code: `bool public ended;  // 拍卖是否已结束\nended = true;  // 标记拍卖结束\nrequire(!ended, "Auction already ended.");  // 检查状态`
    },
    modifier: {
        name: "修饰符",
        icon: "🛡️",
        unlockAt: 1,
        message: "你使用了 `modifier`！它用于为函数添加前置条件检查，确保只有满足条件的调用者才能执行函数。",
        code: `modifier onlyOwner() {\n    require(msg.sender == owner, "Only owner");\n    _;  // 继续执行被修饰的函数\n}`
    },
    zero_address: {
        name: "零地址检查",
        icon: "⚠️",
        unlockAt: 2,
        message: "你检查了 `address(0)` 零地址！它表示一个无效的地址，通常用于检查地址参数是否有效。",
        code: `require(newOwner != address(0), "Invalid address");  // 确保不是零地址\naddress(0)  // 零地址，表示无效地址`
    },
    return_statement: {
        name: "返回语句",
        icon: "↩️",
        unlockAt: 3,
        message: "你了解了返回语句的用法！继续解锁更多概念吧！",
        code: `function withdrawTreasure(uint256 amount) public {\n    if (msg.sender == owner) {\n        return;  // 所有者提前退出，不执行后续逻辑\n    }\n    \n    require(allowance > 0, "No allowance");\n    treasureAmount -= allowance;\n}`
    },
    address_mapping_balance: {
        name: "地址映射余额",
        icon: "💰",
        unlockAt: 1,
        message: "你刚刚使用了地址映射来存储每个用户的余额！mapping(address => uint256) 是存储用户资产的核心数据结构。",
        code: `mapping(address => uint256) balance;\n\nbalance[0x123...] = 1000000;  // 存储余额\nuint256 amount = balance[msg.sender];  // 读取余额`
    },
    payable: {
        name: "可支付函数",
        icon: "💵",
        unlockAt: 2,
        message: "你使用了 `payable` 关键字！它让函数能够接收以太币，这是处理资金交易的关键。",
        code: `function deposit() public payable {\n    // 这个函数可以接收以太币\n    require(msg.value > 0, "Must send ETH");\n    balance[msg.sender] += msg.value;\n}`
    },
    msg_value: {
        name: "发送金额",
        icon: "💳",
        unlockAt: 3,
        message: "你使用了 `msg.value`！它表示调用函数时发送的以太币数量（以wei为单位），是获取转账金额的标准方式。",
        code: `function deposit() public payable {\n    uint256 amount = msg.value;  // 获取发送的ETH数量\n    balance[msg.sender] += amount;\n}`
    },
    wei_unit: {
        name: "Wei 单位",
        icon: "⚖️",
        unlockAt: 4,
        message: "你了解了以太币的最小单位 wei！1 ETH = 10^18 wei，这是以太坊计价的基础单位。",
        code: `// 以太币单位\n1 wei = 0.000000000000000001 ETH\n1 gwei = 0.000000001 ETH\n1 ETH = 1000000000000000000 wei\n\nbalance[msg.sender] += 1000000000000000000;  // 增加 1 ETH`
    },
    ether_deposit_withdraw: {
        name: "存取逻辑",
        icon: "🏦",
        unlockAt: 5,
        message: "你掌握了以太币的存取核心逻辑！检查余额、增减余额、验证输入，这是任何金融合约的基础。",
        code: `function deposit() public payable {\n    require(msg.value > 0, "Invalid amount");\n    balance[msg.sender] += msg.value;\n}\n\nfunction withdraw(uint256 amount) public {\n    require(amount > 0, "Invalid amount");\n    require(balance[msg.sender] >= amount, "Insufficient balance");\n    balance[msg.sender] -= amount;\n}`
    },
    nested_mapping: {
        name: "嵌套映射",
        icon: "🗂️",
        unlockAt: 1,
        message: "你发现了嵌套映射！它允许你创建多维度的映射关系，比如记录'张三'欠'李四'多少钱。",
        code: `mapping(address => mapping(address => uint256)) public debts;\n\n// 记录债务\ndebts[_debtor][msg.sender] += _amount;`
    },
    address_payable: {
        name: "address payable",
        icon: "💸",
        unlockAt: 2,
        message: "你使用了 address payable！普通地址不能直接接收以太币，只有明确声明为 payable 的地址才可以。",
        code: `function transfer(address payable _to, uint256 _amount) public {\n    // _to 账户可以接收以太币\n}`
    },
    debt_tracking: {
        name: "债务追踪系统",
        icon: "📊",
        unlockAt: 3,
        message: "你体验了智能合约在金融记账中的作用！通过 mapping 和基本的运算，合约可以像微型银行一样准确记录复杂的债权债务关系。",
        code: `// 增加债务\ndebts[_debtor][msg.sender] += _amount;\n\n// 减少债务\ndebts[msg.sender][_creditor] -= _amount;`
    },
    internal_transfer: {
        name: "内部余额转账",
        icon: "🔄",
        unlockAt: 4,
        message: "你完成了内部转账！这是 DeFi（去中心化金融）中常见的模式，不真正转移底层资产，只是更新账本上的数字，可节省大量 Gas。",
        code: `// 只修改合约内部状态，不发起真正的链上转账\nbalances[msg.sender] -= _amount;\nbalances[_creditor] += _amount;`
    },
    transfer_method: {
        name: "transfer() 转账",
        icon: "📤",
        unlockAt: 5,
        message: "你使用了 transfer() 发送以太币！这是 Solidity 早期的标准转账方法，会自动限制 2300 gas，防止重入攻击，但在硬分叉后可能导致 gas 不足。",
        code: `// 使用 transfer 进行安全的以太币转账\n// 固定消耗 2300 gas\n_to.transfer(_amount);`
    },
    call_method: {
        name: "call() 低级调用",
        icon: "📡",
        unlockAt: 6,
        message: "你使用了 call() 方法！这是目前官方推荐的转账方式，它返回一个布尔值表示是否成功，允许发送更多的 gas 给接收方（特别是智能合约）。",
        code: `// 推荐的以太币转账方式\n// 返回 true 或 false，附带返回值\n(bool success, ) = _to.call{value: _amount}("");\nrequire(success, "Transfer failed");`
    },
    withdraw_pattern: {
        name: "提现模式 (Withdraw)",
        icon: "🏧",
        unlockAt: 7,
        message: "你掌握了提现模式！与其主动将资金发送给用户（易受攻击），不如让用户自己来提取他们的资金，这是智能合约安全的核心原则之一。",
        code: `function withdraw(uint256 _amount) public {\n    require(balances[msg.sender] >= _amount);\n    balances[msg.sender] -= _amount;\n    (bool success, ) = payable(msg.sender).call{value: _amount}("");\n    require(success);\n}`
    }
};

export const getHint = (conceptKey) => {
    const hints = {
        function: "🎉 很棒！现在你了解了函数的作用。继续点击，看看还能发现什么？",
        increment: "🚀 太棒了！你已经掌握了自增操作。再试一次！",
        uint256: "📊 不错！你正在深入了解数据存储。继续探索！",
        contract: "🏆 恭喜！你已经完成了 Day 1 的所有核心概念！你可以查看完整的代码了。",
        string: "📝 不错！你学会了如何存储文本数据。继续探索更多概念！",
        private: "🔒 很好！你理解了访问控制的概念。继续学习！",
        memory: "💾 太棒了！你了解了数据存储位置的重要性。继续前进！",
        view: "👁️ 优秀！你掌握了只读函数的优化技巧。再接再厉！",
        parameters: "📥 很好！你学会了如何让函数接收外部数据。继续探索！",
        returns: "📤 太棒了！你已经完成了 Day 2 的所有核心概念！你可以查看完整的代码了。",
        array: "📋 不错！你学会了使用数组存储多个数据。继续探索！",
        mapping: "🗺️ 很棒！你掌握了映射的用法。再试试添加更多候选人！",
        push: "➕ 太棒了！你已经学会动态添加数据。试试投票功能吧！",
        compound_assignment: "⚡ 优秀！你掌握了复合赋值运算符。继续投票解锁更多概念！",
        constructor: "🏗️ 太棒了！你刚刚部署了一个拍卖合约！构造函数只执行一次，初始化了拍卖物品和结束时间。继续出价吧！",
        msg_sender: "📧 不错！你使用了 `msg.sender` 来记录竞拍者地址。继续出价解锁更多概念！",
        block_timestamp: "⏰ 很棒！你了解了如何使用时间戳来控制拍卖时间。继续探索！",
        require: "✅ 优秀！你掌握了条件检查机制，这是保证合约安全的重要工具！",
        external: "🌐 很好！你使用了 external 函数来节省 Gas。继续出价吧！",
        address_type: "🏠 太棒了！你了解了地址类型，这是区块链交互的核心！继续探索！",
        bool_type: "🔘 优秀！你完成了 Day 4 的所有核心概念！你可以查看完整的代码了！",
        modifier: "🛡️ 太棒了！你刚刚使用了修饰符！这是权限控制的重要工具。继续探索更多功能！",
        zero_address: "⚠️ 不错！你学会了检查零地址，这是防止错误的重要机制！继续前进！",
        return_statement: "↩️ 很棒！你了解了返回语句的用法！继续解锁更多概念吧！",
        address_mapping_balance: "💰 太棒了！你学会了使用地址映射来存储余额！继续探索吧！",
        payable: "💵 很好！你使用了 payable 关键字来接收以太币！继续学习！",
        msg_value: "💳 不错！你了解了 msg.value 的用法，可以获取发送的ETH数量！",
        wei_unit: "⚖️ 太棒了！你了解了以太币的 wei 单位！这是以太坊计价的基础！",
        ether_deposit_withdraw: "🏦 优秀！你完成了 Day 6 的所有核心概念！你可以查看完整的代码了！",
        nested_mapping: "🗂️ 很好！你了解了嵌套映射如何处理复杂关系。继续添加朋友或存款！",
        address_payable: "💸 不错！你知道了 payable 才能让地址收钱。试试记录一笔债务吧！",
        debt_tracking: "📊 优秀！你掌握了如何使用合约记录金融债权关系。尝试还债吧！",
        internal_transfer: "🔄 太棒了！内部记账转账非常节省 Gas。接下来试试真正的转账功能。",
        transfer_method: "📤 了解 transfer() 转账！这是安全但古老的方式。再试试用 call() 转账！",
        call_method: "📡 绝佳！call() 是现代 Solidity 推荐的转账方式。试试提取余额吧！",
        withdraw_pattern: "🏧 恭喜你！安全第一的提现模式是智能合约的基石！你已完成 Day 7 所有核心概念！"
    };
    return hints[conceptKey] || "📖 点击其他概念标签查看更多详细解释。";
};

export const getConceptExplanationHint = (conceptKey) => {
    const hints = {
        function: "📖 这是函数的基本概念，它是智能合约的基本构建模块。",
        increment: "📖 自增操作是编程中常见的操作，用于快速增加数值。",
        uint256: "📖 uint256 是 Solidity 中最常用的整数类型，了解它很重要。",
        contract: "📖 智能合约是区块链上的自动执行代码，理解它的结构很关键。",
        string: "📖 string 类型用于存储文本数据，是智能合约中常用的数据类型之一。",
        private: "📖 private 关键字限制变量的访问范围，提高合约的安全性。",
        memory: "📖 memory 数据位置用于临时存储，只在函数执行期间存在。",
        view: "📖 view 函数不修改状态，不消耗 Gas，是优化合约性能的重要方法。",
        parameters: "📖 函数参数让函数能够接收外部数据，使函数更加灵活和可复用。",
        returns: "📖 returns 关键字定义函数返回值，让函数能够向调用者返回结果。",
        array: "📖 数组是存储多个相同类型数据的容器，在 Solidity 中广泛使用。",
        mapping: "📖 映射是 Solidity 中的键值对存储结构，通过键快速查找对应的值。",
        push: "📖 push 方法是数组的常用操作，可以在数组末尾动态添加元素。",
        compound_assignment: "📖 复合赋值运算符将运算和赋值结合在一起，使代码更加简洁。",
        constructor: "📖 构造函数只在合约部署时执行一次，用于初始化合约的状态变量。",
        msg_sender: "📖 msg.sender 表示当前调用合约的地址，是区块链交互的核心。",
        block_timestamp: "📖 block.timestamp 返回当前区块的时间戳，常用于时间相关的逻辑。",
        require: "📖 require 语句在条件不满足时回滚交易，是保证合约安全的重要机制。",
        external: "📖 external 函数只能从合约外部调用，比 public 更节省 Gas。",
        address_type: "📖 address 类型存储以太坊地址，是区块链交互的核心数据类型。",
        bool_type: "📖 bool 类型只有 true 或 false 两个值，用于标记状态。",
        modifier: "📖 修饰符用于为函数添加前置条件检查，是权限控制的重要机制。",
        zero_address: "📖 零地址 address(0) 表示一个无效的地址，通常用于检查地址参数是否有效。",
        return_statement: "📖 return 语句让函数返回指定的值给调用者，是函数输出结果的方式。",
        address_mapping_balance: "📖 地址映射 mapping(address => uint256) 是存储用户资产的核心数据结构，通过地址快速查找对应的余额。",
        payable: "📖 payable 关键字让函数能够接收以太币，这是处理资金交易的关键特性。",
        msg_value: "📖 msg.value 表示调用函数时发送的以太币数量（以wei为单位），是获取转账金额的标准方式。",
        wei_unit: "📖 wei 是以太币的最小单位，1 ETH = 10^18 wei，这是以太坊计价的基础单位。",
        ether_deposit_withdraw: "📖 存取逻辑包括检查余额、增减余额、验证输入，这是任何金融合约的基础。",
        nested_mapping: "📖 嵌套映射 mapping(A => mapping(B => C)) 允许你在 Solidity 中创建像多维数组或字典中嵌套字典的复杂数据结构。",
        address_payable: "📖 payable 地址类型拥有 transfer 和 call 方法来发送 Ether。没有 fallback 且非 payable 的地址无法接收以太币。",
        debt_tracking: "📖 债务追踪展示了区块链账本的不变性和透明性，确保每一笔债权和债务都在链上清晰可查的特性。",
        internal_transfer: "📖 内部账本系统(Internal Accounting)只改变合约内存的数字而不进行链上交易转账，是处理多高频微支付的最佳实操。",
        transfer_method: "📖 .transfer() 将转账可用 gas 固定为 2300 防止重入，但当目标接收方智能合约的 fallback 逻辑超过一定 gas 时会导致资金卡死。",
        call_method: "📖 .call() 提供低级别的外部调用功能，转账时能够转发所有剩余 gas 或自定义数量的 gas 以保证外部操作能顺利执行并返回回调状态。",
        withdraw_pattern: "📖 提现优于发送。要求用户主动调用 withdraw()，避免了遍历用户数组发钱（可能超出 block gas 限制）以及转账失败阻塞整个合约的风险。"
    };
    return hints[conceptKey] || "📖 点击其他概念标签查看更多详细解释。";
};
