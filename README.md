# Mongo Replica Arbiter Boilerplate on Docker Compose


## How to use this boilerplate

- Clone this repository
- Create `key.txt` file with the following command:
        
        openssl rand -base64 756 > key.txt

-  Copy `example.env` to `.env` and adjust the values to your needs.

        cp example.env .env
- Run `docker-compose up` or `docker-compose up -d`

## Environment Variables Description
| Variable | Description | Default |
| --- | --- | --- |
| MONGO_IMAGE | Set the MongoDB version | mongo:4 |
| MONGO_INITDB_ROOT_USERNAME | Set the MongoDB root user name | root |
| MONGO_INITDB_ROOT_PASSWORD | Set the MongoDB root password | password |
| MONGO_REPLICA_NAME | Set the MongoDB replica name | rs0 |
| UID | Set the UID for the MongoDB containers | 999 |
| GID | Set the GID for the MongoDB containers | 999 |
| MONGO_INITDB_HOST | Set the MongoDB host (container name) we want to connect to provision `mongo-setup` container | mongo0 |

