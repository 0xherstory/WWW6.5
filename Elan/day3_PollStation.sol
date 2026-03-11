// SPDX-License-Identifier：MIT
pragma solidity ^0.8.0;

contract PollSation {
  struct Poll {
    string question;
    uint256 upvotes;
    uint256 downvotes;
  }
Poll[] public polls;
function createPoll(string memory _question) public {
    Poll memory newPoll = Poll({
        question: _question,
        upvotes: 0,
        downvotes: 0
    });
    polls.push(newPoll);
   }
}