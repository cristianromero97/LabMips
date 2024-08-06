.data
mensaje_entrada: .asciiz "****** El factorial de 5! ****** "     #Si se cambia el valor numerico se debe cambiar aqui tambien
mensaje_resultado: .asciiz "El resultado del factorial es: "
numero:    .word 5    # Este numero es de ejemplo, se puede cambiar
resultado: .word 0    # Aqui coloco el resultado obtenido del factorial	
salto_linea: .asciiz "\n"

.text
    .globl main
#Debido a que usare varias etiquetas marcare algunas como globales, las mas relevantes!

main:
    #guardado de numero y saltos	
    lw $a0, numero             # guardo el valor de numero = 5 en $a0
    jal subrutina_factorial    # salto a la subrutina factorial
    sw $v0 , resultado	       # escribo el resultado obtenido de $v0 en resultado
    j salida		       # salto a la salida para imprimir resultados	
    
.globl subrutina_factorial

subrutina_factorial:

    # Creacion del stack
    subu $sp, $sp, 8   # reservo espacio en el stack
    sw $ra , ($sp)     # guardo el valor obtenido
    sw $s0, 4($sp)     # guardo el valor $s0 en el stack

    # Caso base 
    li $v0, 1                        # inicializo el caso base del factorial 1! = 1, inicializo con 1 el valor de $v0  
    beq $a0, 0 , salida_subrutina    # si el resultado de $a0 = 0, salto a salida

    move $s0 , $a0          # muevo el valor de $a0 a $s0  
    sub $a0, $a0 , 1        # $a0 = $a0 - 1 -> $a0 = 5 - 1 o se puede aplicar con otro ejemplo
    jal subrutina_factorial # vuelvo a la subrutina

    # Aplicacion de la subrutina de multiplicacion segun el ejercicio anterior
    move $a0, $s0              # primero muevo los valores para conservarlos.... -> muevo el valor de $s0 a $a0 ( $a0 = $s0)
    move $a1, $v0              # muevo el valor de $v0 a $a1 ($a1 = $v0)
    jal subrutina_multiplicar  # me dirijo a la subrutina de la multiplicacion

salida_subrutina:
    #restauro stack y devuelvo el valor obtenido, se hacen las misma cosas que en la creacion del stack
    lw $ra , ($sp)
    lw $s0 , 4 ($sp)
    addu $sp , $sp ,8
    jr $ra  # devuelvo el valor $ra de la multiplicacion y vuelvo al main

.globl subrutina_multiplicar

#Aplicacion de la subrutina de multiplicacion segun ejercicio anterior
subrutina_multiplicar:
    #Creacion del stack (las operaciones son las mismas que las que estan arriba)
    subu $sp, $sp, 8
    sw $ra , ($sp)
    sw $s0 , 4($sp)
    
    # muevo los valores obtenido nuevamente
    move $s0, $a0     # muevo el valor de $a0 a $s0  ($s0 = $t1)
    move $t1, $a1     # muevo el valor de $a1 a $t1  ($t1 = $a1)
    li $v0, 0         # inicializo $v0 en 0

    while:
        # Aqui aplico el mismo concepto que la multiplicacion
        beq $t1,$zero,fin_while    # $t1 = $zero salta al fin (tambien se puede ocupar beqz)
        add $v0, $v0, $s0          # $v0 = $v0 + $s0 
        addi $t1, $t1, -1          # $t1 = $t1 - 1
        j while                    # vuelvo al ciclo
	# Aqui hago lo mismo que la parte de escritura del ejercicio anterior pero ahora con un stack
    fin_while:
        # Cargo valores del stack 
        lw $ra, ($sp)
        lw $s0, 4($sp)
        addu $sp, $sp, 8  # libero el stack
        jr $ra            # termino la subrutina y salto a la direccion de retorno

salida:
    # Imprimo mensaje entrada	
    li $v0, 4
    la $a0, mensaje_entrada
    syscall
    
    # Imprimo salto de linea 
    li $v0, 4          
    la $a0, salto_linea    
    syscall
     
    # Imprimo mensaje resultado   
    li $v0 , 4
    la $a0 , mensaje_resultado
    syscall

    # Imprimo resultado  
    li $v0, 1
    lw $a0, resultado
    syscall

    # fin del programa    
    li $v0 , 10
    syscall
