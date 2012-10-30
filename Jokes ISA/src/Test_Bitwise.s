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

// dump_reg
//0: 0
//1: 0
//2: 0
//3: 0
//4: 10
//5: 0
//6: f
//7: f
//8: 0
//9: c
//10: 6
//11: f
//12: 0
//13: 9
//14: c
//15: 5