         .globl fini         
         .text         
main:    #---------------------    
		 addi     $t0, $0, 60
		 addi     $v0, $0, 5        # v0 = readInt 
         syscall  
		 add      $t1, $0, $v0
		 slt 	  $t4, $t0, $t1 
		 beq 	  $t4, $0 , XX
		 addi     $v0, $0, 1        # service #1 
		 add      $t2, $t1,$t0
 		 add      $a0, $0,  $t2      # printInt 
		 syscall
		 
		 li  	  $v0, 10
		 syscall 
		 
		 XX: 
         addi     $v0, $0, 1        # service #1 
		 sub      $t2, $t0, $t1
		 add      $a0, $0,  $t2      # printInt 
		 syscall
		 
		 
         #---------------------         
fini:    jr       $ra               #    return    		 
