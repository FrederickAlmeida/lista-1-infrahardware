.data
	# variaveis na memoria com valores diferentes para podermos debugar
	result_perfect_square: .word 1
	result_not_perfect: .word 0

.text
	# pedir o input de a e salvar em t0:
	li $v0, 5
	syscall
	move $t0, $v0
	
	#declarar b(t1) e i(t2) como zero
	addi $t1, $zero, 0
	addi $t2, $zero, 0
	
	#inicio do loop
	proxiteracao:
		# guardar o resultado de i*i em t3
		mult $t2, $t2
		mflo $t3	
		
		bne $t3, $t0, diferentes	# se a != i*i, pular para o label diferentes, caso contrario, executar o trecho abaixo
		addi $t1, $zero, 1
		sw $t0, result_perfect_square 
		j end
	
	diferentes: # incrementar i e ir para a proxima iteracao do loop
		addi $t2, $t2, 1
		bne $t2, 10, proxiteracao
		
		# se chegar até aqui, é por que b = 0 (se a parte que seta b =1 tivesse sido executada, teria pulado para o label end)
		sw $t0, result_not_perfect
	
	end:
		li $v0, 10
		syscall
	
