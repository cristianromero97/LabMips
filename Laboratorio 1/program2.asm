.data

D: .space 80 # asumire que necesito espacio para el arreglo, se puede agrandar el espacio
B: .word 1   # el enunciado no indica su valor pero le dare el valor de 1
a: .word 0   # le dare el valor inicial de 0

salto_linea: .asciiz "\n"
espacio:     .asciiz "  "
mensaje1:    .asciiz "Los valores numericos del arreglo son : " 
mensaje2:    .asciiz "El valor de 'A' es igual : "
mensaje3:    .asciiz "El valor de 'B' es igual : "


.text	

main:
	#segun el enunciado estos son los registros donde deben ir a , b y d
	lw $s0, a	#defino a $s0 = a
	lw $s1, B	#defino b $s1 = b 
	la $s2, D	#defino el arreglo en $s2 = D[i]
	
	# todo lo siguiente es similar a un ejercicio que vimos en clase donde se ve slt con arreglo
	#aunque solo la transformacion
	
	#Utilizare esto antes del ciclo para imprimir los valores del arreglo
	#imprimo mensaje 1
	li $v0, 4
	la $a0 , mensaje1
	syscall
	
while:
	addi $t0, $zero, 10	#el valor 10 del ciclo lo dejo en una var temporal
	slt $t1, $s0, $t0	# a < 10, $t1 guarda el valor menor entro $s0 y $t0
	beq $t1, $zero, salida		#$t1 guarda el signo, por ende si es cero sale del ciclo
	
	#armado del arreglo 
	#Todo esto es similar a lo que aparece en el ppt para transfomar el arreglo
	sll $t2, $s0 , 2	# $t2 = i * 4 (byte offset)
	add $t2, $t2, $s2	# address of array
	add $t3, $s1 , $s0	# uso una variable temporal para dejar la suma entre a y b
	sw $t3, 0($t2)		# escribo el valor de la suma (a+b) en el arreglo[i]
	
	 # ----Verificacion de lo que sucede dentro del ciclo----
	 # Imprimir del arreglo
    	 lw $a0, 0($t2)     
   	 li $v0, 1
   	 syscall          
   	 
         # Impresion de espacio
         li $v0, 4          
         la $a0, espacio 
         syscall
		
	 addi $s0,$s0,1		# a = a + 1
	 j while
	
salida:

	# Impresion salto de linea inicial
         li $v0, 4          
         la $a0, salto_linea    
         syscall
         
	#imprimo mensaje 2
	li $v0, 4
	la $a0 , mensaje2
	syscall
	
	#imprimo valor
	move $a0 , $s0
	li $v0 , 1
	syscall
	
	#imprimo salto de linea
	li $v0, 4
	la $a0 , salto_linea
	syscall
	
	#imprimo mensaje 3
	li $v0, 4
	la $a0 , mensaje3
	syscall
		
	#imprimo valor
	move $a0 , $s1
	li $v0 , 1
	syscall
	
	#fin del programa
	li $v0 , 10
	syscall	
