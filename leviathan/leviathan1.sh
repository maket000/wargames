#!/usr/bin/env bash

sshpass -p rioGegei8m ssh leviathan1@leviathan.labs.overthewire.org -p 2223

strings check

# "sex secret love god", weird, "sex" works as a password for ./check, so cool, I guess

./check

cat /etc/leviathan_pass/leviathan2
