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

