#Homework #3, Shashank Shrestha


.data

msg_0 : .asciiz "\nM E N U"
msg_1 : .asciiz "\n\nPlay new game (p)"
msg_2 : .asciiz "\n\nQuit (q)"
msg_3 : .asciiz "\n\nChoose?"
msg_4 : .asciiz "\n\nType 3 numbers: "
msg_5 : .asciiz "\nEnter 1st number:"
msg_6 : .asciiz "\nEnter 2nd number:"
msg_7 : .asciiz "\nEnter 3rd number:"
msg_8 : .asciiz "  Strike(s)  "
msg_9 : .asciiz "\n Strike Out!!"
msg_10: .asciiz "  Ball(s) "
msg_11: .asciiz "It takes "
msg_12: .asciiz " attempts\n."
msg_13: .asciiz "Please enter a vaild input."
Play  : .word 112 
Quit  : .word 113
my_array : .word 7, 1 ,9			#Storing 7 1 9 as a random word.

.text
.globl main

main:

	la $a0 , my_array			#Loads my_array into register $a0
	move $t0 , $a0
	lw $t5 , 0($t0)				#Accessing contents of my_array

	lw $t6 , 4($t0)
	lw $t7 , 8($t0)
	
Firstdisplay: 

	la $a0 , msg_0				#Display respective prompt messages
	li $v0 , 4
	syscall
	
	la $a0 , msg_1
	li $v0 , 4
	syscall

	la $a0 , msg_2
	li $v0 , 4
	syscall

	la $a0 , msg_3
	li $v0 , 4
	syscall
	
	li $v0 , 12				#Read prompt from user 
	syscall

	move $t9 , $v0				#Moving the user input result onto $t9 register
	lw $a0 , Play
	

	beq $t9 , $a0 , equal_check		#Checking if user input matches .
	lw $a0 , Quit
	bne $a0 , $t9 , Firstdisplay	
	
	
	j exit
	
equal_check:
	
	li $a2 , 0 
	li $a1 , 0

	la $a0 , msg_4
	li $v0 , 4
	syscall

	la $a0 , msg_5
	li $v0 , 4
	syscall

	li $v0 , 5    				 #Read numbers.
	syscall

	move $t2 , $v0


	la $a0 , msg_6
	li $v0 , 4
	syscall

	li $v0 , 5
	syscall

	move $t3 , $v0

	la $a0 , msg_7
	li $v0 , 4
	syscall	
	
	li $v0 , 5
	syscall

	move $t4 , $v0

Strike_compare:

	bne $t2 , $t5 , Strike_compare_1		#Comparing elements of array with user inputs.
	addi $a1 , $a1 ,1
	addi $a3 , $a3 , 1
	
		
Strike_compare_1:
	
	bne $t2 , $t6 , Strike_compare_2
	addi $a2 , $a2 , 1		

Strike_compare_2:
	
	bne $t2 , $t7 , Strike_compare_3
	addi $a2 ,$a2, 1
	
Strike_compare_3:
	
	bne $t3 , $t5 , Strike_compare_4
	addi $a2 ,$a2, 1
	
	
Strike_compare_4:
	
	bne $t3 , $t6 , Strike_compare_5
	addi $a1 ,$a1 , 1
	addi $a3 , $a3 , 1
	
	
Strike_compare_5:
	
	bne $t3 , $t7 , Strike_compare_6
	addi $a2 ,$a2, 1			
	
Strike_compare_6:
	
	bne $t4 , $t5 , Strike_compare_7
	addi $a2 ,$a2 , 1	
	
	
Strike_compare_7:
	
	bne $t4 , $t6 , Strike_compare_8
	addi $a2 ,$a2 , 1
	
		
Strike_compare_8:
	
	bne $t4 , $t7 , Strike_compare_9
	addi $a1 ,$a1 , 1	
	addi $a3 , $a3 , 1
			

Strike_compare_9:
	
	beq $a1 , 3 , Strike_out
	move $a0 , $a1
	li $v0 , 1
	syscall

	la $a0 , msg_8
	li $v0 , 4
	syscall

	move $a0 , $a2
	li $v0 , 1
	syscall

	la $a0 , msg_10
	li $v0 , 4
	syscall
	
	j equal_check

Strike_out:
	
	la $a0 , msg_9			#Prints Strike Out and attempt numbers.
	li $v0 , 4
	syscall	

	la $a0 , msg_11
	li $v0 , 4
	syscall	

	addi $a3 , $a3 , 0
	move $a0 ,$a3
	li $v0 , 1
	syscall

	la $a0 , msg_12
	li $v0 , 4
	syscall	

	j Firstdisplay
exit: 
	li $v0 , 10 
	syscall

