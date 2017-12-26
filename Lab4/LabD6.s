		 .globl         SB         
         .globl         append         
         .globl         setCharAt                           
         .text         
SB:      #-------------------- # a0 = maximum size 
         addi     $v0, $0, 9 
         syscall                
         sb       $0, 0($v0)    # null terminator  
         jr       $ra            
		 
		 
append:  #---------------------a0=reference,  a1=char    
         lb     $t0, 0($a0)         
		 
loop:    beq    $t0,$0,TheNull
	 addi   $a0,$a0,1
	 lb     $t0,0($a0)         
			
			
		 j  loop

TheNull: sb		$a1,0($a0)
	 sb		$0,1($a0)
			
			

         jr         $ra
		 

setCharAt:#------------------a0=string, a1=position, a2=char 
		 addi 	$t0,$a1,0  #counter
		 
looper:  beq    $t0,$a1,TheNull2
	 addi   $t0,$t0,1
		
	 j  looper		 
		 
TheNull2:
	add     $a0, $t0, $a0 
	sb	$a2, 0($a0)
			
	jr 	$ra
     
