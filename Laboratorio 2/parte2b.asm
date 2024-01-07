.data
dividendo:  .word 7       # El dividendo (por ejemplo, 20)
divisor:    .word 6        # El divisor (por ejemplo, 5)
cociente:   .word 0      # Variable para almacenar el cociente
resto:      .word 0        # Variable para almacenar el resto
newline:    .asciiz "\n"   # Secuencia nula para un salto de línea

.text
.globl main

main:
    lw $t0, dividendo    # Carga el dividendo en $t0
    lw $t1, divisor      # Carga el divisor en $t1

    # Llama a la subrutina para realizar la división
    jal divide

    # El resultado de la división (cociente) se encuentra ahora en $t2
    # El resultado del resto de la división se encuentra en $t3

    # Muestra el resultado por pantalla
    li $v0, 1            # Código de servicio para imprimir un entero
    move $a0, $t2        # Cargamos el cociente en $a0
    syscall

    # Imprime un salto de línea
    li $v0, 4            # Código de servicio para imprimir una cadena
    la $a0, newline       # Cargamos la dirección de la cadena "\n"
    syscall

    # Muestra el resto de la división por pantalla
    li $v0, 1            # Código de servicio para imprimir un entero
    move $a0, $t3        # Cargamos el resto en $a0
    syscall

    # Termina el programa
    li $v0, 10
    syscall

# Subrutina para realizar la división y calcular el cociente y el resto
divide:
    move $t2, $zero      # Inicializa el cociente en 0
    move $t3, $zero      # Inicializa el resto en 0

    lw $t4, dividendo    # Carga el dividendo desde la ubicación de memoria
    lw $t5, divisor      # Carga el divisor desde la ubicación de memoria

    loop:
        sub $t4, $t4, $t5   # Resta el divisor del dividendo
        bgez $t4, success    # Si $t4 es >= 0, continua a la etiqueta "success"
        j end                # Si $t4 es < 0, salta a la etiqueta "end"
    success:
        addi $t2, $t2, 1    # Incrementa el cociente en 1
        j loop               # Vuelve al inicio del bucle
    end:
        add $t4, $t4, $t5   # Suma el divisor de vuelta para encontrar el resto
        move $t3, $t4        # Actualiza el valor del resto
        jr $ra               # Regresa a la dirección de retorno
