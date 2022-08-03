import { agent, BOB_DID, ALICE_DID } from './setup'
import { IDIDManagerAddServiceArgs } from '@veramo/core'


async function main() {
  
  const identity = await agent.didManagerGet({
     did: `${ALICE_DID}`
  });

  const service_args: IDIDManagerAddServiceArgs = {
    did: identity.did,
    service: {
      id: 'ActivityPub',
      type: "ActivityPub",
      serviceEndpoint: "https://lisztos.com/users/@" + identity.did,
      description: "DIDComm enabled ActivityPub Actor"
    },
    options: {
      gas: 100_000, // between 40-60000
      ttl: 60 * 60 * 24 * 365 * 10 // make the service valid for ~10 years
    }
  }
  await agent.didManagerAddService(service_args);
}
main().catch(console.log)