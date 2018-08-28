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
