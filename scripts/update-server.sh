#!/bin/bash

PROJ_BASE_DIR=$1

cd $PROJ_BASE_DIR/server
git fetch --all
git reset --hard origin/master
