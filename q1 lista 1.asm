.data
	resultado: .word

.text
	# coletar o input (a) e salvar em t0
	li $v0, 5
	syscall
	move $t0, $v0
	
	# coletar o input de (b)
	li $v0, 5
	syscall
	move $t1, $v0
	
	# verificar se a = b, a < b ou a > c
	beq $t0, $t1, iguais
	
	slt  $t3, $t0, $t1
	beq $t3, $zero, a_maior
	
	# se o codigo chegou até aqui, entao a < b
	sw $t0, resultado
	j end
	
	iguais: # caso a = b
		add $t3, $t0, $t1
		sw $t3, resultado
		j end
	
	a_maior: # caso a > b
		sw $t1, resultado
	
	end:
		li $v0, 10
		syscall
		