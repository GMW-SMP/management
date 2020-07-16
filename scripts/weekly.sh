#!/bin/bash

./smp stop
# Daily backup, 2 day retention.
./smp backup daily 2
./smp update-server
./smp update-paper
./smp start
