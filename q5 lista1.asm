.data
	# 3 inteiros armazenados na mem�ria:
	int1: .word 3
	int2: .word 4
	int3: .word 5
	s: .space 3

.text 
	lw $t1, int1
	lw $t2, int2
	lw $t3, int3
	add $t4, $t1, $t2
	add $t5, $t1, $t3
	add $t6, $t2, $t3
	
	# caso alguma das condi��es abaixo seja satisfeita, n�o ser� um tri�ngulo
	
	bge $t1, $t6, nao_triangulo
	bge $t2, $t5, nao_triangulo
	bge $t3, $t4, nao_triangulo
	
	
	beq $t1, $t2, talvez_equilatero # ir� checar se � equil�tero
	j talvez_esc # como n�i � equil�tero, ir� checar se � escaleno
	
	talvez_equilatero:
		beq $t2, $t3, equilatero # � equil�tero
		
		
		# como n�o � equil�tero, mas possui dois lados iguais � is�celes:
		# salva "iso" em s
		la $s0, s
		li $s1, 'i'
		sb $s1, ($s0)
		li $s1, 's'
		sb $s1, 1($s0)
		li $s1, 'o'
		sb $s1, 2($s0) 
		j end
	equilatero:
		# salva "eq" em s
		la $s0, s
		li $s1, 'e'
		sb $s1, ($s0)
		li $s1, 'q'
		sb $s1, 1($s0)
		j end
	
	nao_triangulo:
		# salva "not" em s
		la $s0, s
		li $s1, 'n'
		sb $s1, ($s0)
		li $s1, 'o'
		sb $s1, 1($s0)
		li $s1, 't'
		sb $s1, 2($s0) 
		j end
		
	talvez_esc:
		# ir� checar se tem dois lados iguais para ser is�celes, caso contr�rio ser� escaleno
		beq $t1, $t3, isoceles
		beq $t2, $t3, isoceles
		# salva "esc" em s
		la $s0, s
		li $s1, 'e'
		sb $s1, ($s0)
		li $s1, 's'
		sb $s1, 1($s0)
		li $s1, 'c'
		sb $s1, 2($s0) 
		j end
	
	isoceles:
		# salva "iso" em s
		la $s0, s
		li $s1, 'i'
		sb $s1, ($s0)
		li $s1, 's'
		sb $s1, 1($s0)
		li $s1, 'o'
		sb $s1, 2($s0) 
		j end
	
	end: # encerra o programa
		li $v0, 10
		syscall
		

