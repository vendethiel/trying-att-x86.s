.global main

main:
	pushq %rbp
	movq %rsp, %rbp

	movl $-23888, %edi
	call put_nbr

	xor %eax, %eax
	popq %rbp
	ret

#--- PUT_NBR
put_nbr:
  pushq %rbp
  movq %rsp, %rbp

  # -4 = int arg, -8 = quotient, -12 = remainder
  subq $12, %rsp # gimme sum stack space
  movl %edi, -4(%rbp)

  cmpl $0, -4(%rbp)
  # number is neg (Jump Not Sign: no sign bit, so jump if %edi is pos)
  jns put_nbr_pos

  negl -4(%rbp)
  movl $45, %edi # '-'
  call putchar

put_nbr_pos:
  # do the div...
  movl -4(%rbp), %eax
  movl $10, %ebx # n%10
  xor %edx, %edx # clear before divl
  divl %ebx # get remainder

  movl %eax, -8(%rbp)  # quotient
  movl %edx, -12(%rbp) # remainder

  # do we skip recursion?
  cmpl $10, -4(%rbp)
  jl put_nbr_small

  movl -8(%rbp), %edi
  call put_nbr

put_nbr_small:
  movl -12(%rbp), %edi # print remainder
  addl $48, %edi # 48='0'
  call putchar

  leave
  ret 
