import { agent } from './setup'

async function main() {
  const identifiers = await agent.didManagerFind()

  console.log(`There are ${identifiers.length} identifiers`)

  if (identifiers.length > 0) {
    console.log(identifiers[1].keys)
    identifiers.map((keys) => {
      console.log(keys)
      console.log('..................')
    })
  }
}

main().catch(console.log)