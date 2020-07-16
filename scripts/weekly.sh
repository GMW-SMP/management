#!/bin/bash

./smp stop
# Weekly backup, 14 day retention.
./smp backup weekly 14
./smp start
