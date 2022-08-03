import { agent, BOB_DID, ALICE_DID } from './setup'


async function main() {

  const identity = await agent.didManagerGet({
    did: `${ALICE_DID}`
  });

  // add the key to the DID document
  const transactionId = await agent.didManagerRemoveKey({
    did: identity.did,
    kid: "did:ethr:ropsten:0x036ba8c76bb54bdfaa29abc9d0fcf4d884623d72066848b8a0a418ddda8633ff65#delegate-1",
    options: {
      ttl: 60 * 60 * 24 * 365 * 10, // the key will be valid for 10 years
      gas: 100000 // use 100,000 gas at most for this transaction
    }
  })

  // wait for the transaction to mine, then the DID doc will contain the new key
  console.dir(transactionId)

}

main().catch(console.log)