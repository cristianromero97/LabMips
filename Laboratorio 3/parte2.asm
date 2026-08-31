.data
entrada: .asciiz "Ingrese el número para calcular Fibonacci: "
memolist: .space 800 # Espacio para almacenar resultados: 200 palabras * 4 bytes = 800 bytes (asumiendo que n no será mayor a 200)
 
# La idea es tomar el codigo anterior y hacerlo con memorizacion por ende hay una gran similitud entre este codigo y el otro
 
.text
main:
 # Solicitud al usuario de que ingrese un numero
    li $v0, 4            # Carga el codigo de la llamada al sistema para imprimir cadena
    la $a0, entrada       # Carga la direccion de la cadena a imprimir en $a0
    syscall		 # Realiza la llamada al sistema para imprimir la cadena
 
    # Lectura del numero ingresado por el usuario anteriormente
    li $v0, 5            # Código de la llamada al sistema para leer entero
    syscall		 # Realiza la llamda al sistema para hacer la lectura
    move $a0, $v0        # Guarda el número ingresado en $a0
 
    # Inicializa el arreglo de memorización con ceros
    la $a1, memolist	# Carga le valor de memolist dentro de un registro
    li $a2, 200		# Numero de PALABRAS a inicializar (200 palabras = 800 bytes = tamaño de memolist)
    li $t1, 0		# Inicializa el valor inicial del registro en cero (como lo dice el enunciado)
 
init_memolist: 
    sw $zero, 0($a1)	# Escribe Cero (registro $zero, siempre vale 0 por hardware) en la posicion actual de memolist.
    addi $a1, $a1, 4	# Realiza el movimiento de $a1 para la posicion, es decir, $a1 = $a1 + 4
    addi $t1, $t1, 1	# Realiza el movimiento en 1 para la pos de $t1 , es decir, $t1 = $t1 + 1
    bne $t1, $a2, init_memolist	# Compara el valor entre $a2 y $t1 si es distinto salta a init_memolist, sino continua el codigo (bne = branch not equal o !=)
 
    # Llama a la función fibonacci con memorización
    jal fibonacci_memo	# Salto a la etiqueta fibonacci_memo
 
    # Mostrar el resultado por pantalla
    move $a0, $v0        # Mueve el resultado de fibonacci que reside en $v0 a $a0
    li $v0, 1            # Carga el codigo de la llamada al sistema para imprimir el valor por pantalla
    syscall		 # Realiza la llamada al sistema para imprimir el resultado por pantalla
 
     # Finalizacion el programa
    li $v0, 10           # Carga el codigo de la llamada al sistema para salir del programa
    syscall		 # Realiza la llamada al sistema para salir del programa
 
fibonacci_memo:	
    li $t0, 2	# Carga el valor de 2 en $t0
    ble $a0, $t0, base_cases_memo	# Salta a la etiqueta base_cases_memo si $a0 <=2
 
    # Calcular la direccion de memolist[n] = base + n*4 
    la $t3, memolist       # Carga la dirección base de memolist en $t3
    sll $t4, $a0, 2         # $t4 = n * 4 (offset en bytes, ya que cada entero ocupa 4 bytes)
    add $t3, $t3, $t4       # $t3 = &memolist[n]
 
    lw $t2, 0($t3)        # Carga el valor almacenado en memolist[n] en $t2
    bnez $t2, memo_hit    # Si memolist[n] no es cero, saltar a la etiqueta memo_hit
 
    addi $sp, $sp, -12	# Ajustamos el puntero del stack para hacer espacio para 3 palabaras o 12 bytes, como? con una addi, es decir, $sp = $sp - 12
    sw $ra, 8($sp)	# Escribimos el registro de la direccion en $ra  en la posicion 8($sp), es decir, primero se suma 8 con la direccion de $sp y se escribe en $ra	
    sw $a0, 4($sp)	# Escribimos el registro de la direccion en $a0 en la posicion 4($sp) , es decir, primero se suma 4 con la direccion de $sp y luego se escribe en $a0
    addi $a0, $a0, -1	# Decrementamos el valor que posea $a0 en -1 , es decir, $a0 = $a0 -1, segun la formula seria (n-1)
    jal fibonacci_memo  # Salta a la etiqueta fibonacci_memo
    sw $v0, 0($sp)	# Escribimos el resultado de la llamada en $v0 de la posicion 0($sp), es decir, primero sumamos 0 con la direccion $sp y luego escribimos en $v0
    lw $a0, 4($sp)	# Cargamos el valor original desde el stack, vale decir, primero sumamos 4 con $sp y luego lo llevamos a $a0 y lo leemos, hacemos lectura o carga de valores
    addi $a0, $a0, -2   # Decrementamos el valor del argumento $a0 en -2, es decir, $a0 = $a0 - 2 o por formula (n-2)
    jal fibonacci_memo  # Salta a la etiqueta fibonacci_memo
    lw $t0, 0($sp)	# Carga el valor de $t0, vale decir recupera el valor original $t0 , primero suma 0 con la direccion $sp y luego lo lleva a $a0 para ejecutar lectura
    add $v0, $t0, $v0   # Suma los dos resultados obtenidos
 
    # Recalcular &memolist[n]
    lw $a0, 4($sp)      # Recupera el n original desde el stack
    la $t3, memolist    # Recarga la dirección base de memolist
    sll $t4, $a0, 2      # $t4 = n * 4
    add $t3, $t3, $t4    # $t3 = &memolist[n]
    sw $v0, 0($t3)      # Almacena el resultado en memolist[n]
 
    lw $ra, 8($sp)      # Carga el valor en $ra, haciendo una recuperacion de la direccion de retotrno, primero suma el valor 8 con $sp y luego lo lleva a $ra para ejecutar lectura
    addi $sp, $sp, 12	# Ajustamos el puntero que hicimos al principio para devolverlo al estado original
    jr $ra		# Retornamos la direccion guardada en $ra
 
#Casos base
base_cases_memo: 
    bnez $a0, one_memo	# Salta a la etiqueta one_memo si $a0 no es $zero
    li $v0, 0		# Carga el valor 0 en $v0
    jr $ra	        # Retornamos la direccion guardada en $ra
# Caso 1
one_memo: 
    li $v0, 1	# Carga el valor de 1 en $v0
    jr $ra	# Retorna la direccion almacenada en $ra
 
memo_hit: 
    lw $v0, 0($t3)        # Cargamos el valor almacenado en memolist[n] en $v0 (t3 ya apunta a &memolist[n] en este punto)
    jr $ra		  # Retornamos la direccion guardada en $ra
 
