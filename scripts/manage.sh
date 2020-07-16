#!/bin/bash

# Debugging
# set -x

OLD_DIR=$(pwd)
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $BASE_DIR

if [[ $1 == "start" ]]; then
  shift
  bash ./scripts/start.sh $@
elif [[ $1 == "backup" ]]; then
  shift
  bash ./scripts/backup.sh $@
elif [[ $1 == "stop" ]]; then
  shift
  bash ./scripts/stop.sh $@
elif [[ $1 == "update-paper" ]]; then
  shift
  bash ./scripts/update-paper.sh $@
elif [[ $1 == "update-server" ]]; then
  shift
  bash ./scripts/update-server.sh $@
elif [[ $1 == "update-management" ]]; then
  shift
  bash ./scripts/update-management.sh $@
fi

cd $OLD_DIR
