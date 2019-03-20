#include <sys/times.h>

int main() {
  clock_t st_time;
  struct tms st_cpu;
  int seed;

  st_time = times(&st_cpu);
  st_time += st_cpu.utime + st_cpu.stime + st_cup.cutime + st_cpu.cstime;
  st_time += clock();
  st_time += time(0);
  st_time = 0x80 - ((((st_time + (st_time >> 31) * 0xff) << 24) >> 24) - ((st_time >> 31) * 0xff));

  // Let's assume that we can't figure out the values of st_cpu, because I don't want to, so we'll guess/bruteforce st_time until we get a sequence matching the given one
  
  seed = st_time + time(0);
  srand(seed);

  // The program then sets the 30s alarm, discards some rand()s, prints prompts, gets input
  // Then it compares input against the seed, if it succeeds it spawns a shell
  
  return 0;
}

/* stack - 0x80 = 128 bytes
   0x1c: srand seed
   0x18: st_time
   0x20: st_cpu.tms_utime
   0x24: st_cpu.stime
   0x28: st_cpu.cutime
   0x2c: st_cpu.cstime
 */


