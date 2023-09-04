//SPDX-License-Identifier: Unlicesensed
pragma solidity ^0.8.0;

contract Voting {
  struct Voter {
    bool voted;
    uint vote;
  }

  struct Proposal {
    string name;
    uint voteCount;
  }

  address public owner;
  mapping(address => Voter) public voters;
  Proposal[] public proposals;

  constructor() public {
    owner = msg.sender;
  }

  function newProposal(string memory _name) public {
    require(msg.sender == owner, "Proposals can be added only by owners.");
    proposals.push(Proposal(_name, 0));
  }

  function vote(uint _proposalId) public {
    require(_proposalId < proposals.length, "ID is invalid");
    Voter storage voter = voters[msg.sender];
    require(!voter.voted, "OOPs! You have voted");

    voter.voted = true;
    voter.vote = _proposalId;
    proposals[_proposalId].voteCount++;
  }

  function getResults() public view returns (uint[], uint[]) {
    uint[] memory proposalIds = new uint[](proposals.length);
    uint[] memory voteCounts = new uint[](proposals.length);
    for (uint i = 0; i < proposals.length; i++) {
      proposalIds[i] = i;
      voteCounts[i] = proposals[i].voteCount;
    }
    return (proposalIds, voteCounts);
  }
}
