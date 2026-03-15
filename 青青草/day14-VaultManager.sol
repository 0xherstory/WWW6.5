// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./day14-IDepositBox.sol";
import "./day14-BasicDepositBox.sol";
import "./day14-PremiumDepositBox.sol";
import "./day14-TimeLockedDepositBox.sol";

contract VaultManager{

    mapping(address => address[]) private userDepositBoxes;
    mapping(address => string)private boxNames;

    event BoxCreated(address indexed owner, address indexed boxAdress, string boxType);
    event BoxNamed(address indexed boxAdress, string name);

    function createBasicBox() external returns (address){

        BasicDepositBox box = new BasicDepositBox();
        userDepositBoxes[msg.sender].push(address(box));
        emit BoxCreated(msg.sender, address(box), "Basic");
        return address(box);
    }

    function createPremiumBox() external returns (address){

        PremiumDepositBox box = new PremiumDepositBox();
        userDepositBoxes[msg.sender].push(address(box));
        emit BoxCreated(msg.sender, address(box), "Premium");
        return address(box);
    }

    function createTimeLockedBox(uint256 lockDuration) external returns (address){
        TimeLockedDepositBox box = new TimeLockedDepositBox(lockDuration);
        userDepositBoxes[msg.sender].push(address(box));
        emit BoxCreated(msg.sender, address(box), "Time Locked");
        return address(box);
    }

    function nameBox(address boxAddress, string memory name ) external{
        IDepositBox box = IDepositBox(boxAddress);
        require(box.getOwner() == msg.sender, "Not the box owner");
        boxNames[boxAddress] = name;
        emit BoxNamed(boxAddress, name);

    }

    function storeSecret(address boxAddress, string calldata secret) external{
        IDepositBox box = IDepositBox(boxAddress);
        require(box.getOwner() == msg.sender, "Not the box owner");
        box.storeSecret(secret);
    }

    function transferBoxOwnership(address boxAddress, address newOwner)  external{
        IDepositBox box = IDepositBox(boxAddress);
        require(box.getOwner() == msg.sender, "Not the box owner");
        box.transferOwnership(newOwner);
        address[] storage boxes = userDepositBoxes[msg.sender];
        uint256 boxIndex = type(uint256).max; // 初始化为无效索引
    // 第一步：找到目标box在列表中的索引
    for (uint256 i = 0; i < boxes.length; i++) {
        if (boxes[i] == boxAddress) {
            boxIndex = i;
            break; // 找到后立即退出循环
        }
    }
    // 校验：确保boxAddress在原主人的列表中
    require(boxIndex != type(uint256).max, "Box not in user's list");

    // 第二步：删除找到的元素（高效删除，保持列表顺序）
    if (boxIndex < boxes.length - 1) {
        boxes[boxIndex] = boxes[boxes.length - 1]; // 最后一个元素覆盖到目标位置
    }
    boxes.pop(); // 删除最后一个元素（避免重复）

    // 3. 执行box所有权转让
    box.transferOwnership(newOwner);

    // 4. 将box添加到新主人的列表中
    userDepositBoxes[newOwner].push(boxAddress);
}

    function getUserBoxes(address user) external view returns(address[] memory){
        return userDepositBoxes[user];
    }

    function getBoxName(address boxAddress) external view returns (string memory) {
    return boxNames[boxAddress];
}

    function getBoxInfo(address boxAddress)external view returns(
        string memory boxType,
        address owner,
        uint256 depositTime,
        string memory name
    ){
        IDepositBox box = IDepositBox(boxAddress);
        return(
            box.getBoxType(),
            box.getOwner(),
            box.getDepositTime(),
            boxNames[boxAddress]
        );
    }

}
