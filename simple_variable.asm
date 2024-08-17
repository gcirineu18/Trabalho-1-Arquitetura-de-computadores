.data
prompt: .asciiz "Digite um numero: "  # String para o prompt de entrada
result: .asciiz "A soma com 5 eh: "   # String para a mensagem de resultado
const_val: .word 5                    # Valor constante a ser somado

.text
.globl main  # Declara a função 'main' como global

main:
    li $v0, 4                 # Código para imprimir uma string
    la $a0, prompt            # Carrega o endereço do prompt
    syscall                   # Executa a impressão do prompt

    li $v0, 5                 # Código para ler um inteiro do usuário
    syscall                   # Executa a leitura do número
    move $a0, $v0             # Move o número lido para $a0

    jal add_const             # Chama a função 'add_const' para somar o valor constante

    move $a1, $v0             # Prepara o resultado da soma para impressão
    li $v0, 4                 # Código para imprimir uma string
    la $a0, result            # Carrega o endereço da mensagem de resultado
    syscall                   # Executa a impressão da mensagem

    li $v0, 1                 # Código para imprimir um inteiro
    move $a0, $a1             # Prepara a soma calculada para impressão
    syscall                   # Executa a impressão da soma

    li $v0, 10                # Código para encerrar o programa
    syscall                   # Encerra o programa

add_const:
    lw $t0, const_val         # Carrega o valor constante de 'const_val' para $t0
    add $v0, $a0, $t0         # Soma o valor constante com o número lido
    jr $ra                    # Retorna para a função chamadora
