.global main
.global print_odd_or_even
.type print_odd_or_even, @function

.text

main:
	pushq %rbp
	movq %rsp, %rbp

	movl $33, %edi
	call print_odd_or_even
	movl $0, %edi
	call print_odd_or_even
	movl $1, %edi
	call print_odd_or_even

	xor %rax, %rax # return 0
	leave
	ret

print_odd_or_even:
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
	mov $message_odd_or_even, %rsi
	mov $message_even_size, %rdx

do_print_message:
	mov $1, %rax # syscall
	mov $1, %rdi # stdout
	syscall

	leave
	ret

message_odd_or_even:
	.ascii "It's even\n"
	.set message_even_size, .-message_odd_or_even

message_is_odd:
	.ascii "It's odd\n"
	.set message_odd_size, .-message_is_odd

