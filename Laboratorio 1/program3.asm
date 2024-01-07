.data
arr: .word 11 22 33 44 66
arrlen: .word 0
evensum: .word 0
newline: .asciiz "\n"

.text
main:
    # Inicializar los registros
    la $s0, arr        # Cargar la dirección base de arr en $s0
    la $s1, arrlen     # Cargar la dirección de arrlen en $s1
    la $s2, evensum    # Cargar la dirección de evensum en $s2
    la $s3, newline    # Cargar la dirección de newline en $s3
    lw $t0, 0($s1)     # Cargar el valor de arrlen en $t0
    subu $s1, $s1, $s0  # Calcular la longitud del arreglo
    srl $s1, $s1, 2

    # Inicializar el contador y el valor de evensum
    li $t1, 0          # $t1 se usa como contador
    li $t2, 0          # $t2 se usa como evensum

loop:
    # Comprobar si hemos recorrido todo el arreglo
    beq $t1, $s1, print_result

    # Cargar el valor actual del arreglo en $t3
    lw $t3, 0($s0)

    # Comprobar si el valor es par (es decir, su bit menos significativo es 0)
    andi $t4, $t3, 1
    beqz $t4, even

    # Valor impar, omitir y continuar
    j next_iteration

even:
    # Sumar el valor par a evensum
    add $t2, $t2, $t3

next_iteration:
    # Avanzar al siguiente elemento del arreglo
    addi $s0, $s0, 4
    addi $t1, $t1, 1
    j loop

print_result:
    # Mostrar el valor de evensum por pantalla
    move $a0, $t2       # Cargar el valor de evensum en $a0
    li $v0, 1           # Código de llamada al sistema para imprimir un entero
    syscall

    # Imprimir una nueva línea
    li $v0, 4           # Código de llamada al sistema para imprimir una cadena
    la $a0, newline     # Cargar la dirección de newline en $a0
    syscall

    # Terminar el programa
    li $v0, 10
    syscall


