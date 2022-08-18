# 301NFT

This project demonstrates a basic 301NFT use case. It comes with a  contract, a test for that contract, and a script that deploys that contract.

The steps to from scratch:
1. Open the terminal, create a new folder called "301NFT" and install Hardhat running the following command:
```shell
yarn add hardhat
```
2. Then initialize hardhat to create the project boilerplates:
```shell
npx hardhat init
```
3. Select "Create a basic sample project" and confirm all default options
4. Install the OpenZeppelin smart contract library:
```shell
yarn add @openzeppelin/contracts
npm install @openzeppelin/contracts-upgradeable
```
5. Modify the hardhat.config.js file
```shell
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks: {
    mumbai: {
      url: process.env.TESTNET_RPC,
      accounts: [process.env.PRIVATE_KEY]
    },
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY
  }
};
```
6. NFTs with On-Chain Metadata: Develop the Smart Contract
NFT.sol
7. Create the Deployment Script deploy.js
```shell
const main = async () => {
    try {
      const nftContractFactory = await hre.ethers.getContractFactory(
        "NFT"
      );
      const nftContract = await nftContractFactory.deploy();
      await nftContract.deployed();
  
      console.log("Contract deployed to:", nftContract.address);
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
    
  main();
```
8. Compile and Deploy the smart contract
```shell
npx hardhat compile
```
```shell
npx hardhat run scripts/deploy.js --network mumbai
```
Write down contract address "Contract deployed to:"
9. Check your smart contract on Polygon Scan
Copy the address of the just deployed smart contract, go to mumbai.polygonscan.com, and paste the address of the smart contract in the search bar.
10. Verify the smart contract
```shell
npx hardhat verify --network mumbai 0x27e46Ac10Ec72c6f8affAf5780D3daf0DfDb016a
```
Sometimes you might get the error "failed to send contract verification request" - just try again and it should go through.
11. Interact with your Smart Contract Through Polygon Scan
Now that the Smart Contract has been verified, go to mumbai.polygonscan.com to interact with it, and mint the first NFT, click on the "Write Contract" button under the "contract" tab, and click on "connect to Web3".
Then look for the "mint" function and click on Write button.
This will open a Metamask popup that will ask you to pay for the gas fees, click on the sign button.

Congratulations! You've just minted your first dynamic NFT - let's move to OpenSea Testnet to see it live.
12. View your Dynamic NFT On OpenSea
Copy the smart contract address, go to testnet.opensea.com, and paste it into the search bar.
13. Update the Dynamic NFT Image Training The NFT
Navigate back to mumbai.polygonscan.com, click on the contract tab > Write Contract and look for the "train" function.
Insert the ID of your NFT - "1" in this case, as we minted only one, and click on Write button.
Sign and confirm the transaction.
Then go back to testnets.opensea.com and refresh the page to see the updated image.



