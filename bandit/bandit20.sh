#!/usr/bin/env bash

sshpass -p GbKksEFF4yrVs6il55v6gwY5aVje5f0j ssh bandit20@bandit.labs.overthewire.org -p 2220
nc -l 42069 < /etc/bandit_pass/bandit20 & ./suconnect 42069
GbKksEFF4yrVs6il55v6gwY5aVje5f0j
Password matches, sending next password
gE269g2h3mw3pwgrj0Ha9Uoqen1c9DGr
