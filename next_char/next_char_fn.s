	.global main
	.type print_next_char, @function

main:
	pushq %rbp
	movq %rsp, %rbp

	movl $110, %edi # 'n'
	call print_next_char
	movl $90, %edi # 'Z'
	call print_next_char
	movl $122, %edi # 'z'
	call print_next_char

	jmp exit

print_next_char:
	pushq %rbp
	movq %rsp, %rbp
	#subq $16, %rsp # <- not sure why that's useful..?

	movl %edi, %eax # fill %eax, to use %al later
	movb %al, -1(%rbp) # %al is a byte

	# check we're not at 'Z'
	cmpb $90, -1(%rbp)
	je set_to_A_capital

	# check we're not at 'z'
	cmpb $122, -1(%rbp)
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
	leaq -1(%rbp), %rsi # arg2 -> Load Effective Address
	mov $1, %rdx # arg3

	mov $1, %rax # write syscall
	syscall

	leave # kill stakframe
	ret # jump back

exit:
	mov $60, %eax
	xor %rdi, %rdi
	syscall
