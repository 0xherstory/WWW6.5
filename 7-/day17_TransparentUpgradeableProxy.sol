// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TransparentUpgradeableProxy {
    address public implementation;
    address public admin;

    event Upgraded(address indexed newImplementation);

    constructor(address _logic, address _admin) {
        implementation = _logic;
        admin = _admin;
    }

    // 升级逻辑合约（升级中心权限）
    function upgradeTo(address newImplementation) external {
        require(msg.sender == admin, "Proxy: not admin");
        implementation = newImplementation;
        emit Upgraded(newImplementation);
    }

    // 加上这行 → 警告立刻消失
    receive() external payable {}

    fallback() external payable {
        address _impl = implementation;
        require(_impl != address(0), "Proxy: no implementation");

        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}