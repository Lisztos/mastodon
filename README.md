![Mastodon](https://i.imgur.com/NhZc40l.png)
========

This Mastodon instance is part of my Bachelor Thesis, where I integrate DIDs and the DIDComm v2 communication Protocol in order to add a decentralized identity management, as well as a confidential, non-repudiable and transport-agnostic communication based on DIDs. 

Adrian Sanchez

-----------


Mastodon is a **free, open-source social network server** based on ActivityPub where users can follow friends and discover new ones. On Mastodon, users can publish anything they want: links, pictures, text, video. All Mastodon servers are interoperable as a federated network (users on one server can seamlessly communicate with users from another one, including non-Mastodon software that implements ActivityPub)!

## Deployment

### Tech stack:

- **Ruby on Rails** powers the REST API and other web pages
- **React.js** and Redux are used for the dynamic parts of the interface
- **Node.js** powers the streaming API

### Requirements:

- **PostgreSQL** 9.5+
- **Redis** 4+
- **Ruby** 2.5+
- **Node.js** 12+


## License

Copyright (C) 2016-2021 Eugen Rochko & other Mastodon contributors (see [AUTHORS.md](AUTHORS.md))

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
