.data
   break_line: .asciiz "\nvalor: "
.text

main:
   li $t0, 8162
loop:
   addi $t0, $t0, -1
   jal print_value
   beqz $t0, end_loop
   j loop
     
print_value:
   li $v0, 4
   la $a0, break_line
   syscall
   
   move $a0, $t0
   li $v0, 1
   syscall
   jr $ra  
   
end_loop: