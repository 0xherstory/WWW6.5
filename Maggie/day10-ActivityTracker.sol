// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ActivityTracker{
    address public owner;

    //User profile struct
    struct UserProfile {
        string name;
        uint weight;
        bool isRegistered;
    }

    struct WorkoutActivity {
        string activityType;
        uint duration;
        uint distance;
        uint timestamp;
    }

    mapping (address => UserProfile) public userProfiles;
    mapping (address => WorkoutActivity[]) private  workoutHistory;
    mapping (address => uint) public totalWorkouts;
    mapping (address => uint) public totalDistance;

    event UserRegistered(address indexed userAdress, string name, uint timestamp);
    event ProfileUpdated(address indexed userAdress, uint nesweight, uint timestamp);
    event WorkLogged(address indexed userAdress, string activityType, uint duration, uint distance, uint timestamp);
    event MilestoneAchieved(address indexed userAdress, string milestone, uint timestamp);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyRegistered() {
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }

    //Register a new user
    function registerUser(string memory _name, uint _weight) public {
        require(!userProfiles[msg.sender].isRegistered, "User already registered");

        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });

        //Emit registration
        emit UserRegistered(msg.sender, _name, block.timestamp);
    }

    //Update user weight
    function updateWeight(uint _newweight) public onlyRegistered {
        UserProfile storage profile = userProfiles[msg.sender];

        //Check if significant weight loss
        if (_newweight < profile.weight && (profile.weight - _newweight) *100 /profile.weight >= 5) {
            emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
        }

        profile.weight = _newweight;

        emit ProfileUpdated(msg.sender, _newweight, block.timestamp);
    }

    //Log a workout activity
    function logWorkout(string memory _activityType, uint _duration, uint _distance) public onlyRegistered {
        
        //Create new workout activity
        WorkoutActivity memory newWorkout = WorkoutActivity ({
            activityType: _activityType,
            duration: _duration,
            distance: _distance,
            timestamp: block.timestamp
        });

        //Add to user's workout history
        workoutHistory[msg.sender].push(newWorkout);

        //Update total stats
        totalWorkouts[msg.sender]++;
        totalDistance[msg.sender] += _distance; 

        //Emit workout logged event
        emit WorkLogged(msg.sender, _activityType, _duration, _distance, block.timestamp);

        //Check for workout count milestones
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
