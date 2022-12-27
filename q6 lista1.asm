.data
	int1: .word 50
	int2: .word 4
	result: .word 0
	remainder: .word 0
.text 
	lw $t1, int1
	li $s1, 0
	add $s1, $s1, $t1 # salva o n�mero inicial
	lw $t2, int2
	li $t3, 0 #quociente
	li $t4, 0 #resto
	li $s2, -1 # carrega o sinal negativo pra fazer trocas de sinal
	li $s3, 1 # inicialmente assume que os dois n�meros s�o positivos ($s3= sinal do primeiro)
	li $s4, 1 # ($3 = sinal do segundo)

	
	checa_sinal1:
		bgt $t1, 0, checa_sinal2
		li $s3, -1 # salva o sinal do primeiro como negativo
		mult $t1, $s2
		mflo $t1 # transforma ele para positivo pra facilitar a conta
		li $s1, 0
		add $s1, $s1, $t1 # atualiza o valor dele
		
	checa_sinal2:
		bgt $t2, 0, checa_maior
		li $s4, -1 # salva o sinal do segundo como negativo
		mult $t2, $s2 
		mflo $t2 # transforma ele para positivo pra facilitar a conta
		
		
	
	checa_maior:
		bge $t1, $t2, subtrai # enquanto o primeiro for maior que o segundo subtrai
		j resto # caso contr�rio vai calcular o resto
		
	subtrai:
		sub $t1, $t1, $t2
		addi $t3, $t3, 1 # soma 1 no quociente a cada subtra��o
		j checa_maior # volta pra checar se � maior
		
	resto:
		mult $t3, $t2 # multiplica o quociente pelo segundo n�mero
		mflo $t5
		sub $t4, $s1, $t5 # checa o resto por meio de uma subtra��o simples
	
	bgtz $s3, troca_sinal # se o primeiro for positivo, checa se o segundo � negativo
	bltz $s4, ambos_negativos # se o primeiro for negativo, checa se o segundo tamb�m �
	
	# se chegar nessa linha, s� o primeiro n�mero � negativo, logo invertemos os 2 sinais
	
	mult $t3, $s2
	mflo $t3 # quociente � multiplicado por -1
	mult $t4, $s2
	mflo $t4 # resto � multiplicado por -1
	j end
	
	troca_sinal:
		bgtz $s4, end # se o segundo tamb�m for positivo, encerra o programa
		# se for negativo, inverte os 2 sinais
		mult $t3, $s2
		mflo $t3 # quociente � multiplicado por -1
		mult $t4, $s2 
		mflo $t4 # resto � multiplicado por -1
		j end
	
	ambos_negativos: # se ambos forem negativos s� � necess�rio inverter o sinal do resto
		mult $t4, $s2
		mflo $t4
		
	
	end:
		sw $t3, result # salva o quociente em result
		sw $t4, remainder # salva o resto em remainder
		li $v0, 10
		syscall
