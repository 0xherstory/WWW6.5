//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//虽然这个合约很小，但它会教你 Solidity 中最强大的功能之一：事件（events）。
contract SimpleFitnessTracker {
    address public owner;
    
    // User profile struct
    struct UserProfile {
        string name;
        uint256 weight; 
        bool isRegistered;
    }
    
    /*这个结构体记录了每次锻炼的细节：

- 活动类型（跑步、骑行、游泳等）
- 持续时间（单位：秒）
- 用户运动的距离（单位：米）
- 发生时间（`block.timestamp`）

每当用户记录一次锻炼，我们就会创建一个这样的结构体并将其添加到他们的锻炼历史中。*/
    struct WorkoutActivity {
        string activityType; 
        uint256 duration;    // in seconds
        uint256 distance;    // in meters
        uint256 timestamp;   
    }
    
   
    mapping(address => UserProfile) public userProfiles;
    
    mapping(address => WorkoutActivity[]) private workoutHistory;
    
   
    mapping(address => uint256) public totalWorkouts;
    mapping(address => uint256) public totalDistance;
    
    
    event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
    event ProfileUpdated(address indexed userAddress, uint256 newWeight, uint256 timestamp);
    event WorkoutLogged(
        address indexed userAddress, 
        string activityType, 
        uint256 duration, 
        uint256 distance, 
        uint256 timestamp
    );
    event MilestoneAchieved(address indexed userAddress, string milestone, uint256 timestamp);
    
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