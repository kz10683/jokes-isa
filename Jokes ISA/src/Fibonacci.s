lior $a0, 7
jal fib
j done
// 3 lines
fib: // for lior, if reset bit is 1, then it is a register. else, it is an immediate
	subi $sp, 3		 // decrement stack pointer
	sw $ra, $sp		 // store stack pointer into ra

	lr 1
	add $ir, $sp
	sw $s0, $ir		  // store first fib(n-1)

	lr 2
	add $ir, $sp
	sw $s1, $ir		  // store next fib(n-2)

	lior $s0, $a0	            // get current // ($s0 = $a0)

	cmp $s0, 0
	blt deadbeef		// blt $s0, 0, deadbeef

	cmp $s0, 2
	beq one
	blt one			// ble $s0, 2, one

	lr 29			// loads 29 into $ir
	cmp $s0, $ir
	beq twentynine 	// beq $s0, 29, twentynine

	lr 30			// loads 30 into $ir
	cmp $s0, $ir
	beq thirty		// beq $s0, 30, thirty

	lr 48			// loads 48 into $ir
	cmp $s0, $ir
	beq big1		// beq $s0, 48, big1

	lr 49			// loads 49 into $ir
	cmp $s0, $ir
	beq big2		// beq $s0, 49, big2

	lior $a0, $s0		// load s0 into a0
	subi $a0, 1		 // addi $a0, $s0, -1  and calculate fib(n-1)
	jal fib

	lior $s1, $v0		 // addi $s1, $v0, 0            // save fib(n-1)

	lior $a0, $s0
	subi $a0, 2		 // addi $a0, $s0, -2           // calculate fib(n-2)
	jal fib

	add $v0, $s1		 // add $v0, $v0, $s1           // add fib(n-1) + fib(n-2)
	j exit
 // 35 lines
deadbeef:
	// 111 1011 / 1 1010 1011 / 0 1101 1111 / 0 1110 1111
	lr 239
	lior $v0, $ir	// first 9 bits stored
	lr 223
	sloi $v0, 9	// first 18 bits stored
	lr 427
	slli $ir, 3	// need to shift extra 2 bits to 18th position for sloi
	sloi $v0, 15	// first 27 bits stored
	lr 123
	slli $ir, 12
	sloi $v0, 15	// 34 bits stored in $t0
	j exit
// 11 lines
one:
	lior $v0, 1                   // add 1 to result
	j exit
// 2 lines
twentynine:
	// 1 / 1 1110 1100 / 0 1011 0101
	lr 181
	lior $v0, $ir
	lr 492
	sloi $v0, 9
	lr 1
	slli $ir, 3
	sloi $v0, 15
	j exit
// 8 lines    
thirty:
	// 832030 = 11 / 0 0101 1001 / 0 0001 1110
	lr 30
	lior $v0, $ir
	lr 89
	sloi $v0, 9
	lr 3
	slli $ir, 3
	sloi $v0, 15
	j exit
// 8 lines    
big1:
	// 4807526976 = 10 0011 / 1 1010 0011 / 0 1000 0101 / 0 0100 0000
	lr 64
	lior $v0, $ir
	lr 133
	sloi $v0, 9
	lr 419
	slli $ir, 3
	sloi $v0, 15
	lr 35
	slli $ir, 12
	sloi $v0, 15
	j exit
// 11 lines
big2:
	// 7778742049 = 11 1001 / 1 1110 1001 / 1 0001 0111 / 1 0010 0001
	lr 289
	lior $v0, $ir
	lr 279
	sloi $v0, 9
	lr 489
	slli $ir, 3
	sloi $v0, 15
	lr 57
	slli $ir, 12
	sloi $v0, 15
	j exit
 // 11 lines
exit:           
	lw $ra, $sp	             // reload next ra

	lr 1
	add $ir, $sp
	lw $s0, $ir		 // reload next fib(n-1)

	lr 2
	add $ir, $sp
	lw $s1, $ir   	            // reload next fib(n-2)

	addi $sp, 3
	jr $ra                      // go back to the next address location call
// 9 lines
done:

// 8.5 average per case
// (i*i)*(5+W)
// i = 8.5 + 9 + 3 + 35 = 55.5
// (55.33333333 * 55.5)*(5+14) = 58524.75 EDP
