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