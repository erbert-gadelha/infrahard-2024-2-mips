.data
   t_result:	.asciiz "result: "
   t_remainder:	.asciiz "\nremainder: "
   break_line:	.asciiz "\n"
   DIVIDENDO:	.word 42
   DIVISOR:	.word 12
   RESULT:	.word 0
   REMAINDER:	.word 0
.text

main:   
   lw $t0, DIVIDENDO	# dividendo = DIVIDENDO;
   lw $t1, DIVISOR	# divisor = DIVISOR;
   li $t2, 0		# result = 0;
   j divisao



exit:
   li $v0, 10
   syscall   
print_values:
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



divisao:
   
   slt $t4, $t0, $zero		    # dvsr_signal = (divisor < 0);
   beqz $t4, end_inverter_divisor   # if (divisor < 0)
   	sub $t0, $zero, $t0	    # 	divisor = -divisor;
   end_inverter_divisor:
   
   slt $t5, $t1, $zero		    # dvdn_signal = (dividendo < 0);
   beqz $t5, end_inverter_dividendo # if (dividendo < 0)
   	sub $t1, $zero, $t1	    # 	dividendo = -dividendo;
   end_inverter_dividendo:
   	

   loop_divisao:		     #
      blt $t0, $t1 end_loop_divisao  # while (dividendo >= DIVISOR) {
      sub $t0, $t0, $t1 	     #   dividendo-=DIVISOR;
      addi $t2, $t2, 1  	     #   result++;
      j loop_divisao		     #
   end_loop_divisao:		     # }


   beq $t4, $t5, end_inverter_result # if(dvsr_signal != dvdn_signal) {
   	sub $t2, $zero, $t2	     #	 result = -result;
   end_inverter_result:		     # }
         
   beqz $t4, end_inverter_remaining  # if(dvsr_signal == 1) {
   sub $t0, $zero, $t0		     #   remainder = -remainder
   end_inverter_remaining:	     # }
   
   sw $t0, RESULT    # RESULT = result;
   sw $t2, REMAINDER	# REMAINDER = remainder;
   jal print_values
   j exit
   
