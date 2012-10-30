.data
foo:
	.word 0x123
fooPtr:
	foo	
fooPtr2:
	foo
fooPtr3:
	fooPtr2

.text

lior $a0, 5                 // pc
lior $a1, mem                // mem
jal supergarbage
j done

// lines = 4
// need to reset $ir after every branch, sw, or lw
supergarbage:
   
    subi $sp, 5

sw $ra, $sp            // callee saved registers

add $ir, $sp

subi $ir, 1

sw $s0, $ir            // store $s0

add $ir, $sp

subi $ir, 2

sw $s1, $ir            // store $s1

add $ir, $sp

subi $ir, 3

sw $s2, $ir            // store $s2

add $ir, $sp

subi $ir, 4

sw $s3, $ir            // store $s3

           add $ir, $a0
           add $ir, $a1                 // t1 = instruction = location of mem[pc]
           lw $s0, $ir                    // s0 = instruction->op
           addi $ir, 1                    // location of instruction->srcA
           lw $s1, $ir                    // t0 = instruction->srcA
           addi $ir, 1                    // location of instruction->srcB
           lw $s2, $ir                    // t0 = instruction->srcB
           addi $ir, 1                    // location of instruction->dest
           lw $s3, $ir                    // t0 = instruction->dest
           addi $a0, 1                  // pc = pc + 1   
// lines = 24

start_switch:

case0:                         // mem[dest] = mem[srcA] - mem[srcB]; break;
   
    cmp $s0, 0
           bne case1               // go to case1 if its not 0
   
           // mem[srcA]   
           add $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
            
           // mem[srcB]
           add $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
   
           sub $t0, $t1                 // mem[srcA] - mem[srcB], $t0 = $t0 - $t1
   
           // mem[dest]
           add $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]
   
           sw $t0, $ir                    // mem[dest] = mem[srcA] - mem[srcB];
   
           j end_switch
// lines = 13

case1:                                     // mem[dest] = mem[srcA] >> 1; break;

    cmp $s0, 1
           bne case2               // go to case2 if its not 1
   
           // mem[srcA] >> 1   
           add $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
   
           srl $t0, 1                      // value of mem[srcA] >> 1;
   
           // mem[dest]
           add $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]
   
           sw $t0, $ir                    // mem[dest] = mem[srcA] >> 1;
   
           j end_switch
// lines = 10

case2:                                     // mem[dest] = ~(mem[srcA] | mem[srcB]); break;
   
    cmp $s0, 2
           bne case3               // go to case3 if its not 2   
           // mem[srcA]   
           add $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
   
           // mem[srcB]
           add $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
   
           // ~(mem[srcA] | mem[srcB]
           nor $t0, $t1         // ~(mem[srcA] | mem[srcB]
          
           // mem[dest]
           add $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]
           sw $t0, $ir                    // mem[dest] = ~(mem[srcA] | mem[srcB])
   
           j end_switch
// lines = 13

case3:              // temp = mem[srcB]; mem[dest] = mem[mem[srcA]]; mem[mem[srcA]] = temp;

    cmp $s0, 3
           bne case4               // go to case4 if its not 3
   
           // mem[srcA]   
           add $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]
   
           // mem[srcB]
           add $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
   
           // mem[mem[srcA]]
           add $t0, $a1               // get the location of mem[mem[srcA]]
    lior $t2, $t0        // save the location of mem[mem[srcA]] for later on
           lw $t0, $t0                    // value of mem[mem[srcA]]
   
           // mem[dest]
           add $ir, $s3                 // get dest
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
           add $ir, $s1            // get srcA
           add $ir, $a1            // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]

    in $t2, $t0                    // in  mem[dest], mem[srcA];

           // mem[dest]
           add $ir, $s3            // get dest
           add $ir, $a1            // get location of mem[dest]
           sw $t2, $ir                     // mem[dest]
   
           j end_switch
// lines = 10

case5:                                     // out mem[srcA], mem[srcB]; break;

    cmp $s0, 5
           bne case6           // go to case6 if its not 5
   
           // mem[srcA]   
           add $ir, $s1                 // get srcA
           add $ir, $a1                 // get location of mem[srcA]
           lw $t0, $ir                     // get the value of mem[srcA]

           // mem[srcB]
           add $ir, $s2                 // get srcB
           add $ir, $a1                 // get location of mem[srcB]
           lw $t1, $ir                     // get the value of mem[srcB]
   
           out $t0, $t1                  // out mem[srcA], mem[srcB];

           j end_switch
// lines = 10

case6:

    cmp $s0, 6
           bne case7           // go to case7 if its not 6

           // mem[dest]
           add $ir, $s3                 // get dest
           add $ir, $a1                 // get location of mem[dest]   
           sw $a0, $ir                   // mem[dest] = pc
   
           add $ir, $s1                  
           add $ir, $a1                 // t1 = location of mem[srcA]
           lw $t1, $ir                     // value of mem[srcA]

    cmp $t1, 0
           blt case6if                  // if mem[srcA] < 0, case6if
           j end_switch
   
case6if:
           add $ir, $s2
           add $ir, $a1                 // get the location of mem[srcB]
           lw $t1, $ir                     // value of mem[srcB]
           add $a0, $t1                // pc = mem[srcB]
           j end_switch
// lines = 16

case7:

    cmp $s0, 7
           bne end_switch
   
           lior $v0, $a0        // $v0 = $a0

lw $ra, $sp        // restore saved registers

add $ir, $sp

addi $ir, 1

lw $s0, $ir

add $ir, $sp

addi $ir, 2

lw $s1, $ir

add $ir, $sp

addi $ir, 3

lw $s2, $ir

add $ir, $sp

addi $ir, 4

lw $s3, $ir

addi $sp, 5

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