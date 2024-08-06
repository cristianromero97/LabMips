.data

a: .word 0
z: .word 1

salto_linea:	.asciiz "\n"
mensaje1:	.asciiz "El valor de a al finalizar el ciclo es : "
mensaje2:	.asciiz "El valor de z al finalizar el ciclo es : "

.text

main:
	#Cargo los valores de a y z
	lw $s0, a	#Leo el valor de a y lo guardo en el registro $s0
	lw $s1, z	#Leo el valor de z y lo guardo en el registro $s1
	addi $t0 , $zero , 10	#Utilizo una variable temporal para guardar el 10 del ciclo while
	
while:	
	beq $s1, $t0 , salida	# z <> 10
	add $s0 , $s0 , $s1	# a = a + z
	addi $s1, $s1 , 1 	# z = z + 1
	j while			# vuelve al ciclo hasta terminar la iteracionnn
	
salida:
	#Impresion y salida de datos
	
	#imprimo mensaje 1
	li $v0, 4
	la $a0 , mensaje1
	syscall
	
	#lectura del valor de a
	li $v0 , 1
	move $a0, $s0	#tengo que mover el registro para poder imprimirlo
	syscall
	
	#imprimo salto de linea
	li $v0, 4
	la $a0, salto_linea
	syscall
	
	#imprimo mensaje 2
	li $v0, 4
	la $a0, mensaje2
	syscall
	
	#lectura del valor de z
	li $v0, 1
	move $a0, $s1	#tengo que mover el registro para poder imprimirlo
	syscall
	
	#fin del programa
 	li $v0 , 10
 	syscall
	
