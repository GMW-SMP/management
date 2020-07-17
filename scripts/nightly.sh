#!/bin/bash

bash manage.sh update-management

bash manage.sh stop
# Daily backup, 3 day retention.
bash manage.sh backup daily 3
bash manage.sh update-server
bash manage.sh update-paper
bash manage.sh start
