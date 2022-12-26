.data
	# 3 inteiros armazenados na memória:
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
	
	# caso alguma das condições abaixo seja satisfeita, não será um triângulo
	
	bge $t1, $t6, nao_triangulo
	bge $t2, $t5, nao_triangulo
	bge $t3, $t4, nao_triangulo
	
	
	beq $t1, $t2, talvez_equilatero # irá checar se é equilátero
	j talvez_esc # como nãi é equilátero, irá checar se é escaleno
	
	talvez_equilatero:
		beq $t2, $t3, equilatero # é equilátero
		
		
		# como não é equilátero, mas possui dois lados iguais é isóceles:
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
		# irá checar se tem dois lados iguais para ser isóceles, caso contrário será escaleno
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
		

