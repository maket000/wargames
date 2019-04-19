main:	
	0x080486ad <+0>:     push   %ebp
	0x080486ae <+1>:     mov    %esp,%ebp
	0x080486b0 <+3>:     push   %esi
	0x080486b1 <+4>:     push   %ebx
	0x080486b2 <+5>:     and    $0xfffffff0,%esp
	0x080486b5 <+8>:     add    $0xffffff80,%esp
	0x080486b8 <+11>:    lea    0x20(%esp),%eax
	0x080486bc <+15>:    mov    %eax,(%esp)
	0x080486bf <+18>:    call   0x80484e0 <times@plt>
	0x080486c4 <+23>:    mov    %eax,0x18(%esp)
	0x080486c8 <+27>:    mov    0x20(%esp),%edx
	0x080486cc <+31>:    mov    0x24(%esp),%eax
	0x080486d0 <+35>:    add    %eax,%edx
	0x080486d2 <+37>:    mov    0x28(%esp),%eax
	0x080486d6 <+41>:    add    %eax,%edx
	0x080486d8 <+43>:    mov    0x2c(%esp),%eax
	0x080486dc <+47>:    add    %edx,%eax
	0x080486de <+49>:    add    %eax,0x18(%esp)
	0x080486e2 <+53>:    call   0x8048540 <clock@plt>
	0x080486e7 <+58>:    add    %eax,0x18(%esp)
	0x080486eb <+62>:    movl   $0x0,(%esp)
	0x080486f2 <+69>:    call   0x80484f0 <time@plt>
	0x080486f7 <+74>:    add    %eax,0x18(%esp)
	0x080486fb <+78>:    mov    0x18(%esp),%eax
	0x080486ff <+82>:    cltd ;sign extend eax -> edx:eax
	0x08048700 <+83>:    shr    $0x18,%edx ; 0x00 or 0xff based on sign of eax (seems like it's always 0xff)
	0x08048703 <+86>:    add    %edx,%eax
	0x08048705 <+88>:    movzbl %al,%eax
	0x08048708 <+91>:    sub    %edx,%eax  
	0x0804870a <+93>:    mov    $0x80,%edx
	0x0804870f <+98>:    sub    %eax,%edx
	0x08048711 <+100>:   mov    %edx,%eax
	0x08048713 <+102>:   mov    %eax,0x18(%esp)
	0x08048717 <+106>:   movl   $0x0,(%esp)
	0x0804871e <+113>:   call   0x80484f0 <time@plt>
	0x08048723 <+118>:   mov    0x18(%esp),%edx
	0x08048727 <+122>:   add    %edx,%eax
	0x08048729 <+124>:   mov    %eax,0x1c(%esp)
	0x0804872d <+128>:   mov    0x1c(%esp),%eax
	0x08048731 <+132>:   mov    %eax,(%esp)
	0x08048734 <+135>:   call   0x8048560 <srand@plt>
	0x08048739 <+140>:   mov    0x804a060,%eax
	0x0804873e <+145>:   movl   $0x0,0xc(%esp)
	0x08048746 <+153>:   movl   $0x2,0x8(%esp)
	0x0804874e <+161>:   movl   $0x0,0x4(%esp)
	0x08048756 <+169>:   mov    %eax,(%esp)
	0x08048759 <+172>:   call   0x8048580 <setvbuf@plt>
	0x0804875e <+177>:   movl   $0x0,0x14(%esp)
	0x08048766 <+185>:   jmp    0x8048772 <main+197>
	0x08048768 <+187>:   call   0x80485a0 <rand@plt>
	0x0804876d <+192>:   addl   $0x1,0x14(%esp)
	0x08048772 <+197>:   mov    0x14(%esp),%eax
	0x08048776 <+201>:   cmp    0x18(%esp),%eax
	0x0804877a <+205>:   jl     0x8048768 <main+187>
	0x0804877c <+207>:   movl   $0x5b,(%esp)
	0x08048783 <+214>:   call   0x8048590 <putchar@plt>
	0x08048788 <+219>:   movl   $0x0,0x14(%esp)
	0x08048790 <+227>:   jmp    0x80487be <main+273>
	0x08048792 <+229>:   call   0x80485a0 <rand@plt>
	0x08048797 <+234>:   mov    %eax,%edx
	0x08048799 <+236>:   mov    0x14(%esp),%eax
	0x0804879d <+240>:   mov    %edx,0x30(%esp,%eax,4)
	0x080487a1 <+244>:   mov    0x14(%esp),%eax
	0x080487a5 <+248>:   mov    0x30(%esp,%eax,4),%eax
	0x080487a9 <+252>:   mov    %eax,0x4(%esp)
	0x080487ad <+256>:   movl   $0x8048900,(%esp)
	0x080487b4 <+263>:   call   0x80484d0 <printf@plt>
	0x080487b9 <+268>:   addl   $0x1,0x14(%esp)
	0x080487be <+273>:   cmpl   $0x13,0x14(%esp)
	0x080487c3 <+278>:   jle    0x8048792 <main+229>
	0x080487c5 <+280>:   movl   $0x8048907,(%esp)
	0x080487cc <+287>:   call   0x8048530 <puts@plt>
	0x080487d1 <+292>:   movl   $0x1e,(%esp)
	0x080487d8 <+299>:   call   0x8048500 <alarm@plt>
	0x080487dd <+304>:   movl   $0x4,0x8(%esp)
	0x080487e5 <+312>:   lea    0x10(%esp),%eax
	0x080487e9 <+316>:   mov    %eax,0x4(%esp)
	0x080487ed <+320>:   movl   $0x0,(%esp)
	0x080487f4 <+327>:   call   0x80484c0 <read@plt>
	0x080487f9 <+332>:   mov    0x10(%esp),%eax
	0x080487fd <+336>:   cmp    0x1c(%esp),%eax
	0x08048801 <+340>:   jne    0x804884c <main+415>
	0x08048803 <+342>:   call   0x8048520 <geteuid@plt>
	0x08048808 <+347>:   mov    %eax,%esi
	0x0804880a <+349>:   call   0x8048520 <geteuid@plt>
	0x0804880f <+354>:   mov    %eax,%ebx
	0x08048811 <+356>:   call   0x8048520 <geteuid@plt>
	0x08048816 <+361>:   mov    %esi,0x8(%esp)
	0x0804881a <+365>:   mov    %ebx,0x4(%esp)
	0x0804881e <+369>:   mov    %eax,(%esp)
	0x08048821 <+372>:   call   0x80484b0 <setresuid@plt>
	0x08048826 <+377>:   movl   $0x0,0xc(%esp)
	0x0804882e <+385>:   movl   $0x8048909,0x8(%esp)
	0x08048836 <+393>:   movl   $0x804890c,0x4(%esp)
	0x0804883e <+401>:   movl   $0x804890f,(%esp)
	0x08048845 <+408>:   call   0x8048510 <execlp@plt>
	0x0804884a <+413>:   jmp    0x8048858 <main+427>
	0x0804884c <+415>:   movl   $0x8048917,(%esp)
	0x08048853 <+422>:   call   0x8048530 <puts@plt>
	0x08048858 <+427>:   mov    $0x0,%eax
	0x0804885d <+432>:   lea    -0x8(%ebp),%esp
	0x08048860 <+435>:   pop    %ebx
	0x08048861 <+436>:   pop    %esi
	0x08048862 <+437>:   pop    %ebp
	0x08048863 <+438>:   ret
