#include <stdio.h>

int main() {
  FILE *fp = fopen("/etc/vortex_pass/vortex7", "r");
  char buf[16];
  fread(buf, 1, 16, fp);
  printf("%s\n", buf);
  
  return 0;
}
