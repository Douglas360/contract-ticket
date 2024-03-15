// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventTicket{
    struct Ticket{
      string eventName;
      uint256 price;
      address owner;
      bool isUsed;  
    }

    mapping (uint256 => Ticket) public tickets;
    uint256 public ticketId = 0;

    function createTicket(string memory _eventName, uint256 _price) public{
        ticketId++;
        tickets[ticketId] = Ticket(_eventName, _price, msg.sender, false);
    }

    function buyTicket(uint256 _ticketId)public payable {
        require(msg.value >= tickets[_ticketId].price, "Saldo insuficiente");
        tickets[_ticketId].owner = msg.sender;
    }

    function useTicket(uint256 _ticketId)public{
        require(!tickets[_ticketId].isUsed, "Ticket ja usado");
        require(tickets[_ticketId].owner == msg.sender, "Esse ticket nao e seu");

        tickets[_ticketId].isUsed = true;
    }
}
