#!/bin/bash

GIT_REPO=git@github.com:GMW-SMP/server.git

mkdirs -p $STAGING_DIR
git clone $GIT_REPO $STAGING_DIR/server
cp -f $STAGING_DIR/server $PROD_DIR
rm -rf $STAGING_DIR
