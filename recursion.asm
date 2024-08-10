.data
prompt: .asciiz "Digite um numero: "
result: .asciiz "O fatorial eh: "

.text
.globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $a0, $v0

    jal factorial

    move $a1, $v0
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $a1
    syscall

    li $v0, 10
    syscall

factorial:
    addi $sp, $sp, -8 
    sw $ra, 4($sp)     
    sw $a0, 0($sp)     

    li $t0, 1
    ble $a0, $t0, base_case

    addi $a0, $a0, -1
    jal factorial
    lw $a0, 0($sp)     
    mul $v0, $a0, $v0  

    j end_factorial

base_case:
    li $v0, 1

end_factorial:
    lw $ra, 4($sp)     
    addi $sp, $sp, 8   
    jr $ra             

