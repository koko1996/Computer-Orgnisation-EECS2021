         .text         
main:    addi     $sp, $sp, -4 
		 sw       $ra, 0($sp)    
         addi     $a0, $0, 16        
         jal      SB                # call the constructor 
         add      $s0, $0, $v0 
         add      $a0, $0, $s0       
         addi     $a1, $0, 'A'       
         jal      append            # append 'A' 
         add      $a0, $0, $s0 
         addi     $a1, $0, 'B' 
         jal      append             # append 'B' 
		 add      $a0, $0, $s0 
         addi     $a1, $0, 'C' 
         jal      append             # append 'C' 
		 add      $a0, $0, $s0 
         addi     $a1, $0, 'D' 
         jal      append             # append 'C' 
         add      $a0, $0, $s0 
         addi     $v0, $0, 4         
         syscall                    # print the string at a0 
		 
		 jal 	  println

         add      $a0, $0, $s0 
		 addi 	  $a1, $0, 0
		 addi	  $a2, $0, 'K'
		 jal 	  setCharAt

         add      $a0, $0, $s0 
		 addi 	  $a1, $0, 1
		 addi	  $a2, $0, 'O'
		 jal 	  setCharAt
		 
         add      $a0, $0, $s0 
		 addi 	  $a1, $0, 2
		 addi	  $a2, $0, 'K'
		 jal 	  setCharAt

         add      $a0, $0, $s0 
		 addi 	  $a1, $0, 3
		 addi	  $a2, $0, 'O'
		 jal 	  setCharAt
		 
         add      $a0, $0, $s0 
         addi     $v0, $0, 4         
         syscall                    # print the string at a0 
		 		 
         
		 
		 lw       $ra, 0($sp)         
         addi     $sp, $sp, 4 
		 jr         $ra         