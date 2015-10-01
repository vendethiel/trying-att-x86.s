.global main
.type print_prev_char, @function
.data

.set letter_sample, 110 # 'n' - arbitrary
.set letter_low_from, 97 # 'a'
.set letter_low_to, 122 # 'z'
.set letter_high_from, 65 # 'A'
.set letter_high_to, 90 # 'Z'

.text

main:
	pushq %rbp
	movq %rsp, %rbp

	movl $letter_sample, %edi
	call print_prev_char
	movl $letter_high_from, %edi
	call print_prev_char
	movl $letter_low_from, %edi
	call print_prev_char

	jmp exit

print_prev_char:
	pushq %rbp
	movq %rsp, %rbp
	#subq $16, %rsp # only needed to align if you `call`

	movl %edi, %eax # fill %eax, to use %al later
	movb %al, -1(%rbp) # %al is a byte

	# check we're not at 'Z'
	cmpb $letter_high_from, -1(%rbp)
	je set_to_high

	# check we're not at 'z'
	cmpb $letter_low_from, -1(%rbp)
	je set_to_low
	# not equal: proceed, then skip set_to_a
	decb -1(%rbp) # decrease char
	jmp rest

set_to_low:
	movb $letter_low_to, -1(%rbp)
	jmp rest

set_to_high:
	movb $letter_high_to, -1(%rbp)

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

