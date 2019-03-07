#include <unistd.h>
#include <stdio.h>

// I didn't want to rummage through a bunch of machine code to find the crc table so I'm just doing this
// Needs to be run in a few separate runs with different initial values of i because the vortex machines don't like lots of forks or something
// This isn't the actual table, it would be if the initial/final XORs of the CRC were 0xffffffff, they are actually 0 though. This helped figure out the table though anyway, probably should've just pulled the table from gdb in the end, ~shrug~

int main() {
  int i;
  char *filename = "/vortex/vortex7";
  for(i=1; i<256; i++) {
    if(!fork()) {
      printf("%d", i);
      char arg1[] = {(char)i, 0};
      char *argv[] = {filename, arg1, NULL};
      execv(filename, argv);
      break;
    }
    usleep(250000);
  }
  
  return 0;
}
