#!/usr/bin/env bash

sshpass -p CAESARISEASY ssh krypton3@krypton.labs.overthewire.org -p 2222

cd /krypton/krypton3
cat found* krypton4 | grep -o .  | sort | uniq -c

# S is most frequent, so it is likely E->S, (14)
krypton3@krypton:/krypton/krypton3$ cat krypton4 | tr "S-ZA-R" "E-ZA-D"
#WEHHI NSEVP EHEUE HJNYZ KCGGW NZIOG MZYVE

# it wasn't that, I tried some other caesar cipher keys, but none worked, so we'll have to do some more complicated analysis to figure out what is likely just a generic substitution cipher

cat krypton* krypton4 > krypton3.data

# I wrote a small script to find n-graph frequncies for the ciphertext, the most common trigraph in the english language is "THE", and the most common trigraph in our ciphertext was "JDS" so we assume that JDS -> THE
# We'll also make the assumption that Q->a because of single letter frequencies
# We'll `tr` to lowercase to distinguish decrypted from encrypted letters

cat krypton3.data | tr "JDSQ" "thea"

# U has a pretty high frequency, and if we assume that the string "PASS" will be in the password text, then the only double letter that appears after "a", in this case "U", so "U -> s", this also implies Y->p

cat krypton3.data | tr "JDSQUY" "theasp"

# Let's see what the text looks like if we assume that the 4 letters after "pass" are word

cat krypton3.data | tr "JDSQUYKBNW" "theaspword"

# Everything looks fine still, we see some words stick out "ZCpher" and "shaFespeare" appear here and there, let's see what happens if we add some more substititions assuming that those are "cipher" and "shakespeare"

cat krypton3.data | tr "JDSQUYKBNWZCF" "theaspwordcik"

# "prosecMtioG" -> "prosecution" implies "M->u" and "G->n"

cat krypton3.data | tr "JDSQUYKBNWZCFMG" "theaspwordcikun"

# "coTTunicate" -> "communicate" implies "T->m"

cat krypton3.data | tr "JDSQUYKBNWZCFMGT" "theaspwordcikunm"

# At this point the end of our text has "weVVdonetheVeIeVXourpasswordisArute"
# Obviously "V->l" "I->v" "X->f" from this, but we really need to find what A maps to

cat krypton3.data | tr "JDSQUYKBNWZCFMGTVIX" "theaspwordcikunmlvf"

# We see "Aetween" "Aaptised", so our password is "BRUTE"
