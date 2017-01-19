#!/bin/bash

chown -R root:root /etc/cron.d/tasks
chmod -R 644 /etc/cron.d/tasks
exec  "$@"