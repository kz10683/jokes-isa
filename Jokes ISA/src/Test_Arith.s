// Testing lior/lr:

lior $t0, 9			// load reg 6 with 9
lior $t1, $t0		// load reg 7 with 9
lior $t2, 0			
subi $t2, 5			// load reg 8 with -5
lior $t3, $t2		// load reg 9 with -5 as well
lr 511				// load reg 2 with 511 (maximum value)

// Testing add/addi:

add $a0, $t0		// load reg 4 with 9
addi $a1, 4			// load reg 5 with 4
add $s0, $t3		// load reg 10 with -5
lior $s1, 3			
add $s1, $s0		// reg 11 is now -2
addi $s1, 1			// reg 11 is now -1 

// Testing sub/subi:

sub $s0, $t0		// load reg 10 with -5 - 9 = -14
subi $s1, 15		// load reg 11 with -1 - 15 = -16
lior $s2, $s1		// load reg 12 with -16
addi $s2, 15		// reg 12 is now -1

// Testing sloi:

lr 8
lior $t0, 4
sloi $t0, 4