	.global _start
.text

_start:
	pushq %rbp
	movq %rsp, %rbp

	movabsq $str1, %rdi
	movabsq $str2, %rsi
	movl $10, %ecx
	call my_strcmp

	leave
	ret

# my_strcmp(rdi=str1, rsi=str2, ecx=length_of_longest): %rax
my_strcmp:
	pushq %rbp
	movq %rsp, %rbp

	cld
	repe cmpsb # break if %rdi++ != %rsi++ while --%ecx
	movl %ecx, %eax
	and $1, %eax # make sure result is 0 (eq) or 1 (uneq)

	leave
	ret

str1:
	.asciz "Hello ate"
str2:
	.asciz "hello ate"
