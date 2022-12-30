.data 
	msg1: .asciiz "Digite um número: "
	msg2: .asciiz "Digite outro número: "
 	msgMod: .asciiz "O valor de a mod b é "
 	msgZero: .asciiz "Programa finalizado porque b é 0 e não possível fazer divisão por 0"
.text  
	
	.main:
		la $a0, msg1
		jal imprimeMsg
		jal leInteiro
		
		move $t0, $v0
		
		la $a0, msg2
		jal imprimeMsg
		jal leInteiro
		
		move $a0, $t0
		move $a1, $v0
		move $a2, $a0
		
		jal retornaMod
		jal encerraPrograma
		
		
	#recebe string em $a0 e a imprime	
	imprimeMsg:
		li $v0, 4
		syscall 
		jr $ra
		
	imprimeInteiro:
		li $v0, 1
		syscall
		jr $ra
	
	#le inteiro e armazena em $v0	
	leInteiro:
		li $v0, 5
		syscall
		jr $ra
	#finaliza	
	encerraPrograma:
		li $v0, 10
		syscall 
	#função da condição de a ser negativo
	printaMod:
		move $t1, $a0
		add $t2, $t1, $a1
		la $a0, msgMod
		jal imprimeMsg
		move $a0, $t2
		jal imprimeInteiro
		jal encerraPrograma
	#função da divisão por zero
	falhaZero:
		la $a0, msgZero
		jal imprimeMsg
		jal encerraPrograma
	recebe1:
		li $v1, 1
		jal encerraPrograma	
	#recebe a e b em $a0 e $a1, e retorna o mod em $v0
	retornaMod:
		blt $a2, $zero, recebe1
		beq $a1, $zero, falhaZero
		blt $a0, $zero, printaMod
		sub $t0, $a0, $a1
		move $a0, $t0
		jal retornaMod
		jr $ra
