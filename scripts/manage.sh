#!/bin/bash

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
fi
