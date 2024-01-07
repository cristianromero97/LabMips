# Programa en ensamblador MIPS para determinar si la diferencia de dos enteros es par o impar

.data
prompt1: .asciiz "Por favor ingrese el primer entero: "
prompt2: .asciiz "Por favor ingrese el segundo entero: "
result_message: .asciiz "La diferencia es: "
odd_message: .asciiz " (Impar)\n"
even_message: .asciiz " (Par)\n"

.text
.globl main

main:
    # Imprimir el primer mensaje de solicitud
    li $v0, 4
    la $a0, prompt1
    syscall

    # Leer el primer entero
    li $v0, 5
    syscall
    move $t0, $v0

    # Imprimir el segundo mensaje de solicitud
    li $v0, 4
    la $a0, prompt2
    syscall

    # Leer el segundo entero
    li $v0, 5
    syscall
    move $t1, $v0

    # Calcular la diferencia
    sub $t2, $t0, $t1

    # Imprimir el mensaje de resultado
    li $v0, 4
    la $a0, result_message
    syscall

    # Imprimir la diferencia
    li $v0, 1
    move $a0, $t2
    syscall

    # Determinar si la diferencia es par o impar
    andi $t3, $t2, 1 # Si el bit menos significativo es 1, es impar

    # Imprimir "Par" o "Impar" según el resultado
    li $v0, 4
    beqz $t3, even_messaage # Saltar si la diferencia es par
    la $a0, odd_message
    j print_message

even_messaage:
    la $a0, even_message

print_message:
    syscall

    # Terminar el programa
    li $v0, 10
    syscall


