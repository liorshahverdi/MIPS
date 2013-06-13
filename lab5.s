# LAB 5
# PROGRAMMER: Lior Shahverdi

	.data	# Data declaration section

	Input: .space 80
	Output: .space 80
	Table: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	Prompt: .asciiz "\nEnter a string: \n"
	
	InputStr: .asciiz "\nThe Base 64 encoded input data was: "
	OutputStr: .asciiz "\nThe decoded ASCII output is: "
	
	Bye: .asciiz "\n***Have a good day***\n"

	.text

main:		# Start of code section
	li	$s1, 0x0a
	la	$a0, Prompt
	li	$v0, 4
	syscall
	
	li	$v0, 8
	la	$a0, Output
	
	move	$t8, $a0
	move	$t9, $a0
	syscall
	
	li	$v0, 8
	la	$a0, Input
	move 	$t0, $a0
	move	$t1, $a0
	syscall
	la	$a1, Table
	lb	$t2, 0($t0) 	# $t2 stores first char of INPUT
	li 	$s2, 0		#$s2 = i for Table
	j	While
	
While:
	beq	$t2, $s1, end
	move 	$s0, $t2
	jalr	decode
	move	$t4, $s2	#$t4 equals DECODE CH1 (R1)
	
	addiu	$t0, $t0, 1
	li	$t2, 0
	lb	$t2, 0($t0)	#get ch2
	li	$s2, 0
	move	$s0, $t2
	jalr	decode
	move	$t5, $s2	#$t5 equals DECODE CH2 (R2)
	
	addiu	$t0, $t0, 1
	li	$t2, 0
	lb	$t2, 0($t0)	#get ch3
	li	$s2, 0
	move	$s0, $t2
	jalr	decode
	move	$t6, $s2	#$t6 equals DECODE CH3 (R3)
	
	addiu	$t0, $t0, 1
	li	$t2, 0
	lb	$t2, 0($t0)	#get ch4
	li	$s2, 0
	move	$s0, $t2
	jalr	decode
	move	$t7, $s2	#$t7 equals DECODE CH4 (R4)
	
	li	$s2, 0
	jalr	Shift
	add	$t0, $t0, 1
	lb	$t2, 0($t0)
	beq	$t2, $s1, end
	bne	$t2, $s1, While

Shift:
	addu	$s3, $s2, $t8
	
	sll 	$s4, $t4, 2
	srl 	$s5, $t5, 4
	or 	$s6, $s4, $s5
	sb	$s6, 0($s3)
	
	addiu	$s2, $s2, 1
	addu	$s3, $s2, $t8
	sll	$s4, $t5, 4
	srl	$s5, $t6, 2
	or	$s6, $s4, $s5
	sb	$s6, 0($s3)
	
	addiu	$s2, $s2, 1
	addu	$s3, $s2, $t8
	sll	$s4, $t6, 6
	or	$s6, $s4, $s5
	sb	$s6, 0($s3)
	jr	$ra
	
decode:
	addu	$s3, $s2, $a1
	addiu	$s2, $s2, 1
	lb 	$t3, 0($s3)	#loads ith element of table to $t3
	bne	$t3, $s0, decode
	jr	$ra

end:
	add	$t0, $t0, 1
	sb	$s1, 0($t0)
	
	la	$a0, InputStr
	li	$v0, 4
	syscall
	move 	$a0, $t1
	li	$v0, 4
	syscall
	
	la	$a0, OutputStr
	li	$v0, 4
	syscall
	move	$a0, $t9
	li	$v0, 4
	syscall
	
	la	$a0, Bye
	li	$v0, 4
	syscall
	li	$v0, 10
	syscall
	
	
	
	

# END OF PROGRAM