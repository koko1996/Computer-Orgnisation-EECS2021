        .globl         newc         
	.globl         sumint         
         .text         
newc:                  
         #---------------------------------------------         
         add      $t0, $0, $a0      # t0 = integer 
         add      $t1, $0, $a1      # t1 = address of the previous 
         # store the attributes somewhere in memory 
      

	 addi    $v0,    $0,    9    
         addi    $a0,    $0,    8    
         syscall    
		
         sw      $t0,    0($v0)    
         sw      $0,     4($v0)

	 beq     $t1,$0 , First      #check if the first one
	 sw	 $v0, 4($t1)		# store the address of this one in the previous element's next

First: 
		 
		 
	 jr         $ra         

sumint:                  
         #---------------------------------------------       
	 addi   $v0,$0,0	# answer
loop1:	 lw     $t0,0($a0)      # t0 = integer 
	 lw	$t1,4($a0) 	# t1 = address of next 

	 beq    $t1,$0,TheNull
	
	 add 	$v0,$v0,$t0
	
	 add    $a0,$0,$t1
	
			
			
	 j  loop1

TheNull:
	add 	$v0,$v0,$t0
	jr       $ra

#---------------------------------------------       
#---------------------------------------------       
#---------------------------------------------       
#---------------------------------------------       
		
main:		addi    $sp, $sp, -4 
		sw      $ra, 0($sp)    
	        addi    $s1, $0, 0	
	        addi    $s3, $0, 1 	# s3==1 	

	        addi     $v0, $0, 5        # v0 = readInt 
	        syscall         
	        add      $s0, $0, $v0	   # n = s0

	        addi     $v0, $0, 0        # v0 = 0  address 

loop:		beq      $s0,$s1 ,endOf   # i == n

	        addi     $s1, $s1, 1	  # i++

	        add      $a1, $0, $v0      # a1  address argument




	        addi     $v0, $0, 5        # v0 = readInt 
	        syscall         
	        add      $a0, $0, $v0	   # a0 integer argument
	
					
		jal 	 newc
		bne      $s1,$s3 ,NotFirst   # address of the first one
		addi	 $s4,$v0,0	      # address of the first one SAVE IN S4
NotFirst:
		j loop
		

endOf:
	
		bne	 $s0,$0,ISNOTZERO
		addi     $a0,$0, 0
		addi     $v0, $0, 1
		syscall		
		j Final
				
ISNOTZERO:	addi	$a0, $s4, 0
		jal     sumint
	
		add     $a0,$0, $v0
		addi    $v0, $0, 1
		syscall
#--------------------------------------------		
			
Final:		lw      $ra, 0($sp)         
		addi    $sp, $sp, 4
		jr      $ra
		

