// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract WeaponStorePlugin {
    // 存储每个玩家的装备武器
    mapping(address => string) public equippedWeapon;
    
    // 装备武器（外部可调用）
    function setWeapon(address user, string memory weapon) public {
        equippedWeapon[user] = weapon;
    }
    
    // 查询武器（view只读）
    function getWeapon(address user) public view returns (string memory) {
        return equippedWeapon[user];
    }
}