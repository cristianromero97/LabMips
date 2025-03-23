.data
mensaje_entrada:            .asciiz "Ingrese el número para calcular Fibonacci: "
mensaje_resultado:	    .asciiz "El resultado del fibonacci es: "
salto_linea:                .asciiz "\n"  

.text
main:
    # Imprimo mensaje de entrada
    li $v0, 4                    # Carga el codigo de la llamada al sistema para imprimir cadena
    la $a0, mensaje_entrada      # Carga la direccion de la cadena a imprimir en $a0
    syscall		         # Realiza la llamada al sistema para imprimir la cadena

    # Lectura del numero ingresado por el usuario anteriormente
    li $v0, 5            # Carga el codigo de la llamada al sistema para leer entero
    syscall		 # Realiza la llamda al sistema para hacer la lectura				
    move $a0, $v0        # Mueve el valor de $v0 a $a0
        		
    # Llamada de la función fibonacci
    jal fibonacci 		
    move $t1, $v0  # Guarda el resultado de Fibonacci en $t1
    
    j salida  # salto a la salida para imprimir resultados
    
fibonacci: 
    # Implementación de la etiqueta Fibonacci a travez de subrutina
    li $t0, 1 			# Carga el valor de 1 en $t0
    bgt $a0, $t0, recurse   	# Compara el valor de $a0 (que es el numero ingresado) con $t"
    bne $a0, $zero, one		# Compara el valor de $a0 con $zero(0), salta a la etiqueta "one" (o 1 haciendo referencia a un caso base).
    li $v0, 0			# Se establece el valor de $v0 en 0, es decir, $v0 = 0
    jr $ra			# Salta a la direccion de retorno

#Caso base de 1
one:	
    li $v0, 1		# Establece el $v0 = 1, para un caso base de la funcion fibonaccci
    jr $ra		# Salta a la direccion de retorno

recurse: 
    addi $sp, $sp, -12	# Ajustamos el puntero del stack para hacer espacio para 3 palabaras o 12 bytes, como? con una addi, es decir, $sp = $sp - 12
    sw $ra, 8($sp)	# Escribimos el registro de la direccion en $ra  en la posicion 8($sp), es decir, primero se suma 8 con la direccion de $sp y se escribe en $ra	
    sw $a0, 4($sp)	# Escribimos el registro de la direccion en $a0 en la posicion 4($sp) , es decir, primero se suma 4 con la direccion de $sp y luego se escribe en $a0
    addi $a0, $a0, -1	# Decrementamos el valor que posea $a0 en -1 , es decir, $a0 = $a0 -1, segun la formula seria (n-1)
    jal fibonacci	# Salta a la etiqueta fibonacci para luego tomar el siguiente 
    sw $v0, 0($sp)	# Escribimos el resultado de la llamada en $v0 de la posicion 0($sp), es decir, primero sumamos 0 con la direccion $sp y luego escribimos en $v0
    lw $a0, 4($sp)	# Cargamos el valor original desde el stack, vale decir, primero sumamos 4 con $sp y luego lo llevamos a $a0 y lo leemos, hacemos lectura o carga de valores
    addi $a0, $a0, -2   # Decrementamos el valor del argumento $a0 en -2, es decir, $a0 = $a0 - 2 o por formula (n-2)
    jal fibonacci	# Salta a la etiqueta fibonacci
    lw $t0, 0($sp)	# Cargamos el resultado de la primera llamada que hicimos (n-1)
    add $v0, $t0, $v0	# Sumamos los resultados de las dos llamadas (n-1) + (n-2), vale decir, $v0 = $t0 + $v0
    lw $ra, 8($sp)	# Cargamos el registro de retorno $ra, vale decir lo recuperamos desde el stack que creamos originalmente en el principio	
    addi $sp, $sp, 12	# Ajustamos el puntero que hicimos al principio para devolverlo al estado original
    jr $ra		# Retornamos la direccion guardada en $ra
   
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
	
	