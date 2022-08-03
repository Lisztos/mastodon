import { agent } from './setup'
import { IDIDManagerRemoveServiceArgs } from '@veramo/core'

async function main() {

  const identity = await agent.didManagerGet({
    did: "did:ethr:ropsten:0x02388bbfbce5b69ea8a17887267cb1bcc25b51f68b94db1aab65ca65a07d6daaa4"
  });

  const service_args: IDIDManagerRemoveServiceArgs = {
    did: identity.did,
    id: '#ActivityPub',
    options: {
      gas: 100_000, // between 40-60000
      ttl: 60 * 60 * 24 * 365 * 10 // make the service valid for ~10 years
    }
  }
  await agent.didManagerRemoveService(service_args);

}

main().catch(console.log)