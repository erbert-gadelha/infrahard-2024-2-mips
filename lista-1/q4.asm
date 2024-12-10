.data
   t_result:	.asciiz "result: "
   t_remainder:	.asciiz "\nremainder: "
   break_line:	.asciiz "\n"
   DIVIDENDO:	.word 512
   DIVISOR:	.word 14
   RESULT:	.word 0
   REMAINDER:	.word 0
.text

main:
   lw $t0, DIVIDENDO	# dividendo = DIVIDENDO;
   lw $t1, DIVISOR	# divisor = DIVISOR;
   li $t2, 0		# result = 0;
   j loop_divisao   
   
loop_divisao:
   sub $t0, $t0, $t1	# dividendo-=DIVISOR;
   addi $t2, $t2, 1   	# result++;
   bge $t0, $t1 loop_divisao   
end_loop_divisao:
   sw $t0, RESULT	# RESULT = result;
   sw $t2, REMAINDER	# REMAINDER = remainder;
   jal print_value
   j exit
   
   
print_value:
   # IMPRIME ("result: ")
   li $v0, 4
   la $a0, t_result
   syscall
   # IMPRIME (result)
   move $a0, $t2
   li $v0, 1
   syscall
   
   # IMPRIME ("\nremainder: ")
   li $v0, 4
   la $a0, t_remainder
   syscall
   # IMPRIME (dividendo)
   move $a0, $t0
   li $v0, 1
   syscall
   
   jr $ra
   
exit:
   li $v0, 10
   syscall