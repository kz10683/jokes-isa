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

// Testing bitwise

lior $t0, 0
lior $t1, 15		// 7: t1 = 1111 = 0xf
or $t0, $t1			// 6: t0 = 1111 = 0xf

lior $t3, 12
and $t3, $t0		// 9: t3 = 1010 = 0xc

lior $s0, 6
andi $s0, 15		// 10: s0 = 0110 = 0x6

lior $s1, 0
ori $s1, 0xf		// 11: s1 = 1111 = 0xf

lior $s3, 0x6
xor $s3, $s1		// 13: $s3 = 1001 = 0x9

cmp $t3, 5			// 14: c0 = 0xc, 15: c1 = 0101 = 5

lior $a0, 8
slli $a0, 1

lior $t0, 5
lior $t1, 5
nor $t0, $t1		// reversed bits

// Testing Branch

lior $t0, 0
lior $t1, 2
cmp $t0, $t1
bne case0
j done

case0:
lior $t2, 0xf 		// 8: t2 = f
lior $t3, 0xf
cmp $t2, $t3
beq case1
j done

case1:
lior $t3, 0xe	// 9: t3 = e

done:
cmp $t0, $t1
blt case2
j done1

case2:
lior $s0, 0xd	// 10: s0 = d


done1:
cmp $t0, $t1
bgt case3
j done2

case3:
lior $ir, 1

done2:
lior $ra, 2		// 2: ra = 2

// Testing channel

lior $t0, 15
lior $s0, 2
out $t0, $s0

lior $t1, 8
in $t1, $s0
halt
out $t0, $s0

// Testing jump

jump1:
addi $t0, 1
j jump5

jump2:
addi $t0, 2
jal jump3
j done

jump3:
addi $t0, 3
jr $ra

jump4:
addi $t0, 4
j jump2

jump5:
addi $t0, 5
j jump4

done:

// Testing la

buka:
	la $t1 buka
supa:
	la $s0 supa
watdahell:
	la $t3 hollaatme // shouldn't work
	j buka

// Testing Mem

lior $t0, 15
lior $s0, 0
sw $t0, $s0
lw $t1, $s0		// 7: t1 = f

addi $s0, 1
lw $t2, $s0
lior $t0, 14	// 6: t0 = e
sw $t0, $s0
lw $t2, $s0		// 8: t2 = e

lior $s0, $t1
sw $t2, $s0
lior $t3, 1
lw $t3, $s0		// 9: t3 = e

lr 0xff			// 2: ir = ff
lior $s0, $ir	// 10: s0 = ff
sw $ir, $s0
lw $ra, $s0		// 1: ra = ff

// Testing sll/slli:

lior $t0, 15		// load reg 6 with 15
lior $t1, 1			// load reg 7 with 1
slli $t0, 2			// shift reg 6 2, so now 30
sll $t0, $t1		// shift reg 6 1, so now 60

// Testing srl/srli:

lior $t1, 4
srl $t0, $t1		// was 60, so now 3
srl $t0, 2			// so now 0
srl $t0, 4			// still 0

