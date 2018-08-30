#!/usr/bin/env bash

sshpass -p BRUTE ssh krypton4@krypton.labs.overthewire.org -p 2222

cd /krypton/krypton4

# did some analysis with the attached script, the key seems to be FREKEY

# the password then decrypts to CLEARTEXT, conveniently.

# I'm starting to think that it would be easier to just guess infosec keywords as passwords



