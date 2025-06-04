// Core interfaces
import { createAgent, IDIDManager, IResolver, IDataStore, IKeyManager } from '@veramo/core'

import { ethers } from 'ethers';

// Core identity manager plugin
import { DIDManager } from '@veramo/did-manager'

// Ethr did identity provider
import { EthrDIDProvider } from '@veramo/did-provider-ethr'

// Web did identity provider
import { WebDIDProvider } from '@veramo/did-provider-web'

// Core key manager plugin
import { KeyManager } from '@veramo/key-manager'

// Custom key management system for RN
import { KeyManagementSystem, SecretBox } from '@veramo/kms-local'

// Custom resolvers
import { DIDResolverPlugin } from '@veramo/did-resolver'
import { Resolver } from 'did-resolver'
import { getResolver as ethrDidResolver } from 'ethr-did-resolver'
import { getResolver as webDidResolver } from 'web-did-resolver'

// Storage plugin using TypeOrm
import { Entities, KeyStore, DIDStore, IDataStoreORM, PrivateKeyStore, migrations } from '@veramo/data-store'

// TypeORM is installed with `@veramo/data-store`
import { createConnection } from 'typeorm'

import * as dotenv from 'dotenv';

dotenv.config();

export const ALICE_DID = process.env.ALICE_DID;
export const ALICE_PUBLIC_KEY = process.env.ALICE_DID;
export const ALICE_PRIVATE_KEY = process.env.ALICE_DID;
export const BOB_DID = process.env.BOB_DID;
export const BOB_PUBLIC_KEY = process.env.BOB_PUBLIC_KEY;
export const BOB_PRIVATE_KEY = process.env.BOB_PRIVATE_KEY;
const INFURA_PROJECT_ID = process.env.INFURA_PROJECT_ID;

// This will be the name for the local sqlite database for demo purposes
const DATABASE_FILE = 'database.sqlite';

// This will be the secret key for the KMS
const KMS_SECRET_KEY = process.env.KMS_SECRET_KEY;

const PROVIDER = new ethers.providers.InfuraProvider(
  'ropsten',
  INFURA_PROJECT_ID
);

const dbConnection = createConnection({
  type: 'sqlite',
  database: DATABASE_FILE,
  synchronize: false,
  migrations,
  migrationsRun: true,
  logging: ['error', 'info', 'warn'],
  entities: Entities,
})

export const agent = createAgent<IDIDManager & IKeyManager & IDataStore & IDataStoreORM & IResolver>({
  plugins: [
    new KeyManager({
      store: new KeyStore(dbConnection),
      kms: {
        local: new KeyManagementSystem(new PrivateKeyStore(dbConnection, new SecretBox(KMS_SECRET_KEY))),
      },
    }),
    new DIDManager({
      store: new DIDStore(dbConnection),
      defaultProvider: 'did:ethr:ropsten',
      providers: {
        'did:ethr:ropsten': new EthrDIDProvider({
          web3Provider: PROVIDER,
          defaultKms: 'local',
          network: 'ropsten',
          rpcUrl: 'https://ropsten.infura.io/v3/' + INFURA_PROJECT_ID,
        }),
        'did:web': new WebDIDProvider({
          defaultKms: 'local',
        }),
      },
    }),
    new DIDResolverPlugin({
      resolver: new Resolver({
        ...ethrDidResolver({ infuraProjectId: INFURA_PROJECT_ID }),
        ...webDidResolver(),
      }),
    }),
  ],
})