#!/bin/bash

bash update-management.sh

bash stop.sh
# Daily backup, 3 day retention.
bash backup.sh daily 3
bash update-server.sh
bash update-paper.sh
bash start.sh
