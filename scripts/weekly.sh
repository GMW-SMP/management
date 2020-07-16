#!/bin/bash

bash ../smp update-management

bash ../smp stop
# Weekly backup, 14 day retention.
bash ../smp backup weekly 14
bash ../smp update-server
bash ../smp update-paper
bash ../smp start
