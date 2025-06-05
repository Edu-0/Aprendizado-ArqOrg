# Eduardo J.S.

# int verificarPrimo(int n){
#     if(n < 2) return 0;
# 
#     for(int i = 2; i*i <= n; i++){
#         if(n % i == 0)
#             return 0;
#     }
#     return 1;
# }

.text

jal zero, main

verificar_primo:
 
 	addi t0, zero, 0
 	addi t1, zero, 1
 	addi t2, zero, 2
 	
 	blt a1, t2, retorna0
 	
 	add t3, zero, t2
 	
	for:
		
		mul t4, t3, t3		# i * i
		blt a1, t4, retorna1	# Retorna 1 se n < i * i
		
		rem t5, a1, t3		# n % i
		beq t5, t0, retorna0	# Retorna 0 se n % i == 0
		
		addi t3, t3, 1		# i++
		
		jal zero, for
	
	retorna0:
	
		addi a0, zero, 0
		jalr zero, ra, 0
		
	retorna1:
	
		addi a0, zero, 1
		jalr zero, ra, 0
	
			
main:
	addi a1, zero, 137
	jal ra, verificar_primo
	
	addi a7, zero, 1
	ecall
	
	addi a7, zero, 10
	ecall
