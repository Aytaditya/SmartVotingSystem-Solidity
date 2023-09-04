// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoanSystem {
    struct Loan {
        address borrower;
        uint amount;
        bool repaid;
    }

    mapping(address => Loan) public loans;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function lend(address _borrower, uint _amount) public onlyOwner {
        loans[_borrower] = Loan({
            borrower: _borrower,
            amount: _amount,
            repaid: false
        });
    }

    function repayLoan() public payable {
        require(loans[msg.sender].amount <= msg.value, "Insufficient repayment.");
        loans[msg.sender].repaid = true;
        payable(owner).transfer(msg.value);
    }

    function getLoanAmount(address _borrower) public view returns(uint) {
        return loans[_borrower].amount;
    }
}
