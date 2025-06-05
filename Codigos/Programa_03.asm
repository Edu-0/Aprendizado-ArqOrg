# Eduardo J.S.

# int somarVetRecursivo(int vetor[], int tam){
#     tam--;
#     if(tam < 0) return 0;
#     return vetor[tam] + somarVetRecursivo(vetor, tam);
# }

.data

vetor: .word 1,2,3,4,5,6,7,8,9,10

.text

jal zero, main

# sumVetRec
# a0 = return	(soma acumulada)
# a1 = vetor	(endereço base)
# a2 = tam	(tamanho restante)
# t0 = valorAtual (valor atual na posição tam-1)
#
# 0(sp) -> ra (endereço de retorno)
# 4(sp) -> t0 (valor atual do retorno)
sumVetRec:
	#Empilha
	addi sp, sp, -8
	sw ra, 0(sp)

	# Função
	blt a2, zero, returnSoma	# Caso (tam < 0) pula para returnSoma
	
	addi a2, a2, -1		# tam--
	
				# Movendo-se pelo vetor
	slli t0, a2, 2 		# 4*i
	add t0, t0, a1 		# 4*i+vetor[]
	lw t0, 0(t0) 		# t0 = vetor[i]
	
	sw t0, 4(sp)		# Empilha t0, para somar depois
	
	jal ra, sumVetRec	# sumVetRec(vetor, tam-1)
	
	# Desempilha
	
	lw ra, 0(sp)
	lw t0, 4(sp)
	addi sp, sp, 8
	add a0, a0, t0		# a0 += t0 | Somando ao registrador de return
	jalr zero, ra, 0	# Continua, chamando debaixo do "jal ra, sumVetRec" + 4, caindo no desempilha
	
returnSoma:

	jalr zero, ra, 0	# Primeiro desvio para fora da recursividade


main:
	la a1, vetor		# a1 = vetor[]
	addi a2, zero, 10	# a2 = 10 (tam)
	jal ra, sumVetRec	# sumVetRec(a1, a2)
	
	addi a7, zero, 1
	ecall			# Imprime a soma
	
	addi a7, zero, 10
	ecall			# Finaliza o programa
