fib:
    sub $sp, 3         // decrement stack pointer
    sw $ra, $sp         // store stack pointer into ra
   
    add $ir, 1       
    add $ir, $sp
    sw $s0, $ir          // store first fib(n-1)

    add $ir, 2       
    add $ir, $sp
    sw $s1, $ir          // store next fib(n-2)
   
    li $s0, 0
    add $ir, $a0
    add $s0, $ir                // get current //

    lr 0
    cmp $s0, $ir
    blt deadbeef        // blt $s0, 0, deadbeef
   
    lr 2
    cmp $s0, $ir
    blt one           
    beq one            // ble $s0, 2, one
   
    lr 29            // loads 29 into $ir
    cmp $s0, $ir
    beq twentynine     // beq $s0, 29, twentynine
   
    lr 30            // loads 30 into $ir
    cmp $s0, $ir
    beq thirty        // beq $s0, 30, thirty
   
    lr 48            // loads 48 into $ir
    cmp $s0, $ir
    beq big1        // beq $s0, 48, big1
   
    lr 49            // loads 49 into $ir
    cmp $s0, $ir
    beq big2        // beq $s0, 49, big2
   
        
    li $a0, 0       
    subi $a0, 1
    add $a0, $s0         // addi $a0, $s0, -1  and calculate fib(n-1)
    jal fib
   
    li $s1, 0
    add $v0, 0
    add $s1, $v0         // addi $s1, $v0, 0            // save fib(n-1)
        
    li $a0, 0
    subi $s0, 2
    add $a0, $s0         // addi $a0, $s0, -2           // calculate fib(n-2)
    jal fib
        
    add $v0, $s1         // add $v0, $v0, $s1           // add fib(n-1) + fib(n-2)
    j exit
   
deadbeef:
    // 111 1011 / 1 1010 1011 / 0 1101 1111 / 0 1110 1111
    lr 239      
    li $v0, 0
    sloi $v0, 0    // first 9 bits stored
    lr 223   
    sloi $v0, 9    // first 18 bits stored   
    lr 427       
    sll $ir, 3    // need to shift extra 2 bits to 18th position for sloi
    sloi $v0, 15    // first 27 bits stored
    lr 123       
    sll $ir, 12   
    sloi $v0, 15    // 34 bits stored in $t0
    j exit
        
one:
    li $v0, 1                   // add 1 to result
    j exit
   
twentynine:
    // 1 / 1 1110 1100 / 0 1011 0101
    lr 181        
    li $v0, 0
    sloi $v0, 0
    lr 492
    sloi $v0, 9
    lr 1
    sll $ir, 3
    sloi $v0, 15
    j exit
   
thirty:
    // 832030 = 11 / 0 0101 1001 / 0 0001 1110
    lr 30       
    li $v0, 0
    sloi $v0, 0
    lr 89
    sloi $v0, 9
    lr 3
    sll $ir, 3
    sloi $v0, 15
    j exit
   
big1:
    // 4807526976 = 10 0011 / 1 1010 0011 / 0 1000 0101 / 0 0100 0000
    lr 64
    li $v0, 0
    sloi $v0, 0
    lr 133
    sloi $v0, 9   
    lr 419
    sll $ir, 3
    sloi $v0, 15   
    lr 35
    sll $ir, 12
    sloi $v0, 15   
    j exit

big2:
    // 7778742049 = 11 1001 / 1 1110 1001 / 1 0001 0111 / 1 0010 0001
    lr 289
    li $v0, 0
    sloi $v0, 0
    lr 279
    sloi $v0, 9
    lr 489
    sll $ir, 3
    sloi $v0, 15
    lr 57
    sll $ir, 12
    sloi $v0, 15
    j exit
   
exit:           
    lw $ra, $sp                 // reload next ra
   
    add $ir, 1       
    add $ir, $sp
    lw $s0, $ir         // reload next fib(n-1)

    add $ir, 2       
    add $ir, $sp
    lw $s1, $ir                   // reload next fib(n-2)

    addi $sp, 3
    jr $ra                      // go back to the next address location call

done: