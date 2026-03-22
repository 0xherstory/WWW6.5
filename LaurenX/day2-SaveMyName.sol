//SPDX-License-Identifier:MIT

pragma solidity ^ 0.8.0;

contract SaveMyName {

    string name;
    //字符串类型：string（字串；用来展示信息，不适计算，gas消费最多）
    // bytes32(固定长度32个字节，可直接比较，适合装密码，短ID等，gas消费最少）
    // bytes(区别于string,可以装任何东西，电脑二进制0和1）

    string bio;
//搬家 memory:临时储存 calldata:只读临时储存
function add(string memory _name, string memory _bio) public {
    name = _name;
    bio = _bio;
}

//展示
    //只读函数
    function retrieve() public view returns (string memory, string memory){
        return(name, bio);//检索数据
    }
    
//合并 
    function saveAndRetrieve(string memory _name, string memory _bio) 
    public returns (string memory, string memory) {
    name = _name;
    bio = _bio;
    return (name, bio);
}

}
