.data
    pergunta1: .asciiz "Entre um numero: "
    pergunta2: .asciiz "Entre outro numero: "
    resposta: .asciiz "Os numeros multiplicados retornam: "

.text
	main:
		# Printa a pergunta 1
		li $v0, 4
		la $a0, pergunta1
		syscall
	
		# Le o primeiro numero
		li $v0, 5
		syscall
        	move $a1, $v0
		
		# Printa a pergunta 2
        	li $v0, 4
		la $a0, pergunta2
		syscall
	
		# Le o segundo numero
		li $v0, 5
		syscall
        	move $a2, $v0
		
		# Chama a funcao
		jal multiplyNumbers
		
		# Printa o texto da resposta
		li $v0, 4
		la $a0, resposta
		syscall

		# Printa a resposta
		li $v0, 1
		move $a0, $v1
		syscall
		
	
	# Encerra o programa
	li $v0, 10
	syscall
	
	# Implementacao da funcao
	multiplyNumbers:
		mul $v1, $a1, $a2
		jr $ra
