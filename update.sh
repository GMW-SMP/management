#!/bin/bash

PROJ_BASE_DIR=$1
GIT_REPO=git@github.com:GMW-SMP/server.git

cd $PROJ_BASE_DIR/server
git fetch --all
git reset --hard origin/master
