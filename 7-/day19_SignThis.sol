// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SignatureVerify {
    // 验签函数：验证消息是否由某个地址签名
    function verify(
        address signer,
        string memory message,
        bytes memory signature
    ) public pure returns (bool) {
        // 拼接以太坊签名消息格式
        bytes32 hash = keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            keccak256(abi.encodePacked(message))
        ));
        
        // 验证签名
        (bytes32 r, bytes32 s, uint8 v) = splitSignature(signature);
        return ecrecover(hash, v, r, s) == signer;
    }

    // 拆分签名
    function splitSignature(bytes memory sig)
        public
        pure
        returns (bytes32 r, bytes32 s, uint8 v)
    {
        require(sig.length == 65, "invalid signature length");

        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
    }
}