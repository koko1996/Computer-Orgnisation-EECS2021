         .globl fini         
         .text         
main:    #---------------------    
         addi     $t0, $0, 60       # t0 = 60 
         addi     $t1, $0, 7        # t1 = 7 
         add      $t2, $t0, $t1     # t2 = t0+t1 
		 sub      $t3, $t0, $t1		# t3 = t0-t1
         #---------------------         
         addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $t2      # printInt 
		 syscall
		 addi     $v0, $0, 11        # service #1 
		 addi     $a0, $0, ' '		 
		 syscall
		 addi     $v0, $0, 1        # service #1 
		 add      $a0, $0, $t3      # printInt 
         syscall                    # do print 
         #---------------------         
fini:    jr       $ra               #    return    		 