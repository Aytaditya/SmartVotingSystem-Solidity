//SPDX-License-Identifier: Unliscensed
pragma solidity ^0.6.0;

contract SupplyChain {
  struct Product {
    string name;
    uint quantity;
    address owner;
  }

  mapping(bytes32 => Product) public products;
  bytes32[] public productIds;

  function addProduct(bytes32 _id, string memory _name, uint _quantity) public {
    products[_id] = Product(_name, _quantity, msg.sender);
    productIds.push(_id);
  }

  function transferProduct(bytes32 _id, address _newOwner) public {
    Product storage product = products[_id];
    require(product.owner == msg.sender, "You are not the owner of this product.");
    product.owner = _newOwner;
  }

  function getProduct(bytes32 _id) public view returns (string memory, uint, address) {
    Product storage product = products[_id];
    return (product.name, product.quantity, product.owner);
  }
}
