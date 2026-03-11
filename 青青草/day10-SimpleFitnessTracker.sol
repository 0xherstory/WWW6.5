// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleFitnessTracker{
    address public owner;

    struct UserProfile{
        string name;
        uint256 weight;
        bool isRegistered;
    }

    struct WorkoutActivity{
        string activityType;
        uint256 duration;
        uint256 distance;
        uint256 timestamp;//发生时间
    }

    mapping(address => UserProfile) public userProfiles;//为每个用户存储个人资料
    mapping(address => WorkoutActivity[]) private workoutHistory;//为每个用户保存一个锻炼历史数组
    mapping(address => uint256) public totalWorkouts;//追踪每个用户的锻炼次数
    mapping(address => uint256) public totalDistance;//跟踪用户运动的总距离

    //声明事件
    event UserRegistered (address indexed userAddress, string name, uint256 timestamp);
    event ProfileUpdated (address indexed userAddress, uint256 newWeight, uint256 timestamp);
    event WorkoutLogged(address indexed userAddress, string activityType, uint256 duration, uint256 distance, uint256 timestamp);
    event MilestoneAchieved(address indexed userAddress, string milestone, uint timestamp);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyRegistered(){
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }

    function registerUser(string memory _name, uint256 _weight) public{
        require(!userProfiles[msg.sender].isRegistered, "User already registered");

        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight:_weight,
            isRegistered: true
        });

        emit UserRegistered(msg.sender, _name, block.timestamp);
        //发出事件已经在前面写过哦，emit是动态动作，必须配合已经定义的event使用，event是静态声明
    
    }

    //更新体重！
    function updateWeight(uint256 _newWeight) public onlyRegistered{
        UserProfile storage profile = userProfiles[msg.sender];

        if (_newWeight < profile.weight && (profile.weight - _newWeight) * 100 / profile.weight >= 5){
            emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
        }
        //&&是逻辑“和”

        profile.weight = _newWeight;
        emit ProfileUpdated(msg.sender, _newWeight, block.timestamp);
    }

    //追踪训练
    function logWorkout(
        string memory _activityType,
        uint256 _duration,
        uint256 _distance
    ) public onlyRegistered {
        //创建新的训练：
        WorkoutActivity memory newWorkout = WorkoutActivity({
            activityType: _activityType,
            duration: _duration,
            distance: _distance,
            timestamp: block.timestamp
        });
        //添加用户运动历史
        workoutHistory[msg.sender].push(newWorkout);

    

    //更新汇总运动数据
    totalWorkouts[msg.sender]++; //++是自增运算符号，表示+1
    totalDistance[msg.sender] += _distance;

    emit WorkoutLogged(
        msg.sender,
        _activityType,
        _duration,
        _distance,
        block.timestamp
    );
    //刚才这里报错的原因：Solidity 中触发事件（emit）的规则是：emit 事件名(参数) 中传入的参数数量、类型、顺序，必须和 event 定义时完全一致。
    //前面event定义了5个参数，而这里对应的emit漏定义了distance，所以报错！

    //检测并庆祝里程碑
    if (totalWorkouts[msg.sender] == 10){
        emit MilestoneAchieved(msg.sender, "10 Workouts Completed", block.timestamp);
    } else if (totalWorkouts[msg.sender] == 50){
        emit MilestoneAchieved(msg.sender, "50 Workouts Completed", block.timestamp);
    }
    if (totalDistance[msg.sender] >= 100000 && totalDistance[msg.sender] - _distance < 100000){
        emit MilestoneAchieved(msg.sender, "100k Total Distance", block.timestamp);
    }
//注意我们是如何将新的总数与之前的总数（通过减去当前距离）进行比较的——这确保了我们只在用户跨过阈值的那一刻触发一次里程碑。
    }
    function getUserWorkoutCount()public view onlyRegistered returns (uint256){
        return workoutHistory[msg.sender].length;
    }

    //前面已经写过workoutHistory[msg.sender].push(newWorkout)；
    //所以每次调用push，数组的length会自动+1
}