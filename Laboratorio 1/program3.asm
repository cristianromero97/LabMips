.data

arr: .word 10 22 15 40 55 80	#se pueden ir añadiendo mas valores, estos son los que aparecen en el ejemplo (4 primeros valores)

#asumire esto que aparece en el codigo tanto el nombre arrlen para largo como evensum para la suma de pares
arrlen: .word 0
evensum: .word 0

salto_linea: .asciiz "\n"
mensaje1: .asciiz "El numero sumado par del arreglo final es : "

.text
	#Todo esto es segun como lo especifica el enunciado....
main:	
	#lectura de datos de entrada
	la $s0, arr
	la $s1, arrlen 
	la $s2, evensum	#el ejercicio dice que utilizemos $t0 para guardar los valores de evensum, pero al ser un valor importante utilizare s2, puedo ocupar $t0 solo cambiaria algunos registros
	#cargo el valor numerico del arreglo = 0 (posicion cero)
	lw $t0, 0($s1)
	subu $s1 , $s1, $s0
	srl $s1, $s1 , 2
	
	#Lo que viene de aqui es invencion
	
	li $t1, 0  #utilizare un contador, para ir moviendome en el arreglo
	li $s2, 0  #evensum ya es cero pero aqui lo inicializo en cero para hacer avanzar la suma y que lo concadene	
	
while:  
	beq $t1, $s1 , salida	#si $t1 == $s1, vale decir la cantidad del arreglo es igual al contador, sale del ciclo while
	lw $t3, 0($s0)		#Guarda en $t3, el inicio del arreglo $s0
	
	andi $t4, $t3 , 1	# avanza en una posicion
	beq $t4, $zero , par	# si $t4 == 0  saltara a la etiqueta par, en caso de que coloquemos bne, saltara a los impares arr[] == 0
	j iteracion
	
par:
	#suma las posiciones pares y las guarda en evensum
	add $s2, $s2, $t3

iteracion:
	#avanzo la iteracion del arreglo tanto en memoria,es decir, siguiente posicion, como tambien el contador
	addi $s0, $s0 , 4
	addi $t1, $t1 , 1
	j while
	
	
salida:
	#lectura del resultado de evensum
	
	#imprimo mensaje 1
	li $v0, 4
	la $a0 , mensaje1
	syscall
	
	#imprimo valor
	move $a0 , $s2
	li $v0 , 1
	syscall
	
	#imprimo salto de linea
	li $v0, 4
	la $a0 , salto_linea
	syscall
	
	#fin del programa
	li $v0, 10
	syscall	
	

		
