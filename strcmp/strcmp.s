	.global _start
.text

_start:
	pushq %rbp
	movq %rsp, %rbp

	movabsq $str1, %rdi
	movabsq $str2, %rsi
	#call strcmp
  call strlen

	leave
	ret

# int strlen(char *)
strlen:
	pushq %rbp
	movq %rsp, %rbp

	xor %al, %al # store NULL in al (that's what scasb compares its current element to)
	xor %rcx, %rcx # clear ecx
	not %rcx # set ecx to -1 (will wrap)

	cld # clear direction flag
	repne scasb # %rcx-- while %rdi++==%al
  not %rcx # since we wrapped ((unsigned) -1), inverse the bits
  dec %rcx # nullbyte
  movl %rcx, %rax

	leave
	ret

# int strcmp(char *, char *)
strcmp:
	pushq %rbp
	movq %rsp, %rbp
  subq $16, %rbp # length 1 (8) + length 2

# get both length
	call strlen # first arg is already in %rdi
  movl %rax, -8(%rbp)
  movl %rax, %rbx # store 1st length

  push %rdi # store rdi to calculate the 2nd length
  movq %rsi, %rdi
  call strlen
  movl %ecx, %edx # store 2nd length
  pop %rdi # restore rdi

# compare lengths
  cmp %eax, %edx
  je strcmp_compare_strings

  # early exit
  xor %eax, %eax
  inc %eax # 1 = uneq
  leave
  ret

# compare strings
strcmp_compare_strings:
  inc %ecx # compare up to nulbyte

# done
	leave
	ret

str1:
	.asciz "Hello mate"
str2:
	.asciz "Hello materrrrr"
