// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 目标：学会 event 和 emit，一切在链上都是透明、可证明的
// event emit 不会改变链上的任何东西，只会发出日志（emit logs）
// 这些日志可以被你的前端或任何正在监听的外部系统捕获。

/**
 * 0. 初始化
 * 1. 注册用户 registerUser，顺便填入身高体重
 * 2. 记录一次运动（类型、持续时长、燃烧多少卡路里、发生的事件）
 * 3. 记录完毕自动调用里程碑检查器，如有复合的事件则触发。
**/ 

contract SimpleFitnessTracker {
    
    struct UserProfile {
        string name;
        uint256 weight; // in kg
        bool isRegistered;
    }

    struct WorkoutData {
        uint256 duration;   // 时长（秒）
        uint256 calories;   // 卡路里
        string activityType;// 运动类型
        uint256 timestamp;  // 发生时间
    }
    
    // 一个用户只能有一个资料，但可以有很多条运动记录
    mapping(address => UserProfile) public userProfiles;
    mapping(address => WorkoutData[]) public fitnessData;
    // 里程碑记录某项运动进行了多少次
    mapping(address => mapping(string => uint256)) private OneTypeCounts;
    // 记录用户打卡次数
    mapping(address => uint256) public totalCounts;
    // 记录一共燃掉了多少卡路里
    mapping(address => uint256) public totalCaloriesBurned;

    // 定义事件
    event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
    event ProfileUpdated(address indexed userAddress, uint256 timestamp);
    event WorkoutRecorded(address indexed user, string activityType, uint256 calories, uint256 duration);
    event WorkoutTimeMilestone(address indexed user, string activityType, uint256 count);
    event CaloriesMilestone(address indexed user, uint256 amount);
    event WorkoutHowManyTimes(address indexed user, uint256 amount);
    // event StreakUpdated(address indexed user, uint256 streakDays);
    
    // 修饰器：检查用户是否已注册
    modifier onlyRegistered() {
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }

    // 注册新用户
    function registerUser(string memory _name, uint256 _weight) external {
        require(!userProfiles[msg.sender].isRegistered, "User already registered");
        require(_weight > 0, "Invalid weight");
        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });
        emit UserRegistered(msg.sender, _name, block.timestamp);
    }

    function updateProfile(string memory _name, uint256 _weight) external{
        // 检查用户是否已经注册
        require(userProfiles[msg.sender].isRegistered, "User not registered!");
        require(_weight > 0, "Invalid weight");
        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });
        emit ProfileUpdated(msg.sender, block.timestamp);
    }

    // 记录运动数据
    function recordWorkout(
        uint256 _duration,
        uint256 _calories,
        string memory _activityType
    ) external onlyRegistered {
        require(_duration > 0, "Duration must be positive");
        
        // 1. 追加运动记录
        fitnessData[msg.sender].push(WorkoutData({
            duration: _duration,
            calories: _calories,
            activityType: _activityType,
            timestamp: block.timestamp
        }));
        
        // 2. 更新总卡路里
        totalCaloriesBurned[msg.sender] += _calories;
        
        // 3. 更新该运动类型的里程碑计数
        OneTypeCounts[msg.sender][_activityType]++;
        totalCounts[msg.sender]++;
        emit WorkoutRecorded(msg.sender, _activityType, _calories, _duration);
        
        // 4. 检查里程碑事件
        checkMilestones(_activityType);
    }

    // 检查里程碑
    function checkMilestones(string memory _activityType) private {
        // 累计某项运动进行了多少次
        if (OneTypeCounts[msg.sender][_activityType] % 10 == 0) {
            emit WorkoutTimeMilestone(msg.sender, _activityType, OneTypeCounts[msg.sender][_activityType]);
        }
        // 累计燃烧了多少卡路里
        if (totalCaloriesBurned[msg.sender] % 1000 == 0) {  // 100km = 100000m
            emit CaloriesMilestone(msg.sender, totalCaloriesBurned[msg.sender]);
        }
        // 累计进行了多少次运动
        if (totalCounts[msg.sender] % 50 ==0) {
            emit WorkoutHowManyTimes(msg.sender, totalCounts[msg.sender]);
        }
    }

}
