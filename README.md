## FundeMe Solidity Contract

### Overview
The FundMe contract is a simple Solidity contract that allows users to fund the contract with Ethereum and enables the owner to withdraw the funds. It ensures that users can only fund the contract if their contribution meets a minimum value in USD.

### Features

**Get Funds from Users**: Users can send ETH to the contract.

**Withdraw Funds**: The contract owner can withdraw the accumulated funds.

**Minimum Funding Value in USD**: Ensures contributions meet a set minimum value in USD.


### Testing and Deployment
**Testing**

The contract was tested using MetaMask on the Sepolia test network. Ensure that you have MetaMask installed and configured for Sepolia.

**Deployment**

The contract was successfully deployed on the zkSync network. Follow these steps for deployment:

- Open Remix.
- Copy and paste the FundMe.sol code into a new Solidity file.
- Compile the contract.
- Deploy the contract to your desired Ethereum network (on my case, I used zkSync).