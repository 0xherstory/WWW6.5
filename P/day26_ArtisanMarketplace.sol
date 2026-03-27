// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721 {
    function ownerOf(uint256 tokenId) external view returns (address);
    function transferFrom(address from, address to, uint256 tokenId) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function getApproved(uint256 tokenId) external view returns (address);
}

contract ArtisanMarketplace {

    struct Listing {
        address seller;
        address nftAddress;
        uint256 tokenId;
        uint256 price;
        address royaltyRecipient;
        uint256 royaltyFeeBP; 
        bool active;
    }

    address public owner;
    address public feeRecipient;
    uint256 public platformFeeBP; 
    uint256 public constant MAX_BP = 10000;

    mapping(address => mapping(uint256 => Listing)) private listings;


    event NFTListed(address indexed seller, address indexed nft, uint256 indexed id, uint256 price);
    event NFTPurchased(address indexed buyer, address indexed nft, uint256 indexed id, uint256 price);
    event ListingCancelled(address indexed nft, uint256 indexed id);
    event PlatformFeeUpdated(uint256 newFee);
    event FeeRecipientUpdated(address newRecipient);


    error InvalidParams();
    error Unauthorized();
    error NotListed();
    error PriceNotMet();
    error TransferFailed();
    error ReentrancyAttempt();

    uint256 private _status; 
    modifier nonReentrant() {
        if (_status == 1) revert ReentrancyAttempt();
        _status = 1;
        _;
        _status = 0;
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert Unauthorized();
        _;
    }

    constructor(uint256 _initialFee, address _feeRecipient) {
        if (_initialFee > 1000 || _feeRecipient == address(0)) revert InvalidParams();
        owner = msg.sender;
        feeRecipient = _feeRecipient;
        platformFeeBP = _initialFee;
        _status = 0;
    }


    function setPlatformFee(uint256 _newFee) external onlyOwner {
        if (_newFee > 1000) revert InvalidParams();
        platformFeeBP = _newFee;
        emit PlatformFeeUpdated(_newFee);
    }

    function setFeeRecipient(address _newRecipient) external onlyOwner {
        if (_newRecipient == address(0)) revert InvalidParams();
        feeRecipient = _newRecipient;
        emit FeeRecipientUpdated(_newRecipient);
    }


    function listNFT(
        address _nftAddress,
        uint256 _tokenId,
        uint256 _price,
        address _royaltyRecipient,
        uint256 _royaltyBP
    ) external {
        if (_price == 0 || _royaltyBP > 1000) revert InvalidParams();
        
        IERC721 nft = IERC721(_nftAddress);
        if (nft.ownerOf(_tokenId) != msg.sender) revert Unauthorized();
        

        if (nft.getApproved(_tokenId) != address(this) && !nft.isApprovedForAll(msg.sender, address(this))) {
            revert Unauthorized();
        }

        listings[_nftAddress][_tokenId] = Listing({
            seller: msg.sender,
            nftAddress: _nftAddress,
            tokenId: _tokenId,
            price: _price,
            royaltyRecipient: _royaltyRecipient,
            royaltyFeeBP: _royaltyBP,
            active: true
        });

        emit NFTListed(msg.sender, _nftAddress, _tokenId, _price);
    }


    function buyNFT(address _nftAddress, uint256 _tokenId) external payable nonReentrant {
        Listing storage listing = listings[_nftAddress][_tokenId];
        if (!listing.active) revert NotListed();
        if (msg.value != listing.price) revert PriceNotMet();

        listing.active = false; 


        uint256 platformFee = (listing.price * platformFeeBP) / MAX_BP;
        uint256 royaltyFee = (listing.price * listing.royaltyFeeBP) / MAX_BP;
        uint256 sellerProceeds = listing.price - platformFee - royaltyFee;


        if (platformFee > 0) {
            _safeTransferETH(feeRecipient, platformFee);
        }


        if (royaltyFee > 0 && listing.royaltyRecipient != address(0)) {
            _safeTransferETH(listing.royaltyRecipient, royaltyFee);
        }


        _safeTransferETH(listing.seller, sellerProceeds);


        IERC721(_nftAddress).transferFrom(listing.seller, msg.sender, _tokenId);

        emit NFTPurchased(msg.sender, _nftAddress, _tokenId, listing.price);
        delete listings[_nftAddress][_tokenId];
    }


    function cancelListing(address _nftAddress, uint256 _tokenId) external {
        Listing memory listing = listings[_nftAddress][_tokenId];
        if (!listing.active) revert NotListed();
        if (listing.seller != msg.sender) revert Unauthorized();

        delete listings[_nftAddress][_tokenId];
        emit ListingCancelled(_nftAddress, _tokenId);
    }


    function _safeTransferETH(address _to, uint256 _amount) internal {
        (bool success, ) = payable(_to).call{value: _amount}("");
        if (!success) revert TransferFailed();
    }

    function getListing(address _nftAddress, uint256 _tokenId) external view returns (Listing memory) {
        return listings[_nftAddress][_tokenId];
    }

    receive() external payable { revert("Direct deposits not allowed"); }
    fallback() external payable { revert("Function not found"); }
}