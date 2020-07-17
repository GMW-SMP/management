#!/bin/bash

PAPER_BUILD="$(yq r config.yaml paper-build)"
MC_VERSION="$(yq r config.yaml mc-version)"
SERVER_DIR="$(yq r config.yaml server-directory)"

echo "Ensuring PaperMC installation is V$MC_VERSION #$PAPER_BUILD"
if [[ ! -f $SERVER_DIR/version_history.json || ! -f $SERVER_DIR/paper.jar ]]; then
    echo "Missing files detected, downloading latest Paper build for Minecraft $MC_VERSION."
    wget https://papermc.io/api/v1/paper/$MC_VERSION/$PAPER_BUILD/download -O $SERVER_DIR/paper.jar
  else
    CURRENT_BUILD=`cat $SERVER_DIR/version_history.json | jq '.currentVersion' | cut -d'-' -f 3 | cut -d' ' -f 1`
    LATEST_BUILD=`curl -s https://papermc.io/api/v1/paper/$MC_VERSION/latest | jq '.build' | cut -d'"' -f 2`

    if [[ $PAPER_BUILD == "latest" ]]; then
      echo "Current Paper $MC_VERSION installed build is #$CURRENT_BUILD. Server is configured to the use latest build (#$LATEST_BUILD)"
      if [[ $CURRENT_BUILD != $LATEST_BUILD ]]; then
        echo "Updating Paper to build #$LATEST_BUILD."
        wget https://papermc.io/api/v1/paper/$MC_VERSION/latest/download -O $SERVER_DIR/paper.jar
      fi
    else
      echo "Current Paper $MC_VERSION installed build is #$CURRENT_BUILD. Server is configured to use build $PAPER_BUILD"
      if [[ $CURRENT_BUILD != $PAPER_BUILD ]]; then
        echo "Updating Paper to build #$PAPER_BUILD."
        wget https://papermc.io/api/v1/paper/$MC_VERSION/$PAPER_BUILD/download -O $SERVER_DIR/paper.jar
      fi
    fi
  fi
