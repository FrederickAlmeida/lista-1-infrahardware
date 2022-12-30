.data
	arrayteste: .word 1, 8, 25, 31, 125 #array dos números que queremos fazer os testes
	arraytestesize: .word 16 # maior índice do array, o primeiro é 0 e o quinto 16 ( 0 + 4x4 ) 
	arrayvazio: .space 20 #tamanho máximo do array auxiliar = arrayteste
	arraycubosperfeitos: 0, 1, 8, 27, 64, 125, 216, 343, 512, 729, 1000, 1331, 1728, 2197, 2744, 3375, 4096, 4913, 5832, 6859, 8000, 9261
.text 
	lw $t0, arraytestesize #último índice será salvo no registrador
	li $t1, 0  #iterador do arrayteste
	li $t2, 0 #iterador do arrayvazio
	li $t3, 0 #iterador do array de cubos perfeitos
	addi $t4, $t0, 4 #$t4 representa o índice onde deverá ser feita a parada do programa, pois excedemos o último índice do arrayteste
	li $t5, 92 #extrapolou o limite do array perfeito, portando um "ciclo" é terminado
	
	loopinterar:
	 lw $t6, arrayteste($t1) # armazena o arrayteste[$t1]
	 lw $t7, arraycubosperfeitos($t3) # armazena o arraycubosperfeito[$t3]
	 beq $t7, $t6, match #se ambos são iguais, então encontramos um cubos perfeito, e deve ser adc no array secundario
	 addi $t3, $t3, 4 #upamos o "j" do array de cubos perfeitos
	 beq $t3, $t5, upar
	b loopinterar 
	
	upar:
		addi $t1, $t1, 4 # i++ do array principal
		li $t3, 0 # precisamos zerar novamente o valor do iterador do array de cubos perfeitos
		beq $t4, $t1, acabou #condiçao de saida para termino do programa, todo o array inicial foi percorrido
	b loopinterar
	
	match:
		sw $t7, arrayvazio($t2)
		addi $t1, $t1, 4 # i++ do array principal
		addi $t2, $t2, 4 # j++ do array sec
		li $t3, 0 #reiniciar array de cubos
		beq $t4, $t1, acabou #condiçao de saida para termino do programa, todo o array inicial foi percorrido
	b loopinterar
	
	acabou:
		li $v0, 10
		syscall
		
		
		
	 
	
