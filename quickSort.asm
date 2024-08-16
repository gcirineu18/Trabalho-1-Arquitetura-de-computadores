#
# O programa que segue abaixo é a implementação do Quick Sort, usando o último 
# elemento do vetor como pivô, e se limitando a 10 elementos.
# Com exceção do input de usuário (item 1.1), todos os outros itens são contemplados 
# neste.
#
#
.data
# Definição de Strings que serão utilizadas como output
$NO: .asciiz "O array não ordenado é: "
$V:  .asciiz ", "
$O: .asciiz "O array ordenado é: "
$NL: .asciiz "\n"

# Definição do Array
array: .word 10, 7, 8, 76, 1 , 5, 4, 17, 23, 32, 0
#array: .word 100, 7789, 878, 76675, 16 , 57, 176, 2673, 3209, 44


.text                         # Indicando ínicio de instruções
 .globl main 
main:                         
 # Exibindo o array inicial não ordenado
  la $a3, array              # Argumento 1 - Array
  move $a1, $zero            # Argumento 2 - Inteiro para indicar qual String deve ser impressa no caso, $NO
  jal printArray             # Chamando a função printArray(array, op) 
  
  #Fazendo a quebra de linha
  li $v0, 4
  la $a0, $NL
  syscall
  
  move $a0, $zero        # Argumento 0, índice 0 (low)    
  li $a1, 9              # Argumento 1, índice 9 (high) 
  la $a2, array          # Argumento 2 - vetor
  jal quickSort          # Chamando a função quickSort
  
  # Exibindo o array ordenado
  la $a0, array
  li $a1, 1
  jal printArray
   
  j FIM                  # Comando para pular para o Fim do programa 
  
.text
printArray:  
  la $s1, array                       # carregando o endereço de memória do array em $s1   
  bne $a1, $zero, PrintOrdenado       # se o argumento $a1 = 1, pula para PrintOrdenado  
                                      # caso contrário, permanece sequencialmente
  # Exibindo a String atribuída à $NO
  li $v0, 4                           
  la $a0, $NO
  syscall       
  
  j PrintArrayLoop                   # Salta para PrintArrayLoop                
  
  # Exibindo a String atribuída à $O  
  PrintOrdenado:
    li $v0, 4
    la $a0, $O
    syscall
    
PrintArrayLoop:  
   move $s0, $zero          # Atribuindo 0 à variável i  
   li $t5, 10               # número de elementos no array

LOOP1: 
  slti $t0, $s0, 10         # Verifica se i < 10 (número de elementos)
  beq $t0, $zero, EXIT1      # Se não, saia do loop       
  sll $t1, $s0, 2           # Shift de dois bits para esquerda para ocupar 
                            # o tamanho correto da posição no array (múltiplo de 4)
  add $t2, $a3, $t1         # Somando com o endereço do array
  lw $t3, 0($t2)            # Carrega o valor do array[i]
  
  li $v0,1                  # Imprime inteiro
  move $a0, $t3             # Move o valor para o registrador $a2
  syscall
    
  add $s0, $s0, 1           # i++ 
  
  bne $s0, $t5, PrintComma  # Se i != número de elementos, imprime vírgula
  j EXIT1                   # Desvia para o label EXIT1
  
  PrintComma:               #Imprime a vírgula
  li $v0, 4
  la $a0, $V
  syscall
  
  j LOOP1                     # Volta ao início do Loop
    
EXIT1:
  jr $ra                     # Desvio para o endereço de retorno (próximo passo após  
                             # a chamada da função)
.text
 quickSort: 
   subi $sp, $sp, 16      # Criando uma pilha para armazenar 4 valores
   sw $a0, 0($sp)         # Armazenando a variável low
   sw $a1, 4($sp)         # Armazenando a variável high  
   sw $a2, 8($sp)         # Armazenando o array
   sw $ra, 12($sp)        # Armazenando a variável de retorno

  move $t0, $a1           # Copiando o valor de $a1 em $t0
  slt $t1, $a0, $t0       # $a0 < $t0 ? $t1 = 1 : $t1 = 0 
  beq $t1, $zero, EXIT2   # if $t1 == 0, goto EXIT2

  jal partition           # Chamando a função partition 
  
  move $t3, $v0           # Recebendo o retorno da função partition no registrador $t3
 
  lw $a0, 0($sp)          # $a0 = low
  
  subi $a1, $t3, 1        # $a1 = pi - 1
  jal quickSort           # chamando quickSort(low, pi - 1, array)  
  
  addi $a0, $t3, 1        # $a0 = pi + 1
  lw $a1, 4($sp)          # $a1 = high        
  jal quickSort           # chamando quickSort(pi + 1, high, array)
  
EXIT2: 
  # Liberando a pilha
  lw $a0, 0($sp)
  lw $a1, 4($sp)
  lw $a2, 8($sp)
  lw $ra, 12($sp)
  addi $sp, $sp, 16
  jr $ra               # Retorno ao endereço seguinte à onde foi chamada a função inicialmente

.text 
partition: 
      subi $sp, $sp, 16      # Criando uma pilha para armazenar 4 valores
      sw $a0, 0($sp)         # Armazenando a variável low
      sw $a1, 4($sp)         # Armazenando a variável high  
      sw $a2, 8($sp)         # Armazenando o array
      sw $ra, 12($sp)        # Armazenando a variável de retorno
      
      move $s0, $a0          # Copiando o menor índice para o registrador $s0 (low)
      move $s1, $a1          # Copiando o maior índice para o registrador $s1 (high)
      move $s2, $a2          # Copiando o endereço do array para o 
                             #  registrador $s2
      
      # Atribuindo i = low - 1
      subi $t0, $s0, 1
         
      # Carregando o valor de array[high]
      sll $t1, $s1, 2             
      add $t1, $s2, $t1
      lw $t1, 0($t1)         #  pivot = array[high]
           
      # Início do Loop (começando com j = low, logo j = $s0 e high = $s1)  
      LOOP2: 
        slt $t3, $s0, $s1    # se j < high  ... o registrador recebe o resultado booleano
        beq $t3, $zero, EndLoop      # if $t3 == 0, goto EndLoop
        
      # Carregando o valor de array[j]
        sll $t4, $s0, 2             
        add $t4, $s2, $t4
        lw $t4, 0($t4)
        
        slt $t5, $t4, $t1          # Checando se array[j] < pivot
        beq $t5, $zero, IFOUT      # Se não for, salta para IFOUT
        
        addi $t0, $t0, 1           # i = i + 1       
             
        # Definindo os parâmetros, e depois, fazer a chamada da função
        # swap(i, j, array)
        move $a0, $t0              
        move $a1, $s0
        move $a2, $s2
        jal swap      
               
        IFOUT:
          addi $s0, $s0, 1        # j = j + 1
          j LOOP2                 # Pulando para o próximo passo da iteração
          
        EndLoop:          
          addi $t0, $t0, 1           # i = i + 1
               
         # Chamando swap(i+1, high, array)
          move $a0, $t0              
          move $a1, $s1
          move $a2, $s2
          jal swap  
              
          addi $v0, $t0, 0       # atribuindo i  ao registrador de retorno
          lw $ra, 12($sp)        # Carregando a variável de retorno 
          addi $sp, $sp, 16      # Liberando a pilha 
          jr $ra                 # Voltando ao ponto onde foi chamada a função                                  
.text
swap:
   addi $sp, $sp, -12          # Criando uma pilha para 3 valores
   sw $a0, 0($sp)              # Armazenando a0
   sw $a1, 4($sp)              # Armazenando a1
   sw $a2, 8($sp)              # Armazenando a2
    
   # Carregando o valor associado ao endereço de memória atual do 1º argumento
   sll $t8, $a0, 2             
   add $t8, $a2, $t8
   lw $s3, 0($t8)
   # Carregando o valor associado ao endereço de memória atual do 2º argumento
   sll $t9, $a1, 2             
   add $t9, $a2, $t9
   lw $s4, 0($t9)
   
   # Armazenando o valor do 1º argumento no endereço de memória do 2º argumento,
   # e vice-versa
   sw $s4, 0($t8)          
   sw $s3, 0($t9)
   
   addi $sp, $sp, 12           # Liberando a pilha            
   jr $ra                      # Desviando para o endereço de retorno   

FIM:
   li $v0, 10                 # Chamada de sistema para o fim do programa 
   syscall    
  
  
  
 
