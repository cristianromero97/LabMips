.data
mensaje_entrada:    .asciiz "Ingrese el número para calcular Fibonacci: "
buffer:             .space 400  # Espacio del buffer 
mensaje_resultado:  .asciiz "El resultado del fibonacci es: "
salto_linea:        .asciiz "\n"  

.text
main:
    # Immprimo mensaje de entrada
    li $v0, 4                    # Carga el codigo de la llamada al sistema para imprimir cadena
    la $a0, mensaje_entrada      # Carga la direccion de la cadena a imprimir en $a0
    syscall              

    # Lectura del numero ingresado por el usuario anteriormente
    li $v0, 5            # Carga el codigo de la llamada al sistema para leer entero
    syscall              # Realiza la llamada al sistema para hacer la lectura                
    move $a0, $v0        # Mueve el valor de $v0 a $a0

    # Llamada de la función fibonacci
    jal fibonacci        
    move $t1, $v0  # Guarda el resultado de Fibonacci en $t1    
    j salida  # salto a la salida para imprimir resultados
              
fibonacci:
    # Verificar si el índice es válido
    li $t0, 100            # Tamaño del buffer 
    bge $a0, $t0, overflow # Verifica si el índice es mayor o igual a 10 (fuera del rango)
    
    # Carga la dirección base del buffer
    la $t1, buffer
    move $t2, $a0        # Guardar índice en $t2
    li $t3, 4            # Tamaño de un entero en bytes (4 bytes)
    mul $t2, $t2, $t3    # Calcula el desplazamiento en bytes
    add $t2, $t1, $t2    # Calcula la dirección de buffer[$a0]
    
    lw $v0, 0($t2)       # Carga el valor de buffer[$a0]
    # Si buffer[$a0] no es cero, retorna el valor memoizado
    bnez $v0, done

    # Casos base: fibonacci(0) = 0, fibonacci(1) = 1
    li $t0, 1
    bgt $a0, $t0, recurse
    bne $a0, $zero, one
    li $v0, 0
    sw $v0, 0($t2)       # Memoiza el valor fibonacci(0) = 0
    jr $ra

one:
    li $v0, 1
    sw $v0, 0($t2)       # Memoiza el valor fibonacci(1) = 1
    jr $ra

recurse:
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a0, 4($sp)

    addi $a0, $a0, -1
    jal fibonacci
    sw $v0, 0($sp)

    lw $a0, 4($sp)
    addi $a0, $a0, -2
    jal fibonacci

    lw $t0, 0($sp)
    add $v0, $t0, $v0

    # Memoiza el valor calculado de fibonacci(n)
    lw $a0, 4($sp)
    move $t2, $a0        # Guardar índice en $t2
    li $t3, 4            # Tamaño de un entero en bytes (4 bytes)
    mul $t2, $t2, $t3    # Calcula el desplazamiento en bytes
    
    add $t2, $t1, $t2    # Calcula la dirección de buffer[$a0]
    
    sw $v0, 0($t2)       # Memoiza el resultado en buffer[$a0]

    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra

done:
    jr $ra

overflow:
    li $v0, 10           # Código de error para salida
    syscall              # Salir del programa si ocurre un error
    jr $ra
    
salida:

    # Imprime un salto de línea
    li $v0, 4
    la $a0, salto_linea
    syscall
    
    # Imprimo mensaje de salida
    li $v0, 4
    la $a0, mensaje_resultado      
    syscall
    	
    # Imprimo resultado de Fibonacci
    move $a0, $t1
    li $v0, 1
    syscall			

    # fin del programa
    li $v0, 10           
    syscall	    
    
    
    