# Para realizar la division me vali de los mismos conceptos que el factorial (aplicacion del stack) y hacer uso de la subrutina de multiplicacion
# Tambien readapte la subrutina de multiplicacion para hacerla en la subrutina division
.data
dividendo:          .word 7       # dividendo en este caso es 7
divisor:            .word 6       # divisor en este caso es 6
salto_linea:        .asciiz "\n"  
punto:              .asciiz "." 
mensaje_cociente:   .asciiz "El resultado de la division es: "
mensaje_resto:      .asciiz "El resto de la division es: " 
mensaje_entrada:    .asciiz "******* Division de (7 // 6) ********"   #Si se cambia el valor numerico del dividendo y divisor se debe cambiar aqui tambien

.text
     .globl main  
#Debido a que usare varias etiquetas marcare algunas como globales, en este caso solo el main!

main:
    # guardado de numeros y saltos
    lw $t0, dividendo    # guardo el dividendo en $t0
    lw $t1, divisor      # guardo el divisor en $t1
    jal division	 # salto a la subrutina division
    j salida		 # salto a la salida para imprimir resultados
   
division:
    
    # Creacion del stack
    addi $sp, $sp, -16    # reservo espacio en el stack
    sw $ra, 0($sp)        # guardo registro
    sw $s0, 4($sp)        # guardo $s0
    sw $s1, 8($sp)        # guardo $s1
    sw $s2, 12($sp)       # guardo $s2

    move $t2, $zero       # creo una variable temporal para cociente en cero -> $t2 = 0 
    move $t3, $zero       # creo una variable temporal para resto en cero -> $t3 = 0 

    lw $t4, dividendo     # cargo el dividendo en $t4
    lw $t5, divisor       # cargo el divisor en $t5

    # División entera
    while:
        sub $t4, $t4, $t5        # resto el divisor del dividendo y lo guardo en $t4 -> $t4 = $t4 - $t5
        bgez $t4, iteracion      # $t4 = $zero salta a repetecion
        j final                  # si el resultado es negativo salta a fin
    iteracion:
        addi $t2, $t2, 1     # incremento el cociente 
        j while              # Repite el ciclo
    final:
        add $t4, $t4, $t5   # suma el valor de $t4 y $t5 y lo guardo en $t4 -> $t4 = $t4 + $t5
        move $t3, $t4       # muevo el valor de $t4 a $t3 -> $t3 = $t4

    # Decimales
    li $t6, 100                     # Inicializo $t6 en 100 --> $t6 = 100 para dos decimales
    move $a0, $t3                   # muevo $t3 a $a0 -> $a0 = $t3
    move $a1, $t6                   # muevo $t6 a $a1 -> $a1 = $t6
    jal subrutina_multiplicacion    # salto a la subrutina multiplicacion del ejercicio anterior para calcular $t4 = $t3 * $t6

    move $a0, $t4           # muevo el valor de $t4 a $a0 -> $a0 = $t4
    move $a1, $t5           # muevo el valor de $t5 a $a1 -> $a1 = $t5
    jal subrutina_division  # salto a la subrutina division decimal para calcular $t4 = $t4 / $t5
    move $t4, $v0           # muevo el resultado de los decimales a $t4 -> $t4 = $v0

    # Restauro los registros y el stack
    lw $ra, 0($sp)          
    lw $s0, 4($sp)         
    lw $s1, 8($sp)          
    lw $s2, 12($sp)         
    addi $sp, $sp, 16       # libero el espacio en la pila
    jr $ra                  # salto al retorno 

subrutina_multiplicacion:
    addi $sp, $sp, -8       # reservo espacio en el stack
    sw $ra, 0($sp)          # guardo el registro de retorno
    sw $s0, 4($sp)          # guardo $s0

    move $t7, $a0           # muevo $a0 a $t7 -> $t7 = $a0 para el primer numero a multiplicar
    move $t8, $zero         # creo el producto, esto se puede hacer con un add. lo inicializo con cero

# Aplico la misma subrutina de multiplicacion del ejercicio anterior
multiplicacion_ciclo:
    beq $a1, $zero, salida_multiplicacion  # si $a1 = $zero salta a salida de la multiplicacion
    add $t8, $t8, $t7                      # $t8 = $t8 + $t7
    addi $a1, $a1, -1                      # $a1 = $a1 + (-1)
    j multiplicacion_ciclo                 # vuelvo al ciclo

salida_multiplicacion:
    move $t4, $t8           # muevo el resultado a $t4 -> $t4 = $t8
    # restauro los registros y el stack
    lw $ra, 0($sp)          
    lw $s0, 4($sp)          
    addi $sp, $sp, 8        
    jr $ra                  # salto al retorno

subrutina_division:
    # Creacion del stack y guardado de registros
    addi $sp, $sp, -16      # reservo espacio en el stack
    sw $ra, 0($sp)          # guardo el registro de retorno
    sw $s0, 4($sp)          # guardo $s0
    sw $s1, 8($sp)          # guardo $s1
    sw $s2, 12($sp)         # guardo $s2

    move $s0, $a0           # muevo el valor de $a0 a $s0 -> $s0 = $a0 (dividendo) //esto es solo para copiarlo
    move $s1, $a1           # muevo el valor de $a1 a $s1 -> $s1 = $a1

    # Inicializo el cociente y el resto
    move $s2, $zero         # $t2 = 0 (cociente)
    move $t3, $zero         # $t3 = 0 (resto)

    # Una vez que tengo todos los operandos realizo la subrutina_division
    # La subrutina division tiene el mismo concepto que la de multiplicacion del ejercicio anterior
    division_ciclo:
        sub $s0, $s0, $s1              # $s0 = $s0 - $s1
        bgez $s0, division_iteracion   # $s0 >= 0 salta a division_repeticion 
        j division_salida              # si el resultado es negativo, salta a division_salida
    division_iteracion:
        addi $s2, $s2, 1       # incremento el cociente -> $s2 = $s2 + 1
        j division_ciclo       # vuelvo al ciclo
    division_salida:
        add $s0, $s0, $s1     # corrijo el resto final  -> $s0 = $s0 + $s1

    move $v0, $s2             # muevo el cociente que esta en $s2 a $v0 -> $v0 = $s2

    # Restauro los registros y el stack
    lw $ra, 0($sp)          
    lw $s0, 4($sp)          
    lw $s1, 8($sp)          
    lw $s2, 12($sp)         
    addi $sp, $sp, 16       # libero el espacio en el stack
    jr $ra                  # salto al retorno

salida:
    # Imprimo el mensaje de entrada
    li $v0, 4
    la $a0, mensaje_entrada
    syscall

    # Imprime un salto de línea
    li $v0, 4
    la $a0, salto_linea
    syscall
     
    # Imprimo el mensaje cociente
    li $v0, 4
    la $a0, mensaje_cociente
    syscall 
     
    # Imprimo el cociente
    li $v0, 1
    move $a0, $t2
    syscall

    # Imprimo el mensaje punto, para decimales
    li $v0, 4
    la $a0, punto
    syscall

    # Imprimo los decimales
    li $v0, 1
    move $a0, $t4
    syscall

    # Imprimo salto de linea
    li $v0, 4
    la $a0, salto_linea
    syscall
    
    # Imprimo el mensaje resto
    li $v0, 4
    la $a0, mensaje_resto
    syscall 
     
    # Imprimo el resto
    li $v0, 1
    move $a0, $t3
    syscall

    # fin del programa
    li $v0, 10
    syscall
   
	
