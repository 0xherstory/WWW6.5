// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleNFT {
    // NFT 名称 + 符号
    string public name;
    string public symbol;

    // tokenID 对应的拥有者
    mapping(uint256 => address) private _owners;
    // 用户拥有的 NFT 数量
    mapping(address => uint256) private _balances;
    // tokenURI 存储图片/元数据
    mapping(uint256 => string) private _tokenURIs;

    // 事件
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Mint(address indexed to, uint256 tokenId, string uri);

    // 构造函数：设置 NFT 名称和代号
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // 铸造 NFT（核心功能）
    function mint(address to, uint256 tokenId, string calldata uri) external {
        require(to != address(0), "Mint to zero address");
        require(_owners[tokenId] == address(0), "Token already exists");

        _owners[tokenId] = to;
        _balances[to] += 1;
        _tokenURIs[tokenId] = uri;

        emit Transfer(address(0), to, tokenId);
        emit Mint(to, tokenId, uri);
    }

    // 查询 NFT 拥有者
    function ownerOf(uint256 tokenId) external view returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "Token does not exist");
        return owner;
    }

    // 查询用户拥有多少个 NFT
    function balanceOf(address owner) external view returns (uint256) {
        require(owner != address(0), "Balance query for zero address");
        return _balances[owner];
    }

    // 查询 NFT 的链接（图片/信息）
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        require(_owners[tokenId] != address(0), "Token does not exist");
        return _tokenURIs[tokenId];
    }

    // 转账 NFT
    function transferFrom(address from, address to, uint256 tokenId) external {
        require(_owners[tokenId] == from, "Not owner of token");
        require(to != address(0), "Transfer to zero address");
        
        _owners[tokenId] = to;
        _balances[from] -= 1;
        _balances[to] += 1;
        
        emit Transfer(from, to, tokenId);
    }
}