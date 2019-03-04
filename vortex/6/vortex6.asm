restart:
0x0804847d <+0>:     push   %ebp
0x0804847e <+1>:     mov    %esp,%ebp
0x08048480 <+3>:     sub    $0x18,%esp
0x08048483 <+6>:     movl   $0x0,0x8(%esp)
0x0804848b <+14>:    mov    0x8(%ebp),%eax
0x0804848e <+17>:    mov    %eax,0x4(%esp)
0x08048492 <+21>:    mov    0x8(%ebp),%eax
0x08048495 <+24>:    mov    %eax,(%esp)
0x08048498 <+27>:    call   0x8048350 <execlp@plt>
0x0804849d <+32>:    leave
0x0804849e <+33>:    ret

main:
0x0804849f <+0>:     push   %ebp
0x080484a0 <+1>:     mov    %esp,%ebp
0x080484a2 <+3>:     and    $0xfffffff0,%esp
0x080484a5 <+6>:     sub    $0x10,%esp
0x080484a8 <+9>:     mov    0x10(%ebp),%eax
0x080484ab <+12>:    mov    (%eax),%eax
0x080484ad <+14>:    test   %eax,%eax
0x080484af <+16>:    je     0x80484be <main+31>
0x080484b1 <+18>:    mov    0xc(%ebp),%eax
0x080484b4 <+21>:    mov    (%eax),%eax
0x080484b6 <+23>:    mov    %eax,(%esp)
0x080484b9 <+26>:    call   0x804847d <restart>
0x080484be <+31>:    mov    0x10(%ebp),%eax
0x080484c1 <+34>:    add    $0xc,%eax
0x080484c4 <+37>:    mov    (%eax),%eax
0x080484c6 <+39>:    mov    %eax,(%esp)
0x080484c9 <+42>:    call   0x8048330 <printf@plt>
0x080484ce <+47>:    movl   $0x7325,(%esp)
0x080484d5 <+54>:    call   0x8048340 <_exit@plt>
