//lior $a0, 5                 // pc
//lior $a1, mem            // mem
jal supergarbage
j done

// lines = 4
// need to reset $ir after every branch, sw, or lw
supergarbage:
   
    subi $sp, 5

sw $ra, $sp            // callee saved registers

lior $t0, 1

add $t0, $sp

sw $s0, $t0            // store $s0

addi $t0, 1

sw $s1, $t0            // store $s1

addi $t0, 1

sw $s2, $t0            // store $s2

addi $t0, 1

sw $s3, $t0            // store $s3

// pc = $a0, mem = $a1
// op = $s0, srcA = $s1, srcB = $s2, dest = $s3

           lior $t0, $a0
           add $t0, $a1                 	// t1 = instruction = location of mem[pc]
           lw $s0, $t0                    	// s0 = instruction->op
    	   addi $t0, 1           
           lw $s1, $t0                    	// s1 = instruction->srcA
           addi $t0, 1                    	// location of instruction->srcB
           lw $s2, $t0                   	// s2 = instruction->srcB
           addi $t0, 1                    	// location of instruction->dest
           lw $s3, $t0                    	// s3 = instruction->dest
           addi $a0, 4                  	// pc = pc + 4   
// lines = 24

start_switch:

case0:                         				// mem[dest] = mem[srcA] - mem[srcB]; break;
   
    	   cmp $s0, 0
           bne case1               			// go to case1 if its not 0

           // mem[srcA]   
           lior $ir, $s1                 	// get srcA
           add $ir, $a1                		// get location of mem[srcA]
           lw $t0, $ir                     	// get the value of mem[srcA]
            
           // mem[srcB]
           lior $ir, $s2                 	// get srcB
           add $ir, $a1                 	// get location of mem[srcB]
           lw $t1, $ir                     	// get the value of mem[srcB]
   
           sub $t0, $t1                 	// mem[srcA] - mem[srcB], $t0 = $t0 - $t1
   
           // mem[dest]
           lior $ir, $s3                 	// get dest
           add $ir, $a1                 	// get location of mem[dest]
   
           sw $t0, $ir                   	// mem[dest] = mem[srcA] - mem[srcB];
   
           j end_switch
// lines = 13

case1:                                     // mem[dest] = mem[srcA] >> 1; break;

    cmp $s0, 1
           bne case2               // go to case2 if its not 1
   
           // mem[srcA] >> 1   
           lior $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
   
           srli $t0, 1                      // value of mem[srcA] >> 1;
   
           // mem[dest]
           lior $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]
   
           sw $t0, $ir                    // mem[dest] = mem[srcA] >> 1;
   
           j end_switch
// lines = 10

case2:                                     // mem[dest] = ~(mem[srcA] | mem[srcB]); break;
   
    cmp $s0, 2
           bne case3               // go to case3 if its not 2   
           // mem[srcA]   
          

lior $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
   
           // mem[srcB]
           lior $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
   
           // ~(mem[srcA] | mem[srcB]
           nor $t0, $t1         // ~(mem[srcA] | mem[srcB]

           // mem[dest]
           lior $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]
           sw $t0, $ir                    // mem[dest] = ~(mem[srcA] | mem[srcB])
   
           j end_switch
// lines = 13

case3:              // temp = mem[srcB]; mem[dest] = mem[mem[srcA]]; mem[mem[srcA]] = temp;

    cmp $s0, 3
           bne case4               // go to case4 if its not 3
   
           // mem[srcA]   
           lior $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
   
           // mem[srcB]
           lior $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
          
   
           // mem[mem[srcA]]
           add $t0, $a1               // get the location of mem[mem[srcA]]
    lior $t2, $t0        // save the location of mem[mem[srcA]] for later on
           lw $t0, $t0                    // value of mem[mem[srcA]]
   
           // mem[dest]
           lior $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]
           sw $t0, $ir                    // mem[dest] = mem[mem[srcA]]
   
           // mem[mem[srcA]] = temp
           sw $t1, $t2                   // mem[mem[srcA]] = temp
   
           j end_switch
// lines = 16

case4:
   
    cmp $s0, 4
           bne case5               // go to case5 if its not 4
   
           // mem[srcA]   
           lior $ir, $s1            // get srcA
           add $ir, $a1            // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]

           // mem[dest]
           lior $ir, $s3            // get dest
           add $ir, $a1            // get location of mem[dest]
           lw $t1, $ir                     // mem[dest]

    in $t1, $t0                    // in  mem[dest], mem[srcA];

           j end_switch
// lines = 10

case5:                                     // out mem[srcA], mem[srcB]; break;

    cmp $s0, 5
           bne case6           // go to case6 if its not 5
   
           // mem[srcA]   
           lior $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]

           // mem[srcB]
           lior $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
   
           out $t0, $t1                  // out mem[srcA], mem[srcB];

           j end_switch
// lines = 10

case6:

    cmp $s0, 6
           bne case7           // go to case7 if its not 6

           // mem[dest]
           lior $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]   
           sw $a0, $ir                   // mem[dest] = pc
   
           lior $ir, $s1                  
           add $ir, $a1                 // t1 = location of mem[srcA]
           lw $t1, $ir                     // value of mem[srcA]

    cmp $t1, 0
           blt case6if                  // if mem[srcA] < 0, case6if
           j end_switch
   
case6if:
           lior $ir, $s2        // this is srcB
           add $ir, $a1                 // get the location of mem[srcB]
           lw $t1, $ir                     // value of mem[srcB]
           lior $a0, $t1                // pc = mem[srcB]
           j end_switch
// lines = 16

case7:

    cmp $s0, 7
           bne end_switch
   
           lior $v0, $a0            // $v0 = $a0

lw $ra, $sp            // restore saved registers

lior $t0, 1

add $t0, $sp

lw $s0, $t0            // reload $s0

addi $t0, 1

lw $s1, $t0            // reload $s1

addi $t0, 1

lw $s2, $t0            // reload $s2

addi $t0, 1

lw $s3, $t0            // reload $s3

           jr $ra

// lines = 18

end_switch:
           j supergarbage            // return to beginning of loop

done:
// lines = 1

// 13.25 average per case
// (i*i)*(5+W)
// i = 13.25 + 24 + 1 + 4 = 42.25
// (42.25 * 42.25)*(5+14) = 33916.1875