#!/bin/bash

function readconf() {
  local confval = $(yq r ../config.yaml $1)
  echo "$confval"
}

MC_DIR = $(readconf server-directory)
STAGING_DIR = $MC_DIR/../staging/

# Close server if running.
TMUX_SESSION = $(readconf tmux-session-name)
tmux has-session -t $TMUX_SESSION 2>/dev/null
if [ $? != 0 ]; then
  echo "Running server detected, shutting down before proceeding..."
  source ./shutdown.sh
fi

mkdir -p $STAGING_DIR
git clone $(readconf packages-repo) $STAGING_DIR/packages/

# Git reset and server update.
if [[ -f "$MC_DIR" ]]; then
  rm -r $MC_DIR/plugins
  git --git-dir $MC_DIR fetch --all
  git --git-dir $MC_DIR reset --hard origin/master
  mv $STAGING_DIR/packages/* $MC_DIR/plugins
else
  git clone $(readconf server-repo) $MC_DIR
  mv $STAGING_DIR/packages/* $MC_DIR/plugins
fi

# Cleanup
rm -r $STAGING_DIR

# TODO implement automatic server start when flag is given.
