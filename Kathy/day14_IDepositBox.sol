// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//金库接口
interface IDepositBox {
    function getOwner() external view returns (address);
    function transferOwnership(address newOwner) external;
    function storeSecret(string calldata secret) external;
    function getSecret() external view returns (string memory);
    function getBoxType() external pure returns (string memory); // 存款箱类型：基础or高级
    function getDepositTime() external  view returns (uint256); // 存款箱创建的时间
}
