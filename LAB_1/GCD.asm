.data
msgb : .asciiz "The GCD is : "
inputa : .asciiz "The first number= "
inputb : .asciiz "The second number= "
.text
.globl main
main:
	#讀第一個數到t1
	li $v0, 4
	la $a0, inputa
	syscall
	li $v0, 5
	syscall
	add $t1, $zero, $v0
	
	#讀第二個數到t2
	li $v0, 4
	la $a0, inputb
	syscall
	li $v0, 5
	syscall
	add $t2, $zero, $v0
	
	#比對 t1, t2大小
comp:	slt $t0, $t1, $t2
	beq $t0, $zero, subb
	add $t3, $t1, $zero	
	add $t1, $t2, $zero
	add $t2, $t3, $zero
subb:	sub $t1, $t1, $t2
	bne $t1, $zero, comp
	
	#顯示最大公因數
	li $v0, 4
	la $a0, msgb
	syscall
	add $a0, $zero, $t2
	li $v0, 1
	syscall
	li $v0, 10
	syscall	