// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPlugin {
    function getPluginType() external pure returns (string memory);
}

contract PlayerProfile {

    address public admin;
    string public name;
    string public avatar;

    mapping(string => address) public registry;
    

    mapping(string => string) public extendedProperties;

    error CallFailed();
    error PluginNotFound();

    constructor(string memory _name, string memory _avatar) {
        admin = msg.sender;
        name = _name;
        avatar = _avatar;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Not Admin");
        _;
    }

    function registerPlugin(string calldata _key, address _pluginAddr) external onlyAdmin {
        registry[_key] = _pluginAddr;
    }

    function runPluginWrite(string calldata _key, bytes calldata _data) external returns (bytes memory) {
        address plugin = registry[_key];
        if (plugin == address(0)) revert PluginNotFound();

        (bool success, bytes memory result) = plugin.call(_data);
        if (!success) revert CallFailed();
        return result;
    }


    function runPluginView(string calldata _key, bytes calldata _data) external view returns (bytes memory) {
        address plugin = registry[_key];
        if (plugin == address(0)) revert PluginNotFound();

        (bool success, bytes memory result) = plugin.staticcall(_data);
        if (!success) revert CallFailed();
        return result;
    }


    function runPluginDelegate(string calldata _key, bytes calldata _data) external returns (bytes memory) {
        address plugin = registry[_key];
        if (plugin == address(0)) revert PluginNotFound();


        (bool success, bytes memory result) = plugin.delegatecall(_data);
        if (!success) revert CallFailed();
        return result;
    }
}


contract AchievementsPlugin {

    mapping(address => string) public medals;

    function unlockAchievement(address _player, string calldata _medal) external {
        medals[_player] = _medal;
    }

    function getMedal(address _player) external view returns (string memory) {
        return medals[_player];
    }
}


contract SocialPlugin {

    address public admin;
    string public name;
    string public avatar;
    mapping(string => address) public registry;
    mapping(string => string) public extendedProperties; 

    function updateTwitter(string calldata _handle) external {

        extendedProperties["TWITTER"] = _handle;
    }
}


contract WeaponPlugin {
    function getWeaponStats(uint256 _id) external pure returns (string memory) {
        if (_id == 1) return "Excalibur: ATK 999";
        return "Wooden Stick: ATK 1";
    }
}