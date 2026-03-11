// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleFitnessTracker{
    address public owner;

    // User profile struct
    struct UserProfile{
        string name;
        uint256 weight;
        bool isRegistered;
    }

    // Workout log
    struct WorkoutActivity{
        string activityType;
        uint256 duration; //in seconds
        uint256 distance; //in meters
        uint256 timestamp;
    }

    mapping(address => UserProfile) public userProfiles;
    mapping(address => WorkoutActivity[]) private workoutHistory;

    mapping (address => uint256) public totalWorkouts;
    mapping (address => uint256) public totalDistance;

    event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
    event ProfileUpdated(address indexed userAddress, uint256 newWeight, uint256 timestamp);
    event WorkoutLogged(
        address indexed userAddress,
        string activityType,
        uint256 duration,
        uint256 distance,
        uint256 timestamp);
    event MilestoneAchieved(address indexed userAddress, string milestone, uint256 timestamp);

    constructor(){
        owner = msg.sender;
    }
    
    modifier onlyRegistered(){
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }

    // Register a new user
    function registerUser(string memory _name, uint256 _weight) public {
        require(!userProfiles[msg.sender].isRegistered, "User already registered");
        
        userProfiles[msg.sender] = UserProfile({
            name : _name,
            weight : _weight,
            isRegistered : true
        });

        // Emit registration evet
        emit UserRegistered(msg.sender, _name, block.timestamp);
    }

    // Update user weight (forever)
    function updateWeight(uint256 _newWeight) public onlyRegistered {
        UserProfile storage profile = userProfiles[msg.sender];

        // Check if significant weight loss (>=5%)
        if (_newWeight < profile.weight && (profile.weight - _newWeight)*100/profile.weight >= 5) {
            emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
        }

        profile.weight = _newWeight; // refresh the new weight forever

        // Emit profile update event
        emit ProfileUpdated(msg.sender, _newWeight, block.timestamp);
    }

    // Log a workout activity (forever)
    function logWorkout(
        string memory _activityType,
        uint256 _duration,
        uint256 _distance
    ) public onlyRegistered{
        // Method 1: memory => storage
        // WorkoutActivity memory newWorkout = WorkoutActivity({
        //     activityType : _activityType,
        //     duration : _duration,
        //     distance : _distance,
        //     timestamp : block.timestamp
        // });
        // workoutHistory[msg.sender].push(newWorkout);

        // Method 2: directly storage
        WorkoutActivity storage newWorkout = workoutHistory[msg.sender].push();
        newWorkout.activityType = _activityType;
        newWorkout.duration = _duration;
        newWorkout.distance = _distance;
        newWorkout.timestamp = block.timestamp;

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
        if (totalWorkouts[msg.sender] == 10){
            emit MilestoneAchieved(msg.sender, "10 Workouts Completed", block.timestamp);
        } else if (totalWorkouts[msg.sender] == 50) {
            emit MilestoneAchieved(msg.sender, "50 Workouts Completed", block.timestamp);
        }

        // Check for distance milestones
        if (totalDistance[msg.sender] >= 100000 && totalDistance[msg.sender] - _distance < 100000){
            emit MilestoneAchieved(msg.sender, "100k Total Distance", block.timestamp);
        }
    }

    // Get the number of workouts for a user
    function getUserWorkoutCounts() public view onlyRegistered returns (uint256) {
        return  workoutHistory[msg.sender].length;
    }
}