// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleFitnessTracker {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // 限制函数只能由已注册用户调用
    modifier onlyRegistered {
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }

    // 存储用户基本信息
    struct UserProfile {
        string name;
        uint256 weight; // in kg
        bool isRegistered;
    }

    // 存储单次锻炼的详细信息
    struct WorkoutActivity {
        string activityType;
        uint256 duration; // in seconds
        uint256 distance; // in meters
        uint256 timestamp;
    }

    // (地址 => 用户资料) 的映射
    mapping(address => UserProfile) public userProfiles;
    // (地址 => 锻炼活动数组) 的映射
    mapping(address => WorkoutActivity[]) private workoutHistory;
    // (地址 => 总锻炼次数) 的映射
    mapping(address => uint256) public totalWorkouts;
    // (地址 => 总距离) 的映射
    mapping(address => uint256) public totalDistance;

    // indexed: 可搜索 在一个事件中，你最多只能索引三个参数。
    // 用户成功注册时触发
    event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
    // 用户更新个人资料（如体重）时触发
    event ProfileUpdated(address indexed userAddress, uint256 newWeight, uint256 timestamp);
    // 用户记录一次新的锻炼时触发
    event WorkoutLogged(address indexed userAddress, string activityType, uint256 duration, uint256 distance, uint256 timestamp);
    // 用户达成一个里程碑（如10次锻炼）时触发
    event MilestoneAchieved(address indexed userAddress, string milestone, uint256 timestamp);

    // 注册一个新用户，记录姓名和体重
    function registerUser(string memory _name, uint256 _weight) public {
        require(!userProfiles[msg.sender].isRegistered, "User already registered");

        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _name, block.timestamp);
    }

    // 更新用户的体重，并检查是否达到减重里程碑
    function updateWeight(uint256 _newWeight) public onlyRegistered {
        // storage是持久的——它存在于区块链上，读/写都需要消耗 Gas。
        UserProfile storage profile = userProfiles[msg.sender];
        if (_newWeight < profile.weight && (profile.weight - _newWeight) * 100 / profile.weight >= 5) {
            emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
        }
        profile.weight = _newWeight;
        emit ProfileUpdated(msg.sender, _newWeight, block.timestamp);
    }

    // 记录一次新的锻炼活动，并检查是否达到锻炼里程碑
    function logWorkout(string memory _activityType, uint256 _duration, uint256 _distance) public onlyRegistered {
        // memory是临时的——它只在函数调用期间存在，而且便宜得多。
        WorkoutActivity memory workOutActivity = WorkoutActivity({
            activityType: _activityType,
            duration: _duration,
            distance: _distance,
            timestamp: block.timestamp
        });
        workoutHistory[msg.sender].push(workOutActivity);
        totalWorkouts[msg.sender]++;
        totalDistance[msg.sender] += _distance;
        emit WorkoutLogged(msg.sender, _activityType, _duration, _distance, block.timestamp);

        if (totalWorkouts[msg.sender] == 10) {
            emit MilestoneAchieved(msg.sender, "10 Workouts Completed", block.timestamp);
        } else if (totalWorkouts[msg.sender] == 50) {
            emit MilestoneAchieved(msg.sender, "50 Workouts Completed", block.timestamp);
        }

        // Check for distance milestones
        if (totalDistance[msg.sender] >= 100000 && totalDistance[msg.sender] - _distance < 100000) {
            emit MilestoneAchieved(msg.sender, "100K Total Distance", block.timestamp);
        }
    }

    // 获取指定用户的总锻炼次数
    function getUserWorkoutCount() public view onlyRegistered returns (uint256){
        return workoutHistory[msg.sender].length;
    }

}
