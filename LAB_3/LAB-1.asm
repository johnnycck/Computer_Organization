.data
msga : .asciiz "nearest prime number is : "
msgb : .asciiz "\nnearest prime number is : "
inputa : .asciiz "Pls enter a number :"
.text
.globl main
main:
	#弄?t1
	li $v0, 4
	la $a0, inputa
	syscall
	li $v0, 5
	syscall
	add $t1, $zero, $v0
	#判斷input是偶數還奇數, 若t3最後為0即為偶數
	add $t3, $t1, $zero
	add $t2, $t2, 2
	slt, $t0, $t3, $t2
	beq $t0, 1, two
	li $t2, 2	
comp:	slt $t0, $t2, $t3
	beq $t3, $zero, leave
	#beq $t0, $zero, subb
subb:	sub $t3, $t3, $t2
	bne $t3, 1, comp
leave:	add $t0, $t0, 1
	# input往上判斷, 偶數+1, 奇數+2, 數字存在t2
	add $t2, $t1, $zero
	beq $t3, 1, odd
	beq $t3, 0, even
odd:	add $t2, $t2, 1
even:	add $t2, $t2, 1	
	#從3開始往上加，判斷是否整除於t2
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
		#被除數平方後若大於原數就表示該數為質數
		check:
			beq, $t4, $t6, plus 
			add, $t6, $t6, 1
			add, $t7, $t7, $t4
		j check	
		#??+2
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
	#陪???程借?
	li $v0, 4
	la $a0, msga
	syscall
	add $a0, $zero, $t2
	li $v0, 1
	syscall
		
	####################################################
	#耞input琌案???, ?t3程0案?
	li, $t2, 2
	li, $t3, 0
	li, $t4, 3
	li, $t5, 0
	li, $t6, 0
	li, $t7, 0
	add $t3, $t1, $zero
	add $t2, $t2, 4
	slt, $t0, $t3, $t2
	beq $t0, 1, twoS
	li $t2, 2	
compS:	slt $t0, $t2, $t3
	beq $t3, $zero, leaveS
	#beq $t0, $zero, subbS
subbS:	sub $t3, $t3, $t2
	bne $t3, 1, compS
leaveS:	add $t0, $t0, 1
	#input?耞, 案?-1, ?-2, ?t2
	add $t2, $t1, $zero
	beq $t3, 1, oddS
	beq $t3, 0, evenS
oddS:	sub $t2, $t2, 1
evenS:	sub $t2, $t2, 1	
	#?3?﹍?耞琌俱埃t2
#	li, $t4, 3
	beq, $t2, 3, answerS
BloopS:
	add, $t5, $t2, $zero
	#beq, $t5, 3, answerS
#	li, $t7, 0
#	li, $t6, 0
	loopS:	
		slt, $t0, $t5, $zero
		bne, $t0, $zero, checkS
		sub, $t5, $t5, $t4
		beq, $t5, $zero, exitS
	j loopS
		#砆埃?????碞???借?
		checkS:
			beq, $t4, $t6, plusS 
			add, $t6, $t6, 1
			add, $t7, $t7, $t4
		j checkS	
		#??+2
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
	#陪???程借?
	li $v0, 4
	la $a0, msgb
	syscall
	add $a0, $zero, $t2
	li $v0, 1
	syscall
	li $v0, 10
	syscall
