safecode:
	0x0804865d <+0>:     push   %ebp
	0x0804865e <+1>:     mov    %esp,%ebp
	0x08048660 <+3>:     sub    $0x28,%esp
	0x08048663 <+6>:     movl   $0x0,-0xc(%ebp)
	0x0804866a <+13>:    mov    -0xc(%ebp),%eax
	0x0804866d <+16>:    mov    %eax,0x4(%esp)
	0x08048671 <+20>:    movl   $0x80487f0,(%esp) //0x25640a00 -> %d\n
	0x08048678 <+27>:    call   0x80484c0 <printf@plt> //0x0000
	0x0804867d <+32>:    mov    0x804a040,%eax
	0x08048682 <+37>:    mov    %eax,(%esp)
	0x08048685 <+40>:    call   0x80484d0 <fflush@plt>
	0x0804868a <+45>:    movl   $0x1,(%esp)
	0x08048691 <+52>:    call   0x80484e0 <sleep@plt>
	0x08048696 <+57>:    jmp    0x804866a <safecode+13>

unsafecode:
	0x08048698 <+0>:     push   %ebp
	0x08048699 <+1>:     mov    %esp,%ebp
	0x0804869b <+3>:     sub    $0x418,%esp
	0x080486a1 <+9>:     mov    0x8(%ebp),%eax
	0x080486a4 <+12>:    mov    %eax,0x4(%esp)
	0x080486a8 <+16>:    lea    -0x408(%ebp),%eax
	0x080486ae <+22>:    mov    %eax,(%esp)
	0x080486b1 <+25>:    call   0x8048500 <strcpy@plt>
	0x080486b6 <+30>:    leave
	0x080486b7 <+31>:    ret

main:
	0x080486b8 <+0>:     push   %ebp
	0x080486b9 <+1>:     mov    %esp,%ebp
	0x080486bb <+3>:     push   %esi
	0x080486bc <+4>:     push   %ebx
	0x080486bd <+5>:     and    $0xfffffff0,%esp
	0x080486c0 <+8>:     sub    $0x20,%esp
	0x080486c3 <+11>:    movl   $0x0,0xc(%esp)
	0x080486cb <+19>:    movl   $0x804865d,0x8(%esp)
	0x080486d3 <+27>:    movl   $0x0,0x4(%esp)
	0x080486db <+35>:    lea    0x1c(%esp),%eax
	0x080486df <+39>:    mov    %eax,(%esp)
	0x080486e2 <+42>:    call   0x8048550 <pthread_create@plt>
	0x080486e7 <+47>:    call   0x8048530 <getgid@plt>
	0x080486ec <+52>:    mov    %eax,%esi
	0x080486ee <+54>:    call   0x8048530 <getgid@plt>
	0x080486f3 <+59>:    mov    %eax,%ebx
	0x080486f5 <+61>:    call   0x8048530 <getgid@plt>
	0x080486fa <+66>:    mov    %esi,0xc(%esp)
	0x080486fe <+70>:    mov    %ebx,0x8(%esp)
	0x08048702 <+74>:    mov    %eax,0x4(%esp)
	0x08048706 <+78>:    movl   $0xaa,(%esp)
	0x0804870d <+85>:    call   0x8048540 <syscall@plt>
	0x08048712 <+90>:    call   0x80484f0 <getuid@plt>
	0x08048717 <+95>:    mov    %eax,%esi
	0x08048719 <+97>:    call   0x80484f0 <getuid@plt>
	0x0804871e <+102>:   mov    %eax,%ebx
	0x08048720 <+104>:   call   0x80484f0 <getuid@plt>
	0x08048725 <+109>:   mov    %esi,0xc(%esp)
	0x08048729 <+113>:   mov    %ebx,0x8(%esp)
	0x0804872d <+117>:   mov    %eax,0x4(%esp)
	0x08048731 <+121>:   movl   $0xa4,(%esp)
	0x08048738 <+128>:   call   0x8048540 <syscall@plt>
	0x0804873d <+133>:   mov    0xc(%ebp),%eax
	0x08048740 <+136>:   add    $0x4,%eax
	0x08048743 <+139>:   mov    (%eax),%eax
	0x08048745 <+141>:   mov    %eax,(%esp)
	0x08048748 <+144>:   call   0x8048698 <unsafecode>
	0x0804874d <+149>:   mov    $0x0,%eax
	0x08048752 <+154>:   lea    -0x8(%ebp),%esp
	0x08048755 <+157>:   pop    %ebx
	0x08048756 <+158>:   pop    %esi
	0x08048757 <+159>:   pop    %ebp
	0x08048758 <+160>:   ret
