#!/bin/bash 

if [ ! -f /data/.env ]; then
    printf "/data/.env file not found\n"
    ls -la /data 
    exit 1
fi

# shellcheck source=/dev/null
source /data/.env
DB_HOST=${1}
while true; do
    cmd=$( (mongo --host "${DB_HOST}" --quiet --eval "print(db.runCommand({ping:1}).ok)" 2>&1 >/dev/null) && printf "%s" "$?")
    printf "Return %s\n" "$cmd"
    if [ "${cmd}" == '0' ]; then
        break
    fi
    printf "Waiting for MongoDB to be ready...\n"
    sleep 1
done

printf "MongoDB is ready!\n"

mongo --host "${DB_HOST}" \
    --username "${MONGO_INITDB_ROOT_USERNAME}" \
    --password "${MONGO_INITDB_ROOT_PASSWORD}" \
    --authenticationDatabase "${MONGO_INITDB_DATABASE}" \
    --eval "
    if (rs.status().code == 94) {
        rs.initiate(
        {
            _id: '${MONGO_REPLICA_NAME}',
            version: 1,
            members: [
                { _id: 0, host: 'mongo0:27017' },
                { _id: 1, host: 'mongo1:27018' },
                { _id: 2, host: 'mongo2:27019', arbiterOnly: true }
            ]
        }
        );
    }
    "

exit 0
