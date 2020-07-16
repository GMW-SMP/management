#!/bin/bash

bash ../smp update-management

bash ../smp stop
sleep 10
# Daily backup, 3 day retention.
bash ../smp backup daily 3
bash ../smp update-server
bash ../smp update-paper
bash ../smp start
