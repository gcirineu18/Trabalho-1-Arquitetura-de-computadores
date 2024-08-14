###########################################################################################
# O programa abaixo funciona como um classificador de índice de rendimento acadêmico
# Além disso, esta aplicação trabalha com duas funcionalidades principais: 
# 1.1.Números inteiros recebidos por input do usuário
# 1.4.Estrutura condicional composta (if, else if e else)
# Entrada: três números inteiros
# Saída: Média aritmética dos valores e situação do usuário (Reprovado, AF, Aprovado)
###########################################################################################

.data
nota1: .asciiz "Entre a primeira nota: " # Mensagem para o usuário inserir a primeira nota
nota2: .asciiz "Entre a segunda nota:  " # Mensagem para o usuário inserir a segunda nota
nota3: .asciiz "Entre a última nota: " # Mensagem para o usuário inserir a terceira nota
media: .asciiz "Média: " # Mensagem que exibe a média das notas
status_reprovado: .asciiz "Você foi reprovado." # Mensagem que vai indicar a situação "reprovado"
status_af: .asciiz "Você está de AF." # Mensagem que vai indicar a situação "AF"
status_aprovado: .asciiz "Você está aprovado!" # Mensagem que vai indicar a situação "aprovado"

.text

main: # Escopo da função principal

    # Ações nota1
    li $v0, 4           # Chamada de sistema para imprimir uma string
    la $a0, nota1       # Carregar o endereço da string nota1 no registrador $a0
    syscall             # Executa a chamada de sistema para a string

    # Leitura da nota1
    li $v0, 5           # Chamada de sistema para ler um inteiro
    syscall             # Ler o inteiro
    move $t0, $v0       # Pegar o valor lido (armazenado em $v0) e mover para o registrador $t0

    # Ações nota2
    li $v0, 4
    la $a0, nota2
    syscall

    # Leitura nota2
    syscall
    move $t1, $v0       # Mover o valor lido para o registrador $t1

    # Ações nota3
    li $v0, 4
    la $a0, nota3
    syscall

    # Leitura nota3
    li $v0, 5
    syscall
    move $t2, $v0       # Mover o valor lido para o registrador $t2

    # Parte do código em que é realizado a soma das três notas para calcular a média
    add $t3, $t0, $t1   # Adiciona os valores de $t0 e $t1 em $t3
    add $t3, $t3, $t2   # Adicionar o valor de $t2 à soma anterior e armazena o $t3

    # Divisão pelo número de notas (Média)
    li $t4, 3           # Carregar o divisor 3 no registrador $t4
    div $t3, $t4        # Dividir $t3 por $t4 (soma/total_de_notas)
    mflo $t5            # Armazena a média em $t5

    li $v0, 4           # Chamada de sistema para imprimir uma string
    la $a0, media # Carregar o endereço da string result_msg no registrador $a0
    syscall             # Imprime a string

    li $v0, 1           # Chamada de sistema para imprimir um inteiro
    move $a0, $t5       # Passar o valor em $t5 (média) para o registrador $a0
    syscall             # Imprime o inteiro

    # Inicio das funções de condicionais para imprimir a situção do usuário
    li $t6, 5            # Carregar o valor 5 (média = 5) no registrador $t6
    blt $t5, $t6, reprovado  # Se a média for menor que 5, saltar para o rótulo "failed"

    li $t6, 7            # Carregar o valor 7 (média = 7) registrador $t6
    bge $t5, $t6, aprovado  # Se a média for >= 7, saltar para o rótulo "passed"

    # Se a média está entre 5 e 7
    li $v0, 4           # Chamada de sistema para imprimir uma string
    la $a0, status_af   # Carregar o endereço da string status_af no registrador $a0
    syscall             # Imprime a string
    j end               # Saltar para o rótulo "end"

reprovado:
    # Média < 5
    li $v0, 4           # Chamada de sistema para imprimir uma string
    la $a0, status_reprovado # Carregar o endereço da string status_reprovado no registrador $a0
    syscall             # Imprime a string
    j end               # Saltar para o rótulo "end"

aprovado:
    # Média >= 7
    li $v0, 4           # Chamada de sistema para imprimir uma string
    la $a0, status_aprovado # Carregar o endereço da string status_aprovado no registrador $a0
    syscall             # Imprime a string

end:
    li $v0, 10          # Chamada de sistema para sair
    syscall            
