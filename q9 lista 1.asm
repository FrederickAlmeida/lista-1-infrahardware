.globl __start
.ent __start

.data
	entrada: .asciiz "en1TRadA"
	vogais: .asciiz "aAeEiIoOuU"						# vogais
	consoantes: .asciiz "bBcCdDfFgGhHjJkKlLmMnNpPqQrRsStTvVwWxXyYzZ"	# consoantes
	
.text
__start:
	li $s0, 0	# salvar a primeira posicao do array com consoante (para shiftar)
	# se for maior que 122 (ascii), menor que 65, maior que 90 e menor que 97, nao é letra
	li $s2, 90
	li $s3, 65
	li $s4, 122
	li $s5, 97
	
# iterando pela entrada
	li $t0, -1	# variavel para iterar pela entrada
it:	addi $t0, $t0, 1
	lb $t1, entrada($t0)
	beqz $t1, end	# caso chegue no final da string
	
	# verificar se é menor que 65
	slt $t2, $t1, $s3
	bne $t2, $zero, notletter
	
	# verificar se é maior que 122
	slt $t2, $s4, $t1
	bne $t2, $zero, notletter
	
	# verificar se é maior que 90 e menor que 97
	slt $t2, $t1, $s5
	beq $t2, $zero, continue
	slt $t2, $s2, $t1
	bne $t2, $zero, notletter
	
continue:			# verificar se é vogal ou consoante
	li $t2, -1		# variavel para iterar pelas vogais
vloop:	addi $t2, $t2, 1
	lb $t3, vogais($t2)	# carregar o array das vogais
	beqz $t3, cons		# caso termine o array, ir para o array das consoantes
	bne $t1, $t3, vloop	# se o caractere atual das vogais for diferente do caractere atual da entrada, vá para o prox caractere das vogais
	
	# se for igual, vamos verificar se é maiusculo (maior ou igual a 97 na tabela ascii) ou minusculo
	slt $t4, $t3, $s5
	bne $t4, $zero, atpos	# se for maiusculo, entao podemos alterar a posicao, senao, teremos que deixar maiusculo
	addi $t3, $t3, -32
	sb $t3, entrada($t0)	# salvar a vogal maiuscula na entrada

atpos:	# vamos atualizar a posicao da vogal, shifitando tudo da primeira consoante do array (s0) ate a vogal (t3) 1 byte para a direita
	# t3: vogal, s0: começo do shift, t0: ate onde vamos shiftar
	add $t5, $t0, $zero 	# botar o valor de t0 (posicao da vogal) em t5, para nao perdermos o valor de t2
	add $t4, $t0, $zero	# reg para auxiliar o shift
poslop:	sgt $t7, $t5, $s0	# precisaremos shiftar enquanto t5 (posicao da vogal) > s0 (posicao da primeira consoante)
	beq $t7, $zero, endpos	# quando terminar o shift
	addi $t4, $t4, -1	# pegar o proximo char a ser shifitado
	lb $t6, entrada($t4)	# carregar o char em t6
	sb $t6, entrada($t5)	# shiftar
	addi $t5, $t5, -1	# mover t5 para o proximo char
	j poslop

endpos:	sb $t3, entrada($s0)	# mover a vogal para a antiga posicao da primeira consoante, que agora esta livre
	addi $s0, $s0, 1	# incrementar a variavel que guarda a posicao da primeira consoante
	j it			# ir para o proximo caractere da entrada

cons:	li $t2, -1 		# variavel para iterar pelas consoantes
cloop:	addi $t2, $t2, 1
	lb $t3, consoantes($t2)
	beqz $t3, it		# para caso chegue ao final do array das consoantes, o que nao deveria acontecer
	bne $t3, $t1, cloop	# caso a consoante seja diferente do caractere atual, va para a proxima consoante
	slt $t4, $t3, $s5	# verificar se é maiusculo ou minusculo
	beq $t4, $zero, it	# se t4 = 0, entao ja esta minusculo, senao, precisaremos somar com 32, para ficar minusculo
	addi $t3, $t3, 32
	sb $t3, entrada($t0)	# carregar a consoante minuscula na entrada
	j it

notletter:
	li $v1, 1
	li $v0, 10
	syscall

end:	li $v0, 4		# printar o resultado final
	la $a0, entrada
	syscall
	
	li $v0, 10		# encerrar o programa
	syscall
