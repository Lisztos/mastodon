![Mastodon](https://i.imgur.com/NhZc40l.png)
========

This Mastodon instance is part of my Bachelor Thesis, where I integrate DIDs and the DIDComm v2 communication Protocol in order to add a decentralized identity management, as well as a confidential, non-repudiable and transport-agnostic communication based on DIDs. 

Adrian Sanchez

The code is running on the TU server: https://tawki.snet.tu-berlin.de/

| Service      |      Description       |    Port   |
| -----------  | --------------------   | ----------|
| Web          | Main Rails application |  3000     |
| Streaming    | React app              |  4000     |
| DB           | Postgres databas       |  4000     |
| Nginx        | Reverse Proxy          |  80, 443  |
| ES           | Elastic Search         |           |
| Redis        | In-memory data store   |           |
| Sidekiq      | Background processing  |           |
| DID resolver | Takes DID and DID doc. |           |
| uni-resolver | Driver for did:ethr    |           |

-----------


Mastodon is a **free, open-source social network server** based on ActivityPub where users can follow friends and discover new ones. On Mastodon, users can publish anything they want: links, pictures, text, video. All Mastodon servers are interoperable as a federated network (users on one server can seamlessly communicate with users from another one, including non-Mastodon software that implements ActivityPub)!

### Tech stack:
----
- **Ruby on Rails** powers the REST API and other web pages
- **React.js** and Redux are used for the dynamic parts of the interface
- **Node.js** powers the streaming API

### Requirements:
-----
- **PostgreSQL** 9.5+
- **Redis** 4+
- **Ruby** 2.5+
- **Node.js** 12+


### Deployment
-------
Configure Nginx: 

*  First, clone the project
    
    ```
    git clone https://gitlab.com/Lisztos/mastodon 
    ```
*   Quick install nginx
    ```
    sudo apt update && sudo apt install nginx
    ```
    
* Copy configuration file from the repository sample to the Nginx folder
  
    ```
    cp ~/root/mastodon/nginx.conf.sample /etc/nginx/sites-available/
    ```

* Rename with your domain name
  ```
    mv /etc/nginx/sites-available/nginx.conf.sample /etc/nginx/sites-available/your-domain.com.conf
  ```
    
* Update the configuration file with your domain information 
  ``` 
    nano /etc/nginx/sites-available/your-domain.com.conf
  ```

* Activate the Nginx configuration
  ```
    cd /etc/nginx/sites-enabled
    ln -s ../sites-available/your-domain.com.conf
    sudo systemctl stop nginx
  ```
* Open ports 80 and 443 (using UFW)
  ```
    sudo apt install ufw
    sudo ufw allow Nginx Full
  ```

* Get SSL certificate using Let's encrypt
  ```
    sudo apt install certbot
    certbot certonly --standalone -d your-domain.com
  ```
  
* Start Nginx
    ```
    sudo systemctl start nginx
    ```

Build for development

* Build main image
  ```
    docker build -f Dockerfile.dev -t mastodon:dev .
  ```

* Create and start container
  ```
    docker-compose up -d
  ```

* Restart Nginx 
  ```
    sudo systemctl restart nginx
  ```

* When everything is running, we need to run the migrations
  ```
    docker-compose exec web rails db:migrate
  ```




## License

Copyright (C) 2016-2021 Eugen Rochko & other Mastodon contributors (see [AUTHORS.md](AUTHORS.md))

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
