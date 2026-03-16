// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
  @notice 功能插件库合约
 */

 contract PluginStore{
    //  玩家基本资料
    struct PlayerProfile{
        string nickname;  // 昵称
        string avatar; // 头像
    }

    mapping(address => PlayerProfile) public profiles;

    // multi-plugin support
    mapping(string => address) public plugins;

    // player profile logic
    function setProfile(string memory _name, string memory _avatar) external{
        profiles[msg.sender] = PlayerProfile(_name, _avatar);
    } 

    function getProfile(address _player) external view returns(string memory, string memory){
        PlayerProfile memory profile = profiles[_player];
        return (profile.nickname, profile.avatar);
    }

    // --- plugin management ----
    // 注册插件
    function registerPlugin(string memory _key, address _pluginAddress) external{
        plugins[_key] = _pluginAddress;
    }

    function getPlugin(string memory _key) external view returns(address){
        return plugins[_key];
    }

    // ------ plugin execution ------
    function runPlugin(
        string memory _key,
        string memory _functionSignature, // 函数签名，也就是插件对应的可执行函数
        address _player,
        string memory argument
    ) external{

        address plugin = plugins[_key];
        require(plugin != address(0), "Plugin not registered");

        bytes memory data = abi.encodeWithSignature(_functionSignature, _player, argument);
        (bool success,) = plugin.call(data);
        require(success, "Plugin execution failed");
    }

    function runPluginView(
        string memory _key,
        string memory _functionSignature,
        address _player
    )external view returns(string memory){
        address plugin = plugins[_key];
        require(plugin != address(0), "Plugin not registered");

        bytes memory data = abi.encodeWithSignature(_functionSignature, _player);
        (bool success,bytes memory result) = plugin.staticcall(data);
        require(success, "Plugin view call failed");

        return abi.decode(result, (string));
    }

 }

 /**
 知识点：
 1. 本合约展示了通过 函数签名+abi编码+call(staticcall | delegatecall) 实现
 灵活的可拓展的插件功能。
 作用：是的核心逻辑简单，功能按需插入。
  */