lior $t0, 0
lior $t1, 2
cmp $t0, $t1
bne case0
j done

case0:
lior $t2, 0xf 	// 8: t2 = f
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

// dump_reg
//0: 0
//1: 2
//2: 0
//3: 0
//4: 0
//5: 0
//6: 0
//7: 2
//8: f
//9: e
//10: d
//11: 0
//12: 0
//13: 0
//14: 0
//15: 2 