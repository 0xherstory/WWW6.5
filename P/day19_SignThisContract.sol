// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract SecureEventCheckIn {
    address public immutable organizer;
    string public eventName;
    bool public isEventActive;
    uint256 public totalAttendees;

    mapping(address => bool) public hasAttended;

    error EventNotActive();
    error AlreadyAttended();
    error InvalidSignature();
    error NotOrganizer();

    constructor(string memory _name) {
        organizer = msg.sender;
        eventName = _name;
        isEventActive = true;
    }
    function getMessageHash(address _attendee) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_attendee));
    }
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _messageHash));
    }

    function verify(address _attendee, uint8 v, bytes32 r, bytes32 s) public view returns (bool) {
        bytes32 messageHash = getMessageHash(_attendee);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return ecrecover(ethSignedMessageHash, v, r, s) == organizer;
    }
    function checkIn(uint8 v, bytes32 r, bytes32 s) external {
        if (!isEventActive) revert EventNotActive();
        if (hasAttended[msg.sender]) revert AlreadyAttended();
        if (!verify(msg.sender, v, r, s)) revert InvalidSignature();
        hasAttended[msg.sender] = true;
        totalAttendees++;
    }
    function batchCheckIn(address[] calldata _attendees) external {
        if (msg.sender != organizer) revert NotOrganizer();
        
        uint256 len = _attendees.length;
        for (uint256 i = 0; i < len; ) {
            address attendee = _attendees[i];
            if (!hasAttended[attendee]) {
                hasAttended[attendee] = true;
                totalAttendees++;
            }
            unchecked { i++; }
        }
    }

    function toggleEventStatus() external {
        if (msg.sender != organizer) revert NotOrganizer();
        isEventActive = !isEventActive;
    }
}