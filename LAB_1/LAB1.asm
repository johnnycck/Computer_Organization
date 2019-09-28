.data
msga : .asciiz "nearest prime number is : "
msgb : .asciiz "\nnearest prime number is : "
inputa : .asciiz "Pls enter a number :"
.text
.globl main
main:
	#弄计t1
	li $v0, 4
	la $a0, inputa
	syscall
	li $v0, 5
	syscall
	add $t1, $zero, $v0
	#耞input琌案计临计, 璝t3程0案计
	li, $t2, 1
	and, $t3, $t1, $t2 
	#input┕耞, 案计+1, 计+2, 计t2
	add $t2, $t1, $zero
	beq $t3, 1, odd
	beq $t3, 0, even
odd:	add $t2, $t2, 1
even:	add $t2, $t2, 1	
	#眖3秨﹍┕耞琌俱埃t2
	li, $t4, 3
	beq, $t2, 3, answerL
Bloop:
	add, $t5, $t2, $zero
	li, $t7, 0
	li, $t6, 0
	loop:	
		slt, $t0, $t5, $zero
		bne, $t0, $zero, check
		sub, $t5, $t5, $t4
		beq, $t5, $zero, exit
	j loop
		#砆埃计キよ璝计碞ボ赣计借计
		check:
			beq, $t4, $t6, plus 
			add, $t6, $t6, 1
			add, $t7, $t7, $t4
		j check	
		#р计+2
		plus:
			slt, $t0, $t7, $t2
			beq, $t0, $zero, exit
			add, $t4, $t4, 2
		j Bloop	
exit: 
	beq, $t5, $zero, larger
	j answerL
larger:
	add, $t2, $t2, 2
	li, $t4, 3
	j Bloop	
two:
	li $t2, 2 
answerL:
	#陪ボ计ぇ程借计
	li $v0, 4
	la $a0, msga
	syscall
	add $a0, $zero, $t2
	li $v0, 1
	syscall
		
	####################################################
	#耞input琌案计临计, 璝t3程0案计
	li, $t4, 0
	li, $t5, 0
	li, $t6, 0
	li, $t7, 0
	li, $t2, 1
	and, $t3, $t1, $t2 
	#input┕耞, 案计-1, 计-2, 计t2
	add $t2, $t1, $zero
	beq $t3, 1, oddS
	beq $t3, 0, evenS
oddS:	sub $t2, $t2, 1
evenS:	sub $t2, $t2, 1	
	#眖3秨﹍┕耞琌俱埃t2
	li, $t4, 3
	beq, $t2, 3, answerS
BloopS:
	add, $t5, $t2, $zero
	#beq, $t5, 3, answerS
	li, $t7, 0
	li, $t6, 0
	loopS:	
		slt, $t0, $t5, $zero
		bne, $t0, $zero, checkS
		sub, $t5, $t5, $t4
		beq, $t5, $zero, exitS
	j loopS
		#砆埃计キよ璝计碞ボ赣计借计
		checkS:
			beq, $t4, $t6, plusS 
			add, $t6, $t6, 1
			add, $t7, $t7, $t4
		j checkS	
		#р计+2
		plusS:
			slt, $t0, $t7, $t2
			beq, $t0, $zero, exitS
			add, $t4, $t4, 2
		j BloopS	
exitS: 
	beq, $t5, $zero, largerS
	j answerS
largerS:
	sub, $t2, $t2, 2
	li, $t4, 3
	j BloopS	
twoS:
	li $t2, 2 
answerS:
	#陪ボ计ぇ程借计
	li $v0, 4
	la $a0, msgb
	syscall
	add $a0, $zero, $t2
	li $v0, 1
	syscall
	li $v0, 10
	syscall
