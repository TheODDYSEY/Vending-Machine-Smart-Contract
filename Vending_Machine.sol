// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine {

    // State variables
    address public owner;

    enum Category { DRINKS, FOODS }

    struct Product {
        string name;
        uint price;
        uint stock;
        string image;
    }

    // Mapping of categories to products
    mapping(Category => mapping(uint => Product)) public products;
    mapping(address => Product[]) public purchases;  // List of products purchased by buyers

    uint public productIdCount;  // Unique identifier for products

    // Event to log purchases
    event ProductPurchased(address indexed buyer, string productName, uint quantity);

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action.");
        _;
    }

    // Constructor sets the contract deployer as the owner
    constructor() {
        owner = msg.sender;
        productIdCount = 0;
    }

    // Add or update a product (only the owner can call this)
    function setProduct(Category category, string memory name, uint price, uint stock, string memory image) public onlyOwner {
        products[category][productIdCount] = Product(name, price, stock, image);
        productIdCount++;
    }

    // Restock an existing product (only the owner can call this)
    function restockProduct(Category category, uint productId, uint additionalStock) public onlyOwner {
        products[category][productId].stock += additionalStock;
    }

    // Purchase a product
    function buyProduct(Category category, uint productId, uint quantity) public payable {
        Product storage product = products[category][productId];
        
        require(product.stock >= quantity, "Not enough stock available.");
        require(msg.value >= product.price * quantity, "Insufficient ETH sent.");

        product.stock -= quantity;
        purchases[msg.sender].push(product);  // Record the purchase
        
        emit ProductPurchased(msg.sender, product.name, quantity);
    }

    // Get the balance of the contract
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Owner can withdraw ETH from the contract
    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        require(balance > 0, "No balance available to withdraw.");
        payable(owner).transfer(balance);
    }

    // Get product details
    function getProduct(Category category, uint productId) public view returns (string memory, uint, uint, string memory) {
        Product memory product = products[category][productId];
        return (product.name, product.price, product.stock, product.image);
    }

    // Get user's purchased products
    function getPurchases(address buyer) public view returns (Product[] memory) {
        return purchases[buyer];
    }
}
