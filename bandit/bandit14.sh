#!/usr/bin/env bash

ssh -i sshkey.private bandit14@localhost
nc localhost 30000 < /etc/bandit_pass/bandit14
