import { DIDDocument } from '@veramo/core';
import { agent, BOB_DID, ALICE_DID } from './setup'


async function main() {

  const identity = await agent.didManagerGet({
    did: `${ALICE_DID}`
  });

  const didResult = (await agent.resolveDid({ didUrl: identity.did })).didDocument

  const didFragment = `${identity.did}#delegate-1`
  const fragment = await agent.getDIDComponentById({
    didDocument: didResult as DIDDocument,
    didUrl: didFragment,
    section: 'verificationMethod'
  })

  console.log(fragment)
}

main().catch(console.log)