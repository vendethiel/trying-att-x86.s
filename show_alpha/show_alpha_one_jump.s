.global main
.type print, @function

.set letter_start, 97 # 'a'
.set letter_end, 122 # 'z'

.text
main:
	pushq %rbp
	movq %rsp, %rbp


	movb $letter_start, %dil
loop:
	pushq %rdi # using push/pop instead of stack BECAUSE I CAN
	call print
	popq %rdi

	incb %dil
	cmpb $letter_end, %dil
	jle loop

	xor %rax, %rax
	leave
	ret

print:
	pushq %rbp
	movq %rsp, %rbp

	movb %dil, -1(%rbp)

	mov $1, %rdi # arg1: stdout
	leaq -1(%rbp), %rsi # arg2: letter
	mov $1, %rdx # arg3: length

	mov $1, %rax # write(2)
	syscall

	leave
	ret
