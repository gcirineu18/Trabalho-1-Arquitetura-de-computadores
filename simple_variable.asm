.data
prompt: .asciiz "Digite um numero: "
result: .asciiz "A soma com 5 eh: "
const_val: .word 5 

.text
.globl main

main:
    li $v0, 4
    la $a0, prompt
    syscall

    li $v0, 5
    syscall
    move $a0, $v0 

    jal add_const

    move $a1, $v0
    li $v0, 4
    la $a0, result
    syscall

    li $v0, 1
    move $a0, $a1
    syscall

    li $v0, 10
    syscall

add_const:
    lw $t0, const_val 
    add $v0, $a0, $t0  
    jr $ra            
