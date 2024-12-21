// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract EBookRoyalty is ERC721, Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;
    Counters.Counter private _bookIds;

    struct Book {
        string title;
        string authorName;
        uint256 price;
        uint256 royaltyPercentage;
        address payable author;
        bool isActive;
    }

    mapping(uint256 => Book) public books;
    mapping(address => uint256[]) public authorBooks;
    mapping(uint256 => mapping(address => bool)) public bookPurchases;

    event BookPublished(uint256 indexed bookId, string title, address author, uint256 price);
    event BookPurchased(uint256 indexed bookId, address buyer, uint256 price);
    event RoyaltyPaid(uint256 indexed bookId, address author, uint256 amount);

    constructor() 
        ERC721("Educational eBook", "EBOOK") 
        Ownable(msg.sender)  // Using msg.sender as the initial owner
    {}

    function publishBook(
        string memory _title,
        uint256 _price,
        uint256 _royaltyPercentage
    ) external returns (uint256) {
        require(_royaltyPercentage <= 100, "Royalty percentage must be between 0 and 100");
        require(_price > 0, "Price must be greater than 0");

        _bookIds.increment();
        uint256 newBookId = _bookIds.current();

        books[newBookId] = Book({
            title: _title,
            authorName: "",
            price: _price,
            royaltyPercentage: _royaltyPercentage,
            author: payable(msg.sender),
            isActive: true
        });

        authorBooks[msg.sender].push(newBookId);
        emit BookPublished(newBookId, _title, msg.sender, _price);

        return newBookId;
    }

    function purchaseBook(uint256 _bookId) external payable nonReentrant {
        require(books[_bookId].isActive, "Book is not active");
        require(!bookPurchases[_bookId][msg.sender], "Already purchased this book");
        require(msg.value >= books[_bookId].price, "Insufficient payment");

        Book storage book = books[_bookId];
        uint256 royaltyAmount = (msg.value * book.royaltyPercentage) / 100;
        
        // Transfer royalty to author
        book.author.transfer(royaltyAmount);
        
        // Mark book as purchased for this buyer
        bookPurchases[_bookId][msg.sender] = true;

        emit BookPurchased(_bookId, msg.sender, msg.value);
        emit RoyaltyPaid(_bookId, book.author, royaltyAmount);
    }

    function updateBookPrice(uint256 _bookId, uint256 _newPrice) external {
        require(books[_bookId].author == msg.sender, "Only author can update price");
        require(_newPrice > 0, "Price must be greater than 0");
        
        books[_bookId].price = _newPrice;
    }

    function toggleBookStatus(uint256 _bookId) external {
        require(books[_bookId].author == msg.sender, "Only author can toggle status");
        books[_bookId].isActive = !books[_bookId].isActive;
    }

    function getAuthorBooks(address _author) external view returns (uint256[] memory) {
        return authorBooks[_author];
    }

    function getBookDetails(uint256 _bookId) external view returns (
        string memory title,
        address author,
        uint256 price,
        uint256 royaltyPercentage,
        bool isActive
    ) {
        Book storage book = books[_bookId];
        return (
            book.title,
            book.author,
            book.price,
            book.royaltyPercentage,
            book.isActive
        );
    }
}