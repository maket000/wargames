void safecode() {
  while(1) {
    printf("%d", 0);
    fflush(NULL); // flush all output streams
    sleep(1);
  }
}

void unsafecode(char *str) {
  char buf[400]; // located at ebp - 0x408
  strcpy(buf, str);
}

int main(int argc, char **argv, char **arge) {
  /* int pthread_create(pthread_t *thread, const pthread_attr_t *attr, */
  /*                    void *(*start_routine) (void *), void *arg); */
  pthread_t *thread;
  pthread_create(thread, 0, &safecode, 0);

  setresgid(getgid(), getgid(), getgid());
  setresuid(getuid(), getuid(), getuid());

  unsafecode(argv[1]);

  return 0;
}
