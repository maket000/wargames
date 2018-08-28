	(gdb) disassemble main
	Dump of assembler code for function main:
	0x080485c0 <+0>:     push   %ebp
	0x080485c1 <+1>:     mov    %esp,%ebp
	0x080485c3 <+3>:     push   %esi
	0x080485c4 <+4>:     push   %ebx
	0x080485c5 <+5>:     and    $0xfffffff0,%esp
	0x080485c8 <+8>:     sub    $0x220,%esp
	0x080485ce <+14>:    mov    %gs:0x14,%eax
	0x080485d4 <+20>:    mov    %eax,0x21c(%esp)
	0x080485db <+27>:    xor    %eax,%eax
	0x080485dd <+29>:    lea    0x1c(%esp),%eax
	0x080485e1 <+33>:    add    $0x100,%eax
	0x080485e6 <+38>:    mov    %eax,0x14(%esp)
	0x080485ea <+42>:    jmp    0x804868e <main+206>
	0x080485ef <+47>:    mov    0x18(%esp),%eax
	0x080485f3 <+51>:    cmp    $0xa,%eax
	0x080485f6 <+54>:    je     0x80485ff <main+63>
	0x080485f8 <+56>:    cmp    $0x5c,%eax
	0x080485fb <+59>:    je     0x8048615 <main+85>
	0x080485fd <+61>:    jmp    0x804861c <main+92>
	0x080485ff <+63>:    movl   $0x200,0x4(%esp)
	0x08048607 <+71>:    lea    0x1c(%esp),%eax
	0x0804860b <+75>:    mov    %eax,(%esp)
	0x0804860e <+78>:    call   0x804856d <print>
	0x08048613 <+83>:    jmp    0x804868e <main+206>
	0x08048615 <+85>:    subl   $0x1,0x14(%esp)
	0x0804861a <+90>:    jmp    0x804868e <main+206>
	0x0804861c <+92>:    mov    0x14(%esp),%eax
	0x08048620 <+96>:    and    $0xff000000,%eax
	0x08048625 <+101>:   cmp    $0xca000000,%eax
	0x0804862a <+106>:   jne    0x804866b <main+171>
	0x0804862c <+108>:   call   0x8048430 <geteuid@plt>
	0x08048631 <+113>:   mov    %eax,%esi
	0x08048633 <+115>:   call   0x8048430 <geteuid@plt>
	0x08048638 <+120>:   mov    %eax,%ebx
	0x0804863a <+122>:   call   0x8048430 <geteuid@plt>
	0x0804863f <+127>:   mov    %esi,0x8(%esp)
	0x08048643 <+131>:   mov    %ebx,0x4(%esp)
	0x08048647 <+135>:   mov    %eax,(%esp)
	0x0804864a <+138>:   call   0x80483e0 <setresuid@plt>
	0x0804864f <+143>:   movl   $0x0,0x8(%esp)
	0x08048657 <+151>:   movl   $0x804876a,0x4(%esp)
	0x0804865f <+159>:   movl   $0x804876d,(%esp)
	0x08048666 <+166>:   call   0x8048420 <execlp@plt>
	0x0804866b <+171>:   lea    0x1c(%esp),%eax
	0x0804866f <+175>:   add    $0x200,%eax
	0x08048674 <+180>:   cmp    %eax,0x14(%esp)
	0x08048678 <+184>:   jbe    0x804867c <main+188>
	0x0804867a <+186>:   jmp    0x804868d <main+205>
	0x0804867c <+188>:   mov    0x14(%esp),%eax
	0x08048680 <+192>:   lea    0x1(%eax),%edx
	0x08048683 <+195>:   mov    %edx,0x14(%esp)
	0x08048687 <+199>:   mov    0x18(%esp),%edx
	0x0804868b <+203>:   mov    %dl,(%eax)
	0x0804868d <+205>:   nop
	0x0804868e <+206>:   call   0x8048400 <getchar@plt>
	0x08048693 <+211>:   mov    %eax,0x18(%esp)
	0x08048697 <+215>:   cmpl   $0xffffffff,0x18(%esp)
	0x0804869c <+220>:   jne    0x80485ef <main+47>
	0x080486a2 <+226>:   movl   $0x8048775,(%esp)
	0x080486a9 <+233>:   call   0x8048440 <puts@plt>
	0x080486ae <+238>:   mov    $0x0,%eax
	0x080486b3 <+243>:   mov    0x21c(%esp),%ecx
	0x080486ba <+250>:   xor    %gs:0x14,%ecx
	0x080486c1 <+257>:   je     0x80486c8 <main+264>
	0x080486c3 <+259>:   call   0x8048410 <__stack_chk_fail@plt>
	0x080486c8 <+264>:   lea    -0x8(%ebp),%esp
	0x080486cb <+267>:   pop    %ebx
	0x080486cc <+268>:   pop    %esi
	0x080486cd <+269>:   pop    %ebp
	0x080486ce <+270>:   ret
