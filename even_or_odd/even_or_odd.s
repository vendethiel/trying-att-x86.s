.global main
.global print_even_or_odd
.type print_even_or_odd, @function

.text

main:
	pushq %rbp
	movq %rsp, %rbp

	movl $33, %edi
	call print_even_or_odd
	movl $0, %edi
	call print_even_or_odd
	movl $1, %edi
	call print_even_or_odd

	xor %rax, %rax # return 0
	leave
	ret

print_even_or_odd:
	pushq %rbp
	movq %rsp, %rbp

	# prepare the modulo
	movl %edi, %eax # our arg
	movl $2, %ebx # even/odd
	xor %edx, %edx # clear `result`
	div %ebx 

	cmpl $0, %edx
	je print_actually_even
	
	# it's odd!
	mov $message_is_odd, %rsi
	mov $message_odd_size, %rdx
	jmp do_print_message

print_actually_even:
	mov $message_even_or_odd, %rsi
	mov $message_even_size, %rdx

do_print_message:
	mov $1, %rax # syscall
	mov $1, %rdi # stdout
	syscall

	leave
	ret

message_even_or_odd:
	.ascii "It's even\n"
	.set message_even_size, .-message_even_or_odd

message_is_odd:
	.ascii "It's odd\n"
	.set message_odd_size, .-message_is_odd

