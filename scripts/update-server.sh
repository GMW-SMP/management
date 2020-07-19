#!/bin/bash

MC_DIR="$(yq r config.yaml server-directory)"
STAGING_DIR=$MC_DIR/../staging/

# Close server if running.
TMUX_SESSION=$(yq r config.yaml tmux-session-name)
tmux has-session -t $TMUX_SESSION 2>/dev/null
if [[ $? == 0 ]]; then
  RESTART_SERVER=1
  echo "Running server detected, shutting down before proceeding..."
  bash stop.sh
fi

mkdir -p $STAGING_DIR
git clone $(yq r config.yaml packages-repo) $STAGING_DIR/packages/

# Git reset and server update.
if [[ -d "$MC_DIR" ]]; then
  rm $MC_DIR/plugins/*.jar
  git -C $MC_DIR fetch --all
  git -C $MC_DIR reset --hard origin/master
  mv $STAGING_DIR/packages/*.jar $MC_DIR/plugins
else
  git clone $(yq r config.yaml server-repo) $MC_DIR
  mv $STAGING_DIR/packages/* $MC_DIR/plugins
fi

# Cleanup
rm -rf $STAGING_DIR

if [[ $RESTART_SERVER == 1 ]]; then
  echo "Server was previously running, starting it again now."
  bash start.sh
fi
