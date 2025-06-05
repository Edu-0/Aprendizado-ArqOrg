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
#
# void imprimirPrimos(){
#     int impressos = 0;
#     int num = 100;
# 
#     while(impressos < 10){
#         if(!verificarPrimo(++num))
#             continue;
#         cout << num << endl;
#         impressos++;
#     }
# }

.data

newline: .asciz "\n"

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
	
		addi a0, zero, 0	# Return 0
		jalr zero, ra, 0
		
	retorna1:
	
		addi a0, zero, 1	# Return 1
		jalr zero, ra, 0


imprimir_primos:
	
	addi sp, sp, -16
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	
	addi s0, zero, 0			# t0 = impressos
	addi s1, zero, 100			# t1 = num
	addi s2, zero, 10			# t2 = 10 (Comparar com t0)
	
	loop:
		add a1, zero, s1		# Passo s1 como parâmetro 1 (num)
		jal ra, verificar_primo		# Verifico se é primo
		
		add t0, zero, s1		# Caso não volte para a próxima iteração, adiciono t1 (num primo) em a0
		addi s1, s1, 1			# Faço num++, porque sendo primo ou não, aumenta
		
		beq a0, zero, loop		# Se ret == 0 (não primo), continue (volta para do)
		
		add a0, zero, t0
		addi a7, zero, 1		# Imprimo o valor
		ecall
		
		addi s0, s0, 1			# Impressos++
		
		bge s0, s2, exit		# Se impressos >= 10 (Máximo), return para saída
		
		la a0, newline			# Um "\n"
		addi a7, zero, 4
		ecall
		
		jal zero, loop			# Caso não tenha chegado ao máximo, volto para o loop
	
	exit:
		lw ra, 0(sp)
		lw s0, 4(sp)
		lw s1, 8(sp)
		lw s2, 12(sp)
		addi sp, sp, 16
		jalr zero, ra, 0		# Return
				
main:

	jal ra, imprimir_primos
	
	addi a7, zero, 10
	ecall
