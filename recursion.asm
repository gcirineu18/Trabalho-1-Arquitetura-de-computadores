.data
prompt: .asciiz "Digite um numero: "  # String para o prompt de entrada
result: .asciiz "O fatorial eh: "     # String para a mensagem de resultado

.text
.globl main  # Declara a função 'main' como global

main:
    li $v0, 4                 # Código para imprimir uma string
    la $a0, prompt            # Carrega o endereço do prompt
    syscall                   # Executa a impressão do prompt

    li $v0, 5                 # Código para ler um inteiro do usuário
    syscall                   # Executa a leitura do número
    move $a0, $v0             # Passa o número lido para $a0

    jal factorial             # Chama a função recursiva 'factorial'

    move $a1, $v0             # Prepara o resultado para impressão
    li $v0, 4                 # Código para imprimir uma string
    la $a0, result            # Carrega o endereço da mensagem de resultado
    syscall                   # Executa a impressão da mensagem

    li $v0, 1                 # Código para imprimir um inteiro
    move $a0, $a1             # Prepara o fatorial calculado para impressão
    syscall                   # Executa a impressão do fatorial

    li $v0, 10                # Código para encerrar o programa
    syscall                   # Encerra o programa

factorial:
    addi $sp, $sp, -8         # Reserva espaço na pilha
    sw $ra, 4($sp)            # Salva o valor de retorno ($ra)
    sw $a0, 0($sp)            # Salva o parâmetro $a0

    li $t0, 1                 # Carrega o valor 1 para comparar
    ble $a0, $t0, base_case   # Verifica se é o caso base (fatorial de 0 ou 1)

    addi $a0, $a0, -1         # Decrementa $a0 para a chamada recursiva
    jal factorial             # Chama recursivamente 'factorial'
    lw $a0, 0($sp)            # Restaura $a0 da pilha
    mul $v0, $a0, $v0         # Calcula o fatorial multiplicando os valores

    j end_factorial           # Pula para o final da função

base_case:
    li $v0, 1                 # Define o valor de retorno para o caso base (1)

end_factorial:
    lw $ra, 4($sp)            # Restaura $ra da pilha
    addi $sp, $sp, 8          # Libera o espaço na pilha
    jr $ra                    # Retorna para a função chamadora
