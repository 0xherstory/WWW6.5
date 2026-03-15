// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleFitnessTracker {
    struct UserProfile {
        string name;
        uint256 weight;     
        bool isRegistered;
    }

    struct WorkoutActivity {
        string activityType;
        uint256 duration;    
        uint256 distance;    
        uint256 timestamp;
    }


    mapping(address => UserProfile) public userProfiles;
    mapping(address => WorkoutActivity[]) private workoutHistory;
    mapping(address => uint256) public totalWorkouts;
    mapping(address => uint256) public totalDistance;


    event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
    event ProfileUpdated(address indexed userAddress, uint256 newWeight, uint256 timestamp);
    event WorkoutLogged(address indexed userAddress, string activityType, uint256 duration, uint256 distance, uint256 timestamp);
    event MilestoneAchieved(address indexed userAddress, string milestone, uint256 timestamp);


    modifier onlyRegistered() {
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }


    function registerUser(string calldata _name, uint256 _weight) external {
        require(!userProfiles[msg.sender].isRegistered, "User already registered");
        require(_weight > 0, "Weight must be greater than 0");

        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _name, block.timestamp);
    }

   
    function updateWeight(uint256 _newWeight) external onlyRegistered {
        UserProfile storage profile = userProfiles[msg.sender];
        uint256 oldWeight = profile.weight;

     
        if (_newWeight < oldWeight) {
            uint256 weightLoss = oldWeight - _newWeight;
            if ((weightLoss * 100) / oldWeight >= 5) {
                emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
            }
        }

        profile.weight = _newWeight;
        emit ProfileUpdated(msg.sender, _newWeight, block.timestamp);
    }


    function logWorkout(
        string calldata _activityType,
        uint256 _duration,
        uint256 _distance
    ) external onlyRegistered {
   
        workoutHistory[msg.sender].push(WorkoutActivity({
            activityType: _activityType,
            duration: _duration,
            distance: _distance,
            timestamp: block.timestamp
        }));


        totalWorkouts[msg.sender]++;
        totalDistance[msg.sender] += _distance;

     
        emit WorkoutLogged(msg.sender, _activityType, _duration, _distance, block.timestamp);

 
        uint256 currentCount = totalWorkouts[msg.sender];
        if (currentCount == 10) {
            emit MilestoneAchieved(msg.sender, "10 Workouts Completed", block.timestamp);
        } else if (currentCount == 50) {
            emit MilestoneAchieved(msg.sender, "50 Workouts Completed", block.timestamp);
        }

 
        uint256 currentDistance = totalDistance[msg.sender];
        if (currentDistance >= 100000 && (currentDistance - _distance) < 100000) {
            emit MilestoneAchieved(msg.sender, "100K Total Distance", block.timestamp);
        }
    }


    function getUserWorkoutCount(address _user) external view returns (uint256) {
        return workoutHistory[_user].length;
    }

    function getWorkoutEntry(address _user, uint256 _index) external view returns (WorkoutActivity memory) {
        require(_index < workoutHistory[_user].length, "Index out of bounds");
        return workoutHistory[_user][_index];
    }
}