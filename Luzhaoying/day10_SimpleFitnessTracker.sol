//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//发出事件是智能合约暴露数据最节省 Gas 的方式之一
contract SimpleFitnessTracker {
    address public owner;
    // User profile struct
    struct UserProfile {
        string name;
        uint256 weight; 
        bool isRegistered;
    }
    
    struct WorkoutActivity {
        string activityType; 
        uint256 duration;    // in seconds
        uint256 distance;    // in meters
        uint256 timestamp;   
    }
    
    //为每个用户（通过他们的地址）存储一份个人资料
    mapping(address => UserProfile) public userProfiles;
    //为每个用户保存一个锻炼日志数组
    mapping(address => WorkoutActivity[]) private workoutHistory;
    //跟踪每个用户记录了多少次锻炼
    mapping(address => uint256) public totalWorkouts;
    //跟踪用户覆盖的总距离
    mapping(address => uint256) public totalDistance;
    //设置事件
    event UserRegistered(
        address indexed userAddress, 
        string name, 
        uint256 timestamp);
    event ProfileUpdated(
        address indexed userAddress, 
        uint256 newWeight, 
        uint256 timestamp);
    event WorkoutLogged(
        address indexed userAddress, 
        string activityType, 
        uint256 duration, 
        uint256 distance, 
        uint256 timestamp);
    event MilestoneAchieved(
        address indexed userAddress, 
        string milestone, 
        uint256 timestamp);
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyRegistered() {
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }
    
    // Register a new user
    function registerUser(string memory _name, uint256 _weight) public {
        require(!userProfiles[msg.sender].isRegistered, "User already registered");
        
        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });
        
        // Emit registration event
        emit UserRegistered(msg.sender, _name, block.timestamp);
    }
    
    // Update user weight
    function updateWeight(uint256 _newWeight) public onlyRegistered {
        UserProfile storage profile = userProfiles[msg.sender];
        
        // Check if significant weight loss (5% or more)
        if (_newWeight < profile.weight && (profile.weight - _newWeight) * 100 / profile.weight >= 5) {
            emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
        }
        
        profile.weight = _newWeight;
        
        // Emit profile update event
        emit ProfileUpdated(msg.sender, _newWeight, block.timestamp);
    }
    //storage是持久的——它存在于区块链上，读/写都需要消耗 Gas。
    //memory是临时的——它只在函数调用期间存在，而且便宜得多。
    // Log a workout activity
    function logWorkout(
        string memory _activityType,
        uint256 _duration,
        uint256 _distance
    ) public onlyRegistered {
        // Create new workout activity
        WorkoutActivity memory newWorkout = WorkoutActivity({
            activityType: _activityType,
            duration: _duration,
            distance: _distance,
            timestamp: block.timestamp
        });
        
        // Add to user's workout history
        workoutHistory[msg.sender].push(newWorkout);
        
        // Update total stats
        totalWorkouts[msg.sender]++;
        totalDistance[msg.sender] += _distance;
        
        // Emit workout logged event
        emit WorkoutLogged(
            msg.sender,
            _activityType,
            _duration,
            _distance,
            block.timestamp
        );
        
        // Check for workout count milestones
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
    
    // Get the number of workouts for a user
    function getUserWorkoutCount() public view onlyRegistered returns (uint256) {
        return workoutHistory[msg.sender].length;
    }
}