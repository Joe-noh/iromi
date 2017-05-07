#! /bin/bash

set -e

helm install \
  --name kago-db \
  --namespace iromi-dev \
  --set postgresUser=postgres,postgresPassword=postgres,postgresDatabase=kago_dev \
  stable/postgresql
