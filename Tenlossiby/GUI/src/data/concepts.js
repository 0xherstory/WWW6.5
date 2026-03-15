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
    checkBalance: 0,
    addCurrency: 45000,
    tipInEth: 40000,
    tipInCurrency: 50000,
    withdrawTips: 35000,
    transferOwnership8: 35000
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
    withdraw_pattern: {
        name: "提现模式 (Withdraw)",
        icon: "🏧",
        unlockAt: 7,
        message: "你掌握了提现模式！与其主动将资金发送给用户（易受攻击），不如让用户自己来提取他们的资金，这是智能合约安全的核心原则之一。",
        code: `function withdraw(uint256 _amount) public {\n    require(balances[msg.sender] >= _amount);\n    balances[msg.sender] -= _amount;\n    (bool success, ) = payable(msg.sender).call{value: _amount}("");\n    require(success);\n}`
    },
    nested_mapping: {
        name: "嵌套映射",
        icon: "🗂️",
        unlockAt: 1,
        message: "你掌握了如何使用嵌套映射 (mapping in mapping)！这是处理复杂关系（如“谁欠谁多少钱”）的终极武器。",
        code: `mapping(address => mapping(address => uint256)) public debts;`
    },
    address_payable: {
        name: "Payable 地址",
        icon: "💸",
        unlockAt: 2,
        message: "你使用了 address payable！只有标记为 payable 的地址才能接收 Ether，否则编译器会报错保护资金安全。",
        code: `address payable user = payable(msg.sender);`
    },
    debt_tracking: {
        name: "债务追踪",
        icon: "📊",
        unlockAt: 3,
        message: "区块链就是一本账本！你刚刚在链上永久记录了一笔债权关系，且任何人无法抵赖。",
        code: `debts[debtor][msg.sender] += amount;`
    },
    internal_transfer: {
        name: "内部记账转账",
        icon: "🔄",
        unlockAt: 4,
        message: "你完成了一次“内部转账”！这并没有发生真实的链上交易，只是在合约账本里扣减了一个人的余额并增加给另一个人，非常省 Gas。",
        code: `balances[msg.sender] -= amount;\nbalances[creditor] += amount;`
    },
    transfer_method: {
        name: "transfer() 转账",
        icon: "📤",
        unlockAt: 5,
        message: "你使用了经典的 .transfer() 方法。它会自动在转账失败时触发 revert，是最简单安全的转账方式。",
        code: `payable(to).transfer(amount);`
    },
    call_method: {
        name: "call() 转账",
        icon: "📡",
        unlockAt: 6,
        message: "你使用了更强大的 .call() 方法！它是目前以太坊开发中最推荐的转账方式，因为它允许你灵活处理 Gas 限制和错误结果。",
        code: `(bool success, ) = to.call{value: amount}("");\nrequire(success, "Transfer failed");`
    },
    modifier_onlyOwner: {
        name: "onlyOwner 修饰符",
        icon: "🛡️",
        unlockAt: 1,
        message: "你发现了 `onlyOwner`！这是一个自定义修饰符，专门用来限制只有管理员（合约拥有者）才能执行特定的函数（如提现、改汇率）。",
        code: `modifier onlyOwner() {\n    require(msg.sender == owner, "Only owner can perform this action");\n    _;\n}`
    },
    payable_tip: {
        name: "payable 支付关键字",
        icon: "💰",
        unlockAt: 2,
        message: "你成功进行了一次带钱的交互！在 Solidity 中，只有标记为 `payable` 的函数才能接收随交易发送的以太币。",
        code: `function tipInEth() public payable {\n    // 带有 payable 才能收钱\n}`
    },
    msg_value_tip: {
        name: "msg.value 发送金额",
        icon: "💸",
        unlockAt: 3,
        message: "你发送了 ETH！`msg.value` 是一个全局变量，代表了你在调用这个函数时额外付出的金钱（单位是 wei）。",
        code: `tipPerPerson[msg.sender] += msg.value;\ntotalTipsReceived += msg.value;`
    },
    address_balance: {
        name: "合约余额查询",
        icon: "🏦",
        unlockAt: 4,
        message: "想要知道存钱柜里有多少钱？`address(this).balance` 会返回当前智能合约在链上的全部实时余额。",
        code: `uint256 contractBalance = address(this).balance;\nrequire(contractBalance > 0, "No tips to withdraw");`
    },
    call_withdraw: {
        name: "底层 call 转账",
        icon: "📡",
        unlockAt: 5,
        message: "管理员提现成功！使用 `.call{value: ...}(\"\")` 是目前以太坊开发中推荐的由合约向外部地址转账的最灵活方式。",
        code: `(bool success, ) = payable(owner).call{value: contractBalance}("");\nrequire(success, "Transfer failed");`
    },
    mapping_rates: {
        name: "法币汇率映射",
        icon: "💹",
        unlockAt: 6,
        message: "智能合约也能换钱！这里使用了 `mapping(string => uint256)` 来存储不同法币（字符串）对应的 ETH 汇率（数字）。",
        code: `mapping(string => uint256) public conversionRates;

conversionRates["USD"] = 5 * 10**14;`
    },
    pure_function: {
        name: "Pure 纯函数",
        icon: "⚡",
        unlockAt: 1,
        message: "你使用了 `pure` 函数！pure函数不读取也不修改区块链状态，执行快速且不消耗Gas，适合简单的数学计算。",
        code: `function add(uint256 a, uint256 b) public pure returns(uint256) {
    return a + b;  // 纯计算，不访问状态
}`
    },
    view_function: {
        name: "View 视图函数",
        icon: "👁️",
        unlockAt: 2,
        message: "你使用了 `view` 函数！view函数可以读取状态变量但不修改它们，适合查询操作，不消耗Gas。",
        code: `function calculatePower(uint256 base, uint256 exponent) public view returns(uint256) {
    // 读取 scientificCalculatorAddress 状态变量
    ScientificCalculator calc = ScientificCalculator(scientificCalculatorAddress);
    return calc.power(base, exponent);
}`
    },
    cross_contract_call: {
        name: "跨合约调用",
        icon: "📡",
        unlockAt: 3,
        message: "你完成了跨合约调用！一个合约可以通过地址调用另一个合约的函数，实现合约间的组合与协作。",
        code: `// Calculator合约调用ScientificCalculator合约
ScientificCalculator scientificCalc = 
    ScientificCalculator(scientificCalculatorAddress);
uint256 result = scientificCalc.power(base, exponent);`
    },
    interface_call: {
        name: "接口方式调用",
        icon: "🔌",
        unlockAt: 4,
        message: "你使用了接口方式调用外部合约！通过创建接口实例，可以像调用本地函数一样调用外部合约。",
        code: `// 创建外部合约接口实例
ScientificCalculator scientificCalc = 
    ScientificCalculator(scientificCalculatorAddress);

// 调用外部合约函数
uint256 result = scientificCalc.power(base, exponent);`
    },
    low_level_call: {
        name: "底层 Call 调用",
        icon: "🔧",
        unlockAt: 5,
        message: "你使用了底层 `call` 方法！这是最灵活的跨合约调用方式，通过 `abi.encodeWithSignature` 编码函数调用。",
        code: `// 编码函数签名
bytes memory data = abi.encodeWithSignature(
    "squareRoot(int256)", number
);

// 发起底层call调用
(bool success, bytes memory returnData) = 
    scientificCalculatorAddress.call(data);

// 解码返回数据
uint256 result = abi.decode(returnData, (uint256));`
    },
    newton_iteration: {
        name: "牛顿迭代法",
        icon: "📐",
        unlockAt: 7,
        message: "你了解了牛顿迭代法！Solidity不支持浮点数，通过迭代逼近真实值是常用的数学算法实现方式。",
        code: `function squareRoot(int256 number) public pure returns(int256) {
    int256 result = number / 2;
    // 限制10轮，防止Gas耗尽
    for(uint256 i = 0; i < 10; i++) {
        result = (result + number / result) / 2;
    }
    return result;
}`
    },
    contract_composition: {
        name: "合约组合",
        icon: "🧩",
        unlockAt: 8,
        message: "恭喜你掌握了合约组合！合约可以像乐高积木一样组合复用，构建复杂的去中心化应用。",
        code: `// Calculator合约组合了ScientificCalculator合约
contract Calculator {
    address public scientificCalculatorAddress;
    
    // 通过接口调用外部合约功能
    function calculatePower(uint256 base, uint256 exponent) 
        public view returns(uint256) {
        ScientificCalculator calc = 
            ScientificCalculator(scientificCalculatorAddress);
        return calc.power(base, exponent);
    }
}`
    },
    // ========== Day 10 概念定义 ==========
    struct_definition: {
        name: "结构体定义",
        icon: "📦",
        unlockAt: 1,
        message: "你刚刚使用了 `struct` 结构体！它可以打包多个不同类型的变量，创建自定义数据类型。",
        code: `struct UserProfile {
    string name;       // 用户姓名
    uint256 weight;    // 用户体重
    bool isRegistered; // 是否已注册
}

// 创建结构体实例
UserProfile memory newUser = UserProfile({
    name: "张三",
    weight: 70,
    isRegistered: true
});`
    },
    array_in_mapping: {
        name: "映射中的数组",
        icon: "🗂️",
        unlockAt: 2,
        message: "你发现了 mapping 到数组的用法！这可以为每个用户存储一个运动记录列表。",
        code: `// mapping 到数组
mapping(address => WorkoutActivity[]) private workoutHistory;

// 添加新记录
workoutHistory[msg.sender].push(newWorkout);

// 获取记录数量
uint256 count = workoutHistory[msg.sender].length;`
    },
    multiple_mappings: {
        name: "多个映射组合",
        icon: "🗺️",
        unlockAt: 3,
        message: "你看到了多个映射如何协同工作！userProfiles、totalWorkouts、totalDistance 分别存储不同维度的数据。",
        code: `// 多个映射协同工作
mapping(address => UserProfile) public userProfiles;        // 用户资料
mapping(address => WorkoutActivity[]) private workoutHistory;  // 运动历史
mapping(address => uint256) public totalWorkouts;            // 运动次数
mapping(address => uint256) public totalDistance;            // 总距离

// 它们共同构建了完整的数据视图`
    },
    storage_keyword: {
        name: "storage 关键字",
        icon: "💾",
        unlockAt: 4,
        message: "你使用了 `storage` 关键字！它创建状态变量的引用，直接修改原数据而不是创建副本，非常节省 Gas。",
        code: `function updateWeight(uint256 _newWeight) public {
    // storage 关键字创建引用
    UserProfile storage profile = userProfiles[msg.sender];
    
    // 直接修改原数据，不创建副本
    profile.weight = _newWeight;
    
    // ❌ 如果用 memory，会创建副本，修改不会生效
    // UserProfile memory profile = userProfiles[msg.sender];
}`
    },
    event_logging: {
        name: "事件日志",
        icon: "📋",
        unlockAt: 1,
        message: "你触发了事件！事件记录在区块链日志中，前端可以监听事件来获取实时通知。",
        code: `// 定义事件
event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
event WorkoutLogged(address indexed user, string activityType, uint256 duration);

// 触发事件
emit UserRegistered(msg.sender, "张三", block.timestamp);
emit WorkoutLogged(msg.sender, "跑步", 1800);`
    },
    milestone_detection: {
        name: "里程碑检测",
        icon: "🏆",
        unlockAt: 5,
        message: "你完成了里程碑检测！通过条件判断检测用户是否达成特定目标，并触发相应奖励。",
        code: `// 运动次数里程碑
if (totalWorkouts == 10) {
    emit MilestoneAchieved(msg.sender, "10次运动达成！");
} else if (totalWorkouts == 50) {
    emit MilestoneAchieved(msg.sender, "50次运动大师！");
}

// 距离里程碑（跨越检测）
if (totalDistance >= 100000 && totalDistance - distance < 100000) {
    emit MilestoneAchieved(msg.sender, "100公里里程碑！");
}`
    },
    timestamp_usage: {
        name: "时间戳使用",
        icon: "⏰",
        unlockAt: 2,
        message: "你使用了 `block.timestamp`！它记录当前区块的时间戳，用于标记运动记录的时间。",
        code: `WorkoutActivity memory newWorkout = WorkoutActivity({
    activityType: "跑步",
    duration: 1800,
    distance: 5000,
    timestamp: block.timestamp  // 记录运动时间
});`
    },
    onlyRegistered_modifier: {
        name: "onlyRegistered 修饰符",
        icon: "🛡️",
        unlockAt: 1,
        message: "你使用了 `onlyRegistered` 修饰符！它确保只有注册用户才能调用特定函数，保护合约安全。",
        code: `// 定义修饰符
modifier onlyRegistered() {
    require(userProfiles[msg.sender].isRegistered, "User not registered");
    _;  // 继续执行函数
}

// 使用修饰符
function logWorkout(...) public onlyRegistered {
    // 只有注册用户才能执行
}`
    }
};

// ========== Day 11 概念定义 ==========
export const day11ConceptDefinitions = {
    inheritance: {
        name: "合约继承",
        icon: "🧬",
        unlockAt: 1,
        message: "你刚刚体验了合约继承！VaultMaster 通过 `is Ownable` 继承了父合约的所有功能，这是代码复用的核心机制。",
        code: `// 父合约
contract Ownable {
    address private owner;
    // ...
}

// 子合约继承父合约
contract VaultMaster is Ownable {
    // 自动拥有 Ownable 的所有功能
    function withdraw() public onlyOwner {
        // 可以使用继承的 onlyOwner 修饰符
    }
}`
    },
    import_statement: {
        name: "导入语句",
        icon: "📥",
        unlockAt: 2,
        message: "你了解了 `import` 语句！它允许合约引用其他文件中的合约定义，是模块化开发的基础。",
        code: `// 导入外部合约
import "./Ownable.sol";

// 现在可以使用 Ownable 合约了
contract VaultMaster is Ownable {
    // ...
}`
    },
    constructor: {
        name: "构造函数",
        icon: "🏗️",
        unlockAt: 1,
        message: "你刚刚了解了构造函数！它在合约部署时自动执行一次，用于初始化关键状态变量。",
        code: `contract Ownable {
    address private owner;
    
    // 构造函数：部署时自动执行
    constructor() {
        owner = msg.sender;  // 设置部署者为所有者
    }
}`
    },
    private_visibility: {
        name: "私有可见性",
        icon: "🔒",
        unlockAt: 2,
        message: "你了解了 `private` 可见性！它确保变量只能在当前合约内部访问，提供最强的封装保护。",
        code: `contract Ownable {
    // private：只有当前合约可以访问
    address private owner;
    
    // public：任何人都可以访问
    function ownerAddress() public view returns (address) {
        return owner;  // 通过函数间接访问
    }
}`
    },
    event_logging: {
        name: "事件日志",
        icon: "📋",
        unlockAt: 1,
        message: "你触发了事件！事件是合约与前端通信的重要机制，记录关键操作到区块链日志中。",
        code: `// 定义事件
event DepositSuccessful(
    address indexed depositor,
    uint256 amount
);

// 触发事件
function deposit() public payable {
    emit DepositSuccessful(msg.sender, msg.value);
}`
    },
    indexed_parameter: {
        name: "索引参数",
        icon: "🏷️",
        unlockAt: 2,
        message: "你了解了 `indexed` 关键字！它允许前端按特定参数过滤事件日志，提高查询效率。",
        code: `// indexed 参数可以被过滤查询
event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
);

// 前端可以按地址过滤事件
// 例如：查找特定用户的所有转账记录`
    },
    transfer_ownership: {
        name: "所有权转移",
        icon: "🔑",
        unlockAt: 1,
        message: "你刚刚完成了所有权转移！这是合约管理的核心功能，确保合约可以安全地更换管理者。",
        code: `function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0), "Invalid address");
    
    address oldOwner = owner;
    owner = newOwner;
    
    emit OwnershipTransferred(oldOwner, newOwner);
}`
    },
    onlyOwner_modifier: {
        name: "onlyOwner 修饰符",
        icon: "🛡️",
        unlockAt: 1,
        message: "你体验了 `onlyOwner` 修饰符的权限控制！它确保只有合约所有者才能执行敏感操作。",
        code: `// 定义修饰符
modifier onlyOwner() {
    require(msg.sender == owner, "Only owner");
    _;  // 继续执行被修饰的函数
}

// 使用修饰符保护函数
function withdraw() public onlyOwner {
    // 只有所有者可以执行
}`
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
        withdraw_pattern: "🏧 恭喜你！安全第一的提现模式是智能合约的基石！你已完成 Day 7 所有核心概念！",
        modifier_onlyOwner: "🛡️ 只有 Owner 能执行此操作！你体验到了 Solidity 中的权限控制。继续打赏解锁！",
        payable_tip: "💰 函数带了 payable 标签就可以收钱啦！试试用不同货币打赏！",
        msg_value_tip: "💸 你付出的每一份钱都存在了 msg.value 里。继续加油！",
        address_balance: "🏦 看到金库里的余额了吗？这正是通过 address(this).balance 查询到的！",
        call_withdraw: "📡 提现成功！call 是目前最推荐的发送 ETH 方式。继续探索！",
        mapping_rates: "💹 汇率表在映射中生效了！你已经掌握了 Day 8 的所有核心概念，点击查看完整代码吧！",
        pure_function: "⚡ 太棒了！你使用了 pure 函数！它不读取也不修改状态，执行快速且不消耗 Gas。继续完成更多运算！",
        view_function: "👁️ 很好！你使用了 view 函数！它可以读取状态但不修改，适合查询操作。继续探索跨合约调用！",
        cross_contract_call: "📡 优秀！你完成了跨合约调用！合约之间可以相互调用，实现功能组合。继续尝试底层 call！",
        interface_call: "🔌 太棒了！你使用了接口方式调用外部合约！这是最常见的跨合约调用方式。继续学习底层 call！",
        low_level_call: "🔧 绝佳！你使用了底层 call 方法！这是最灵活的调用方式。继续探索牛顿迭代法！",
        newton_iteration: "📐 恭喜你了解了牛顿迭代法！Solidity 不支持浮点数，迭代逼近是常用技巧。完成最后挑战！",
        contract_composition: "🧩 恭喜你！你掌握了合约组合！合约可以像乐高积木一样组合复用。你已完成 Day 9 所有核心概念！",
        // ========== Day 10 提示 ==========
        struct_definition: "📦 太棒了！你学会了使用结构体打包数据！👉 下一步：记录一次运动来看看时间戳如何工作！",
        array_in_mapping: "🗂️ 很好！你看到了映射到数组的用法！👉 下一步：查看统计数据来解锁 multiple_mappings！",
        multiple_mappings: "🗺️ 优秀！你了解了多个映射如何协同工作！👉 下一步：更新体重来解锁 storage_keyword！",
        storage_keyword: "💾 太棒了！你了解了 storage 的威力！👉 下一步：继续记录运动，达成里程碑来解锁 milestone_detection！",
        event_logging: "📋 不错！你触发了事件日志！👉 下一步：记录运动来查看运动历史如何存储！",
        milestone_detection: "🏆 恭喜！你达成了里程碑！👉 下一步：查看完整代码来复习所有知识！",
        timestamp_usage: "⏰ 很好！你学会了记录时间戳！👉 下一步：查看运动历史来解锁 array_in_mapping！",
        onlyRegistered_modifier: "🛡️ 太棒了！你了解了修饰符如何保护函数！👉 下一步：记录运动来解锁更多概念！",
        // ========== Day 11 提示 ==========
        inheritance: "🧬 太棒了！你体验了合约继承！VaultMaster 继承了 Ownable 的所有功能！👉 存入 ETH 来学习 import 机制！",
        import_statement: "📥 不错！你了解了导入语句！👉 继续操作来学习事件日志！",
        constructor: "🏗️ 太棒了！你了解了构造函数！👉 查看完整代码来学习 private 可见性！",
        private_visibility: "🔒 优秀！你学会了 private 变量的使用！",
        event_logging: "📋 很好！你触发了事件日志！👉 尝试转移所有权来解锁更多概念！",
        indexed_parameter: "🏷️ 不错！你了解了索引参数！",
        transfer_ownership: "🔑 很好！你了解了所有权转移！👉 尝试以用户身份提取来学习修饰符！",
        onlyOwner_modifier: "🛡️ 太棒了！你了解了 onlyOwner 修饰符！👉 查看完整代码来学习更多！"
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
        withdraw_pattern: "📖 提现优于发送。要求用户主动调用 withdraw()，避免了遍历用户数组发钱（可能超出 block gas 限制）以及转账失败阻塞整个合约的风险。",
        modifier_onlyOwner: "📖 修饰符（Modifier）允许你在不重复编写核心检查逻辑的情况下，重用访问控制代码。`_` 符号代表了目标函数体的执行位置。",
        payable_tip: "📖 `payable` 是一个函数可见性/状态修饰符。如果没有它，任何尝试向该函数发送 Ether 的交易都会被以太坊虚拟机拒绝并回滚。",
        msg_value_tip: "📖 `msg.value` 是当前交易附带的以太币数量，以 wei 为单位。它是智能合约处理实时支付的桥梁。",
        address_balance: "📖 合约不仅可以操作别人的钱，还可以管理属于它自己的钱。`address(this).balance` 让你能实时掌控合约金库的‘水位’。",
        call_withdraw: "📖 `.call()` 是一个底层原语。在转账时，它能够处理复杂的 Fallback 逻辑，并明确返回一个成功/失败的布尔值，比旧的 `transfer` 更具鲁活性。",
        mapping_rates: "📖 虽然以太坊没有内置汇率，但我们可以通过合约内部的映射来手动维护一组兑换比例，从而实现'打赏 1 美元 = 支付 X 数量 ETH'的功能。",
        pure_function: "📖 pure 函数承诺不读取也不修改区块链的状态变量。这意味着它的执行结果完全取决于输入参数，可以在本地快速计算，不需要消耗 Gas。",
        view_function: "📖 view 函数可以读取状态变量但不修改它们。由于不修改状态，view 函数也可以在本地执行，不消耗 Gas，适合用于查询操作。",
        cross_contract_call: "📖 跨合约调用是 Solidity 的核心特性之一。通过合约地址，一个合约可以调用另一个合约的函数，实现功能的组合和复用，就像乐高积木一样。",
        interface_call: "📖 接口方式调用是最常用的跨合约调用方法。通过创建外部合约的接口实例，可以像调用本地函数一样调用外部合约，代码清晰易读。",
        low_level_call: "📖 底层 call 方法提供了最大的灵活性。它通过 abi.encodeWithSignature 编码函数调用，可以调用任何函数，即使接口未知。但使用起来更复杂，需要手动处理返回值。",
        newton_iteration: "📖 牛顿迭代法是一种快速逼近方程根的算法。在 Solidity 中，由于不支持浮点数运算，我们使用整数运算通过多次迭代来逼近真实值。限制迭代次数可以防止 Gas 耗尽。",
        contract_composition: "📖 合约组合是 Solidity 的重要设计理念。通过将功能拆分到多个合约，可以实现代码复用、降低复杂度、提高可维护性。这是构建复杂 DApp 的基础。",
        // ========== Day 10 解释提示 ==========
        struct_definition: "📖 `struct` 结构体允许你定义自定义的数据类型，将多个不同类型的变量打包在一起。这是组织复杂数据的有效方式，让代码更加清晰和易于维护。",
        array_in_mapping: "📖 Solidity 允许将映射指向数组，如 `mapping(address => WorkoutActivity[])`。这样每个地址都有一个动态数组，非常适合存储用户的历史记录、交易列表等一对多的数据关系。",
        multiple_mappings: "📖 在实际应用中，经常使用多个 mapping 来存储不同维度的数据。比如一个 mapping 存用户资料，另一个存用户余额。通过同一个 key（如用户地址）可以关联访问多个数据结构。",
        storage_keyword: "📖 `storage` 和 `memory` 是 Solidity 中两个重要的数据位置关键字。`storage` 变量永久存储在区块链状态中，而 `memory` 变量只在函数执行期间临时存在。使用 `storage` 引用可以直接修改状态变量，节省 Gas。",
        event_logging: "📖 事件（Event）是 Solidity 的日志机制。通过 `emit` 触发事件，数据会被记录在区块链的交易日志中。前端可以监听事件来实现实时通知、记录历史等功能，事件是 DApp 前后端通信的重要桥梁。",
        milestone_detection: "📖 里程碑检测是游戏化应用的核心机制。通过条件判断（如 `if (count == 10)`）检测用户是否达成特定目标，并触发相应奖励或通知。这能激励用户持续使用产品。",
        timestamp_usage: "📖 `block.timestamp` 是当前区块的时间戳（Unix 时间，秒）。它常用于记录事件发生时间、设置时间限制、计算时间差等。注意它由矿工设置，存在约15秒的误差，不应用于精确计时。",
        onlyRegistered_modifier: "📖 修饰符（Modifier）是 Solidity 的复用机制，用于在函数执行前添加前置条件检查。`onlyRegistered` 确保只有满足条件的用户（已注册）才能调用函数。这简化了代码，避免了在每个函数中重复写检查逻辑。"
    };
    return hints[conceptKey] || "📖 点击其他概念标签查看更多详细解释。";
};

// ========== Day 11 概念解释提示 ==========
export const getDay11ExplanationHint = (conceptKey) => {
    const hints = {
        inheritance: "📖 合约继承是 Solidity 的核心特性之一。通过 `contract VaultMaster is Ownable`，子合约可以继承父合约的所有状态变量和函数，实现代码复用和模块化设计。",
        import_statement: "📖 `import` 语句用于导入其他合约文件，让你可以在当前合约中使用外部定义的合约。这是实现合约组合和代码复用的基础。",
        constructor: "📖 构造函数 `constructor()` 在合约部署时自动执行一次，用于初始化合约的状态变量。在 Ownable 中，它将合约部署者设置为初始所有者。",
        private_visibility: "📖 `private` 可见性修饰符表示变量只能在当前合约内部访问，即使是子合约也无法直接访问。这提供了最强的封装性，保护敏感数据。",
        event_logging: "📖 事件（Event）用于记录重要的合约操作到区块链日志中。前端可以监听事件来实现实时通知。`DepositSuccessful` 和 `WithdrawSuccessful` 记录了资金流动。",
        indexed_parameter: "📖 `indexed` 关键字标记事件参数，允许前端按该参数过滤和搜索事件日志。这在处理大量事件时非常有用，可以快速找到特定地址相关的事件。",
        transfer_ownership: "📖 `transferOwnership()` 函数实现了合约所有权的转移。只有当前所有者可以调用此函数，并且通常会检查新地址是否有效（非零地址）。",
        onlyOwner_modifier: "📖 `onlyOwner` 修饰符是权限控制的核心机制。它检查 `msg.sender` 是否等于 `owner`，如果不是则回滚交易。这是保护敏感操作（如提款）的标准做法。"
    };
    return hints[conceptKey] || "📖 点击其他概念标签查看更多详细解释。";
};

// ========== Day 12 概念定义 ==========
export const day12ConceptDefinitions = {
    erc20_standard: {
        name: "ERC20 标准",
        icon: "🪙",
        unlockAt: 1,
        message: "你了解了 ERC20 代币标准！它是以太坊上最通用的代币规范，定义了代币的基本功能接口。",
        code: `// ERC20 标准接口
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}`
    },
    mapping_nested: {
        name: "嵌套映射",
        icon: "🗂️",
        unlockAt: 2,
        message: "你发现了嵌套映射 mapping(address => mapping(address => uint256))！这是存储授权额度的核心数据结构。",
        code: `// 嵌套映射：记录每个地址授权给其他地址的额度
mapping(address => mapping(address => uint256)) public allowance;

// 示例：Alice 授权 Carol 使用 500 COM
allowance[Alice][Carol] = 500;  // Carol 可以使用 Alice 的 500 COM`
    },
    event: {
        name: "事件日志",
        icon: "📋",
        unlockAt: 3,
        message: "你触发了事件！Transfer 和 Approval 事件记录了代币的转移和授权操作，前端可以监听这些事件。",
        code: `// 定义事件
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);

// 触发事件
emit Transfer(msg.sender, _to, _value);
emit Approval(msg.sender, _spender, _value);`
    },
    transfer: {
        name: "转账函数",
        icon: "💸",
        unlockAt: 4,
        message: "你使用了 transfer 函数！它是 ERC20 最核心的功能，允许用户将自己的代币转给他人。",
        code: `// 转账函数：调用者将自己的代币转给他人
function transfer(address _to, uint256 _value) public returns (bool) {
    require(balanceOf[msg.sender] >= _value, "Not enough balance");
    _transfer(msg.sender, _to, _value);
    return true;
}`
    },
    approve: {
        name: "授权函数",
        icon: "✅",
        unlockAt: 5,
        message: "你使用了 approve 函数！它允许你授权他人使用你的代币，这是 DeFi 应用的基础机制。",
        code: `// 授权函数：允许 spender 使用调用者的代币
function approve(address _spender, uint256 _value) public returns (bool) {
    allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
}`
    },
    allowance: {
        name: "授权额度",
        icon: "🔍",
        unlockAt: 6,
        message: "你查询了 allowance！它返回被授权者可以使用的代币数量，是授权机制的重要组成部分。",
        code: `// 查询授权额度
function allowance(address _owner, address _spender) 
    public view returns (uint256) {
    return allowance[_owner][_spender];
}

// 使用场景：检查 Carol 还能使用 Alice 多少代币
uint256 remaining = allowance(Alice, Carol);  // 返回剩余额度`
    },
    transferFrom: {
        name: "代转账函数",
        icon: "🔄",
        unlockAt: 7,
        message: "你使用了 transferFrom 函数！它允许被授权者代替他人转账，实现了'第三方代付'功能。",
        code: `// 代转账函数：被授权者从他人账户转账
function transferFrom(address _from, address _to, uint256 _value) 
    public returns (bool) {
    require(balanceOf[_from] >= _value, "Not enough balance");
    require(allowance[_from][msg.sender] >= _value, "Allowance too low");
    
    allowance[_from][msg.sender] -= _value;  // 减少授权额度
    _transfer(_from, _to, _value);
    return true;
}`
    }
};

// ========== Day 12 提示 ==========
export const getDay12Hint = (conceptKey) => {
    const hints = {
        erc20_standard: "🪙 太棒了！你了解了 ERC20 代币标准！这是以太坊上最通用的代币规范。👉 查询 Alice 余额来学习 mapping 存储机制！",
        mapping_nested: "🗂️ 优秀！你了解了嵌套映射！这是 ERC20 授权机制的核心数据结构。👉 转账给 Bob 来学习事件和转账函数！",
        event: "📋 很好！你触发了事件日志！👉 继续探索更多功能！",
        transfer: "💸 太棒了！你使用了 transfer 函数！👉 授权给 Carol 来学习授权机制！",
        approve: "✅ 很好！你使用了 approve 函数！👉 查询 allowance 来学习授权额度查询！",
        allowance: "🔍 优秀！你了解了授权额度查询！👉 切换到 Carol 执行代转账来学习 transferFrom！",
        transferFrom: "🔄 太棒了！你使用了 transferFrom 函数！🎉 你已掌握 ERC20 全部核心功能！"
    };
    return hints[conceptKey] || "📖 点击其他概念标签查看更多详细解释。";
};

// ========== Day 12 概念解释提示 ==========
export const getDay12ExplanationHint = (conceptKey) => {
    const hints = {
        erc20_standard: "📖 ERC20 是以太坊上最常用的代币标准，定义了代币的基本功能接口，包括转账、授权、查询余额等。所有符合 ERC20 标准的代币都可以在支持该标准的钱包和交易所中使用。",
        mapping_nested: "📖 嵌套映射 mapping(address => mapping(address => uint256)) 是 ERC20 中存储授权额度的核心数据结构。外层映射的 key 是代币持有者，内层映射的 key 是被授权者，value 是授权额度。",
        event: "📖 事件（Event）是 Solidity 的日志机制。ERC20 定义了 Transfer 和 Approval 两个标准事件，分别记录代币转移和授权操作。前端可以监听这些事件来实时更新界面。",
        transfer: "📖 transfer 函数是 ERC20 最核心的功能，允许代币持有者将自己的代币转给他人。函数会检查余额是否充足，然后更新双方余额并触发 Transfer 事件。",
        approve: "📖 approve 函数实现了授权机制，允许代币持有者授权他人使用自己的代币。这在 DeFi 应用中非常重要，比如授权 DEX 使用你的代币进行交易。",
        allowance: "📖 allowance 函数用于查询授权额度，返回被授权者还可以使用持有者的代币数量。在执行 transferFrom 之前，通常需要先检查 allowance 是否充足。",
        transferFrom: "📖 transferFrom 函数实现了代转账功能，允许被授权者代替持有者转账。这是 ERC20 的高级功能，常用于需要第三方代为执行转账的场景，如自动扣款、代理交易等。"
    };
    return hints[conceptKey] || "📖 点击其他概念标签查看更多详细解释。";
};

// 保留原有的 getConceptExplanationHint 函数用于其他天数
export { getConceptExplanationHint as default };
