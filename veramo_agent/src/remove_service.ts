import { agent, BOB_DID, ALICE_DID } from './setup'
import { IDIDManagerRemoveServiceArgs } from '@veramo/core'


async function main() {

  const identity = await agent.didManagerGet({
    did: `${BOB_DID}`
  });

  const service_args: IDIDManagerRemoveServiceArgs = {
    did: identity.did,
    id: '', // Service ID
    options: {
      gas: 100_000, // between 40-60000
      ttl: 60 * 60 * 24 * 365 * 10 // make the service valid for ~10 years
    }
  }
  await agent.didManagerRemoveService(service_args);
}
main().catch(console.log)