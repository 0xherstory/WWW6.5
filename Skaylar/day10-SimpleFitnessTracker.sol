//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

// 我需要创建一个用于追踪健身房会员打卡的系统
//会员登记表：姓名
//会员基础信息表：姓名、身高、体重、是否已注册
//单次运动记录明细表：姓名、运动类型、运动时间、开始时间、运动距离

contract SimpleFitnessTracker {

    address public owner;
    // 用户资料
    struct UserProfile {
    string name ;
    uint256 weight;
    bool isRegisted;}

    //运动记录
    struct  WorkoutRecord {
        string  workoutTybes;
        string name;
        uint256 workoutTime;
        uint256 workoutDistance;
        uint256 timestamp;
    }
    //用户信息表
    mapping(address => UserProfile) public userprofile;
    //用户的运动记录
    mapping(address=> WorkoutRecord[]) private workoutrecord;
    //用户运动总次数
    mapping(address => uint256) public totalworkouttimes;
    //用户运动总距离
    mapping(address => uint256) public totalworkoutdistance;

    //用户注册、用户运动后新纪录的更新（体重、运动时长、运动距离、总运动表） 事件
    event UserRegistered (
        address indexed userAddress,
        string name,
        uint256 timestamp
    );

    event UserWeight(
        address indexed userAddress,
        uint256 newweight,
        uint256 timestamp
    );

    event UserAchieved(
        address indexed userAddress,
        string milestone,
        uint256 timestamp
    );

    event Workoutlogged(
        address indexed  userAddress,
        string  workoutTypes,
        uint256 duration,
        uint256 distance,
        uint256 timestamp
    );

    constructor() {
        owner = msg.sender;
    }
    
    modifier onlyRegistered() {
        require(userprofile[msg.sender].isRegisted, "User not registered");
        _;
    }
    //注册新会员，需排除重复注册
    function AddeUser(string memory _name, uint256 _weight) public  {
        require(!userprofile[msg.sender].isRegisted, "User already registered.");

        userprofile[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegisted : true
        });

        emit UserRegistered(msg.sender, _name, block.timestamp);
    }
    // 更新体重
    function UpdateUserweight(uint256 _newweight) public onlyRegistered(){
        UserProfile storage Newweight = userprofile[msg.sender];

        //判断用户是否减重5%以上，是，广播通知
        if ( _newweight <Newweight.weight- Newweight.weight *5 / 100) {
            emit UserAchieved(msg.sender,"Weight Goal Reached",block.timestamp);
        }
        Newweight.weight = _newweight;

        emit UserWeight( msg.sender,_newweight, block.timestamp);
    }

    //记录运动
    function logWorkout( string memory _newWorkout, uint256 _duration, uint256 _distance) public onlyRegistered{

        //创建运动记录
       WorkoutRecord memory NewWorkout = WorkoutRecord({
            workoutTybes:_newWorkout,
            name: userprofile[msg.sender].name,
            workoutTime :_duration,
            workoutDistance :_distance,
            timestamp :block.timestamp
        });

        //存入记录
        workoutrecord[msg.sender].push(NewWorkout);
        //更新表格
        totalworkouttimes[msg.sender]++;
        totalworkoutdistance[msg.sender]+= _distance;

        //触发时间
        emit Workoutlogged(msg.sender, _newWorkout,_duration,_distance,block.timestamp);

        //检查运动次数里程碑
        if(totalworkouttimes[msg.sender] == 10) {
            emit UserAchieved(msg.sender, "10 Workouts Completed",block.timestamp);
            }

            else if (totalworkouttimes[msg.sender] == 50) {
             emit UserAchieved(msg.sender, "50 Workouts Completed",block.timestamp);
        }
        
        //检查运动距离里程碑

        if (totalworkoutdistance[msg.sender] >= 100000 && totalworkoutdistance[msg.sender] -_distance < 100000) {
            emit UserAchieved(msg.sender, "100K Total Distance",block.timestamp);
        }     

    }
        // 查询运动次数

        function getWorkoutTimes() public view onlyRegistered returns (uint256) {
            return workoutrecord[msg.sender].length;
        }
    
    }   
  
    
