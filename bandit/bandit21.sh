#!/usr/bin/env bash

sshpass -p gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr ssh bandit21@bandit.labs.overthewire.org -p 2220

ls /etc/cron.d
cat /etc/cron.d/cronjob_bandit22
# * * * * * bandit22 /usr/bin/cronjob_bandit22.sh &> /dev/null
/usr/bin/cronjob_bandit22.sh
# chmod: changing permissions of '/tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv': Operation not permitted
# /usr/bin/cronjob_bandit22.sh: line 3: /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv: Permission denied
cat /tmp/t7O6lds9S0RqQh9aMcz6ShpAoZKF7fgv
# Yk7owGAcWjwMVRwrTesJEwB7WVOiILLI
