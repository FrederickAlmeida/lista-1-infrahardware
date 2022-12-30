.data
	#definindo as variáveis
	b: .word 2
	res: .word 1
	i: .word 0
.text
	li $v0, 5 #recebendo o input
	syscall #chamando o sistema para pegar o input
	move $t0, $v0 #movendo a entrada parar $t0
	lw $t1, res #carregando res
	lw $t2, i #carregando i
	
	FOR:
		slt $t3, $t2, $t0 #t3 é o resultado de st2 < st0
		beq $t3, $zero, EXIT # se o resultado de t3 for 0, assim 0=0, pule para EXIT
		sll $t1, $t1, 1 #dê um shift left em 1 casa (multiplicar por 2)
		addi $t2, $t2, 1 #i++
		j FOR #jump para voltar ao for
	EXIT: #saída da função
		sw $t1, res	#guardar o resultado na memoria

	 
