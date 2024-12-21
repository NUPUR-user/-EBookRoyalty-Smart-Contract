# EBookRoyalty Smart Contract

## Project Description

EBookRoyalty is a decentralized platform that enables authors to publish their eBooks as NFTs (ERC721 tokens) on the blockchain. Through this platform, authors can set a price for their book, define a royalty percentage, and receive automated payments every time their book is purchased. Buyers, in turn, gain ownership of the eBooks as NFTs, ensuring transparent and secure transactions.

This smart contract ensures:
- **NFT-based book ownership**: Each book is represented as an ERC721 token, giving buyers verifiable ownership.
- **Automated royalties**: Authors automatically receive royalties on every book sale, proportional to the royalty percentage set at the time of publication.
- **Customizable pricing**: Authors have full control over the pricing of their books, which they can update as needed.
- **Active/inactive book status**: Authors can toggle the availability of their books (active or inactive), providing flexibility in distribution.

## Contract Address
0xd577A8930c267b388370287ADd2FCf46E73fb211

## Project Vision

The vision behind **EBookRoyalty** is to create a decentralized marketplace for eBooks, where authors retain full control over their works and earn a fair share of the proceeds. By leveraging blockchain technology, we aim to provide a transparent and efficient method of distributing royalties, while also ensuring secure and immutable ownership for readers.

We believe this platform can empower authors globally, simplify royalty distribution, and create a more sustainable and fair ecosystem in the digital book industry.

## Key Features

- **Decentralized Publishing**: Authors can publish their eBooks as NFTs, giving them full control over their content and ownership rights.
- **Royalty Payments**: Authors receive royalties from each book sale automatically, based on the percentage they set at publication.
- **ERC721 Tokenization**: Books are tokenized as ERC721 tokens, allowing readers to purchase and transfer books as verifiable assets.
- **Dynamic Pricing**: Authors can modify the price of their books at any time, keeping up with market demands and changing circumstances.
- **Toggle Book Availability**: Authors can activate or deactivate their books, enabling temporary sales pauses or exclusive releases.
- **Secure and Transparent**: The contract uses `ReentrancyGuard` to protect against reentrancy attacks, ensuring safe transactions.
- **Easy Access to Author's Books**: Readers can view the complete list of books published by a specific author through the platform.


## Usage

### Publish a Book
Authors can publish their book by calling the `publishBook` function:
```solidity
function publishBook(string memory _title, uint256 _price, uint256 _royaltyPercentage) external returns (uint256);

### Explanation of Additions:
- **Future Enhancements**: A section listing potential features to improve and expand the platform over time. This helps set the stage for ongoing development and can also inspire collaboration from other developers.
