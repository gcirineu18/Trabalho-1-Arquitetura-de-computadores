# O código abaixo pretende implementar estruturas de repetição e output de valores para o user
.data
base: .word 0	# Inicializa a base com zero
expoente: .word 0	# Inicializa o expoente com zero
resultado: .word 1	# Inicializa o resultado com 1

.text
.globl main	# Define o corpo principal do programa como a label "main"

main:
 	# Ler primeiro número
    	li $v0, 5        # Syscall para ler inteiro
    	syscall
    	sw $v0, base     # Armazena o valor lido em base

    	# Ler segundo número
    	li $v0, 5        # Syscall para ler inteiro
    	syscall
    	sw $v0, expoente     # Armazena o valor lido em expoente

    	# Carregar os números e somar
    	lw $t0, base	# Carrega a base para $t0
    	lw $t1, expoente	# Carrega o expoente para $t1
    	lw $t2, resultado	# Carrega o resultado para $t2	
    	blt $t1, $t2, end	# Se $t1 < $t2 pula para o end
    	j potenciacao	# Pula para o cálculo da potência

# Para a potenciação o resultado será multiplicado pela base expoente vezes
potenciacao:
    	# Verifica se o expoente chegou a zero
    	beq $t1, $zero, end  # Se $t1 == 0, vai para end

	# Multiplica o resultado pela base
    	mul $t2, $t0, $t2	# Multiplica $t0 com $t2 e armazena em $t2
    	# Decrementa o expoente
    	sub $t1, $t1, 1		# Decrementa $t0

    	# Volta ao início do loop de potenciação
    	j potenciacao

end:
    	# Imprimir resultado
    	li $v0, 1        # Syscall para imprimir inteiro
    	move $a0, $t2    # Move o resultado para $a0
    	syscall

    	# Terminar o programa
    	li $v0, 10       # Syscall para encerrar o programa
    	syscall
	

	