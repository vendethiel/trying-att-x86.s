	.global _start
	.text
_start:
	mov $1, %rax
	mov $1, %rdi
	mov $message, %rsi
	mov $13, %rdx
	syscall

	# now exit
	mov $60, %rax
	mov $0, %rdi # 0 is fun
	syscall

message:
	.ascii "Hello, World\n"
