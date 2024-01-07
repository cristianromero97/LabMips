.data
msg: .asciiz "Ingresa un numero: "
answer: .asciiz "\nFactorial is: "

.text

main:
    # Mostrar el mensaje "Ingresa un numero"
    li $v0, 4
    la $a0, msg
    syscall

    # Leer un entero
    li $v0, 5
    syscall
    move $a0, $v0

    # Llamar a la función calculate_factorial
    jal calculate_factorial
    move $a1, $v0

    # Mostrar el resultado
    li $v0, 4
    la $a0, answer
    syscall

    move $a0, $a1
    li $v0, 1
    syscall

    # Salir del programa
    li $v0, 10
    syscall

calculate_factorial:
    addi $sp, $sp, -4
    sw $ra, ($sp)

    # Inicializar el resultado del factorial
    li $t0, 1
    li $v0, 1  # Código de syscall para imprimir un entero

multiply:
    beq $a0, $zero, return

    # Llamar a la función mul_sum para multiplicar $t0 por $a0
    move $s0, $t0
    move $s1, $a0
    jal mul_sum

    # Obtener el resultado de la multiplicación en $t0
    move $t0, $v0

    # Decrementar $a0
    addi $a0, $a0, -1
    j multiply

return:
    lw $ra, ($sp)
    move $v0, $t0  # Devolver el resultado en $v0
    jr $ra

mul_sum:
    # Inicializamos el resultado a 0
    li $s2, 0

mul_loop:
    # Sumamos el multiplicando al resultado
    add $s2, $s2, $s0

    # Decrementamos el multiplicador en 1
    subi $s1, $s1, 1

    # Comprobamos si el multiplicador es 0
    beq $s1, $zero, end_mul

    # Si no es 0, repetimos el bucle
    j mul_loop

end_mul:
    # Devolver el resultado de la multiplicación en $v0
    move $v0, $s2
    jr $ra
