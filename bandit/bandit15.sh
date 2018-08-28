#!/usr/bin/env bash

sshpass -p BfMYroe26WYalil77FoDi9qh59eK5xNr ssh bandit15@bandit.labs.overthewire.org -p 2220
cat /etc/bandit_pass/bandit15 | openssl s_client -connect localhost:30001 -ign_eof
