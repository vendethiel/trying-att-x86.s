	.global _start
	.text

_start:
	pushq %rbp
	movq %rsp, %rbp
	#subq $16, %rsp # not needed, we only need one byte on the stack anyway
	movb $90, -1(%rbp) # 110=n, 122=z, 90=Z
	
	# check we're not at 'Z'
	cmp $90, -1(%rbp)
	je set_to_A_capital

	# check we're not at 'z'
	cmp $122, -1(%rbp)
	je set_to_a
	# not equal: proceed, then skip set_to_a
	incb -1(%rbp) # decrease char
	jmp rest

set_to_a:
	movb $97, -1(%rbp) # explicitly use an 'a'
	jmp rest

set_to_A_capital:
	movb $65, -1(%rbp) # explicitly use an 'A'

rest:
	mov $1, %rdi # arg1
	leaq -1(%rbp), %rsi
	mov $1, %rdx # arg3

	mov $1, %rax # write syscall
	syscall

	mov $60, %eax
	xor %rdi, %rdi
	syscall
