# Veramo agent for did:ethr CRUD operations

## Description
The following code includes: 

* Setup code for Agent. [Veramo Guides](https://veramo.io/docs/node_tutorials/node_setup_identifiers)
* Creating a DID using the did:ethr method in the ropsten Network. 
* Adding and removing a service
* Adding and removing a key
* Custom method to add RSA key with pem encoding. **NOT DID Complaint**
* List all identifiers created
* Resolve a DID

## Deployment

You can follow the steps [here](https://veramo.io/docs/node_tutorials/node_setup_identifiers).

You will need an .env file with the following variables: 

**INFURA_PROJECT_ID**

The rest can are optional and can be updated afterwards.

## Good to know

In order to do any operations, you need to fund the DID. For this, go to any Faucet and fund the blockchainAccountID of the DID. Which you can find when you resolve your DID using the resolver in code or the [Universal resolver](https://dev.uniresolver.io/) from the DID. 

 




