#!/bin/bash

MC_DIR = $1

if test -f "$MC_DIR"; then
  rm -r $MC_DIR/plugins
fi
