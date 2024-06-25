  # labwork.S
  # Written 2015-2017 by F Lundevall
  # Skeleton file for IS1200/IS1500 lab 1.
  # The macros PUSH and POP are in the public domain.
  # Please add your own code at the end of the file.

  #
  # Please keep the two macros PUSH and POP unchanged
  #
.macro	PUSH reg
	addi	$sp,$sp,-4
	sw	\reg,0($sp)
.endm

.macro	POP reg
	lw	\reg,0($sp)
	addi	$sp,$sp,4
.endm

  #
  # Please add your own code below this line
  #

.data
.global hexasc
.global delay 
.global time2string
.global enable_interrupt

.text

 hexasc: 
 	andi $a0,$a0,0xf
 	
 	addi $v0,$0,0x30
 	addi $t0,$0,0x9
 	
 	ble $a0,$t0,foo
 	nop
 	addi $v0,$v0,0x7
 	
foo:
 	add $v0,$a0,$v0
 	jr  $ra
 	nop
 	

delay:
 
	PUSH 	$ra
	
	li	$t1, 3000 # Constant which delays the time 
	move	$t0,$a0
	
while:
	blez	$t0,done
	nop
	addi	$t0,$t0,-1
	li	$t2,0
	
for:
	beq	$t1,$t2,while
	nop
	addi	$t2,$t2,1
	j	for
	nop
 done:
 	POP	$ra
 	jr	$ra
 	nop
	

 	
 	
 
 time2string:
 
 	PUSH	$s0			
 	PUSH	$s1
 	PUSH	$ra			
 	
 	add	$s0,$0,$a0		
 	add	$s1,$0,$a1		
 	
 	
 	andi	$t0,$s1,0xf000  	
 	srl	$a0,$t0,12		
 	jal	hexasc		
 	nop		
 	sb	$v0,0($s0)		
 	
 	andi	$t1,$s1,0x0f00	
 	srl	$a0,$t1,8		
 	jal	hexasc	
 	nop 				
 	sb	$v0,1($s0)		
 	
 	li	$t2,0x3A		
 	sb	$t2,2($s0)
 	
 	
 	andi	$t3,$s1,0x00f0
 	srl	$a0,$t3,4
 	jal	hexasc
 	nop
 	sb	$v0,3($s0)
 	
 	andi	$t4,$s1,0x000f
 	move	$a0,$t4
 	jal	hexasc
 	nop
 	sb	$v0,4($s0)



next:
 	
 	li	$t5,0x00		
 	sb	$t5,5($s0)
 	
 	POP	$ra
 	POP	$s1
 	POP	$s0
 	
 	jr      $ra
 	nop

enable_interrupt:
	ei 
	jr $ra
	nop

  

