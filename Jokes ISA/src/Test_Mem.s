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
 
// dump_reg
//0: 0
//1: ff
//2: ff
//3: 0
//4: 0
//5: 0
//6: e
//7: f
//8: e
//9: e
//10: ff
//11: 0
//12: 0
//13: 0
//14: 0
//15: 0