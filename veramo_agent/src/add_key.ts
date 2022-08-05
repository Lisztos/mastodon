import { agent, BOB_DID, ALICE_DID, BOB_PUBLIC_KEY, BOB_PRIVATE_KEY } from './setup'
import { IKey, TKeyType } from "@veramo/core";
import * as u8a from 'uint8arrays'


async function main() {

  const identity = await agent.didManagerGet({
    did: `${BOB_DID}`
  });

  const rsaKeyPair = {
    privateKey: `${BOB_PRIVATE_KEY}`,

    publicKey: `${BOB_PUBLIC_KEY}`
  }
  // construct an `IKey` to be able to send it to DIDManager to be added
  const myKey: IKey = {
    type: "RSA" as TKeyType, // Veramo doesn't really know about RSA keys, but it doesn't matter in this case if we coerce it.
    kms: 'local',
    kid: 'fe068b062aa561d18e0abf21fabc9d0b4539e078115b7a5e768b701db3e9cac3',
    publicKeyHex: u8a.toString(u8a.fromString(rsaKeyPair.publicKey, 'utf-8'), 'base16')
  }


  // add the key to the DID document
  const transactionId = await agent.didManagerAddKey({
    did: identity.did,
    key: myKey,
    options: {
      encoding: 'pem',
      ttl: 60 * 60 * 24 * 365 * 10, // the key will be valid for 10 years
      gas: 100000 // use 100,000 gas at most for this transaction
    }
  })

  // wait for the transaction to mine, then the DID doc will contain the new key
  console.dir(transactionId)
}

main().catch(console.log)