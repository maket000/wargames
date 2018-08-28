## Vortex Level 0 → Level 1
### Connect and Sum

Problem page: <http://overthewire.org/wargames/vortex/vortex0.html>

The first vortex level is very straightforward, you need to connect to the vortex lab over port 5842 receive 4 numbers, sum them, send that sum back, and then receive ssh login credentials for the vortex1 user on the vortex lab.

We could do this in any language, but since this one is easy enough that we might as well make things harder on ourselves by using C.

```C
#include <netdb.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>

int main() {
  const char *url = "vortex.labs.overthewire.org";
  const char *port = "5842";

  // Create addrinfo
  struct addrinfo hints, *res;
  memset(&hints, 0, sizeof(hints));
  hints.ai_family = AF_UNSPEC;
  hints.ai_socktype = SOCK_STREAM;
  getaddrinfo(url, port, &hints, &res);

  // Create and connect socket
  int sockfd;
  sockfd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
  connect(sockfd, res->ai_addr, res->ai_addrlen);

  // Get sum
  unsigned int sum = 0, buf;
  for (int i = 0; i < 4; i++) {
    recv(sockfd, &buf, 4, 0);
    sum += buf;
  }
  // Send sum
  send(sockfd, &sum, 4, 0);

  // Get credentials
  char credbuf[1024];
  recv(sockfd, credbuf, 1024, 0);
  printf("%s\n", credbuf);

  // Clean up
  close(sockfd);
  freeaddrinfo(res);

  return 0;
}
```

Pretty long-winded, but it gets the job done.

```console
maket@anderson ~/p/v/0> gcc -o vortex0 vortex0.c
maket@anderson ~/p/v/0> ./vortex0
Username: vortex1 Password: Gq#qu3bF3
maket@anderson ~/p/v/0> ssh vortex1@vortex.labs.overthewire.org -p 2228
                 _
__   _____  _ __| |_ _____  __
\ \ / / _ \| '__| __/ _ \ \/ /
 \ V / (_) | |  | ||  __/>  <
  \_/ \___/|_|   \__\___/_/\_\

a http://www.overthewire.org wargame.

vortex1@vortex.labs.overthewire.org's password:
Welcome to Ubuntu 14.04 LTS (GNU/Linux 4.4.0-92-generic x86_64)

 * Documentation:  https://help.ubuntu.com/

The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

vortex1@vortex:~$ whoami
vortex1
```

Alright, so now we're logged into the lab and can move onto level 1!