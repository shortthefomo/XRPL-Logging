#!/usr/bin/env bash

cd "`dirname "$0"`"

export DEBUG=main*

source ./.env
node ./src/index.js &> ./log.txt