#!/bin/bash

OLD_DIR=$(pwd)
BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ $1 == "start" ]]; then
  shift
  bash ./start.sh $@
elif [[ $1 == "backup" ]]; then
  shift
  bash ./backup.sh $@
elif [[ $1 == "stop" ]]; then
  shift
  bash ./stop.sh $@
elif [[ $1 == "update-paper" ]]; then
  shift
  bash ./update-paper.sh $@
elif [[ $1 == "update-server" ]]; then
  shift
  bash ./update-server.sh $@
elif [[ $1 == "update-management" ]]; then
  shift
  bash ./update-management.sh $@
elif [[ $1 == "nightly" ]]; then
  shift
  bash ./nightly.sh $@
elif [[ $1 == "weekly" ]]; then
  shift
  bash ./weekly.sh $@
fi
