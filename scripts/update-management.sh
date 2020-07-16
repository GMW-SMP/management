#!/bin/bash

git -C ../ fetch --all
git -C ../ reset --hard origin/master
