#!/bin/bash

MC_VERSION=1.16.1

if [[ ! -f version_history.json || ! -f paper ]]; then
    echo "Missing files detected, downloading latest Paper build for Minecraft $MC_VERSION."
    wget https://papermc.io/api/v1/paper/$MC_VERSION/latest/download -O paper-$MC_VERSION.jar
  else
    CURRENT_BUILD=`cat version_history.json | jq '.currentVersion' | cut -d'-' -f 3 | cut -d' ' -f 1`
    LATEST_BUILD=`curl -s https://papermc.io/api/v1/paper/$MC_VERSION/latest | jq '.build' | cut -d'"' -f 2`

    echo "Current Paper $MC_VERSION build, $CURRENT_BUILD. Latest build, $LATEST_BUILD."

    if [[ $CURRENT_BUILD != $LATEST_BUILD ]]; then
      echo "Current build out of date, downloading latest Paper build for Minecraft $MC_VERSION."
      wget https://papermc.io/api/v1/paper/$MC_VERSION/latest/download -O paper-$MC_VERSION.jar
    fi
  fi