#!/bin/sh

rm -f .env

echo DB_SERVER=<DB_ENDPOINT> >> .env

user=$(curl  -H "X-Vault-Token: $VAULT_TOKEN" \
        -X GET http://<VAULT_ENDPOINT>:8200/v1/database/creds/mynewrole)
echo DB_USER=$(echo $user | jq -r .data.username) >> .env
echo DB_PASSWORD=$(echo $user | jq -r .data.password) >> .env

docker-compose up -d --build
