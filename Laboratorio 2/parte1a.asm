.data
primer_numero: .asciiz "Por favor ingrese el primer entero: "
segundo_numero: .asciiz "Por favor ingrese el segundo entero: "
mensaje_diferencia: .asciiz "La diferencia es: "
mensaje_par: .asciiz " (Par)"
mensaje_impar: .asciiz " (Impar)"
mensaje_nuevo_primero: .asciiz "Nuevo primer entero: "
mensaje_nuevo_segundo: .asciiz "Nuevo segundo entero: "
salto_linea: .asciiz "\n"

.text

main:
    # Imprimo mensaje primer_numero
    li $v0, 4
    la $a0, primer_numero
    syscall

    # Imprimo valor
    li $v0, 5	   # Se captura el valor
    syscall	   # Se imprime
    
    #Guardo el valor
    move $s0, $v0  # muevo el registro capturado y lo guardo en $s0
   
    # Imprimo mensaje segundo_numero
    li $v0, 4
    la $a0, segundo_numero
    syscall

    # Imprimo valor
    li $v0, 5	  # Se captura el valor
    syscall	  # Se imprime
    
    # Guardo el valor		
    move $s1, $v0 # muevo el registro capturado y lo guardo en $s1
     
resta:   
    sub $t2, $s0, $s1	  # $t2 = $s0 - $s1	
    andi $t3, $t2, 1 	  # Analiza el bit menos significante   
    beq $t3, $zero, diferencia_par   # $t3 <> 0	  -> Si es 0 salta a la etiqueta diferencia par		
    j diferencia_impar		     # $t3 == 1   -> Si es 1 salta a la etiqueta diferencia impar

diferencia_par:
    add $t4 , $t4 , $zero # creo una variable auxiliar para poder almacenar el valor de la suma futura  -> $t4 = $t4 + 0	
    add $t4, $t2 , $s0    # sumo el valor del registro $s0 con $t4 y lo guardo en $t4 -> $t4 = $t4 + $s0  
    j salida_par	  # salto a salida "par" para imprimir resultados
    
diferencia_impar:
    add $t4, $t4 , $zero  # creo una variable auxiliar para poder almacenar el valor de la suma futura  -> $t4 = $t4 + 0
    add $t4, $t2 , $s1	  # sumo el valor del registro $s1 con $t4 y lo guardo en $t4 -> $t4 = $t4 + $s1 	
    j salida_impar	  # salto a salida "impar" para imprimir resultados

salida_par:	
    # Imprimo mensaje diferencia
    li $v0, 4
    la $a0, mensaje_diferencia
    syscall  
    	
    # Imprimo la diferencia correspondiente
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Imprimo mensaje par
    li $v0, 4
    la $a0, mensaje_par
    syscall 
    
    # Imprimo salto de linea 
    li $v0, 4          
    la $a0, salto_linea    
    syscall
    
    # Imprimo mensaje nuevo primero
    li $v0, 4          
    la $a0, mensaje_nuevo_primero   
    syscall
    
    # Imprimo el resultado de la suma con el primer valor
    li $v0, 1
    move $a0, $t4
    syscall
    	
    # fin del programa
    li $v0, 10
    syscall
		   	   	   	   	   	   	      	       	   	   	   	   	   	   	   	   	   	
salida_impar:	
    # Imprimo mensaje diferencia
    li $v0, 4
    la $a0, mensaje_diferencia
    syscall
    	    	                       	                   
    # Imprimo la diferencia correspondiente
    li $v0, 1
    move $a0, $t2
    syscall
    
    # Imprimo mensaje impar
    li $v0, 4
    la $a0, mensaje_impar
    syscall     
    
    # Imprimo salto de linea 
    li $v0, 4          
    la $a0, salto_linea    
    syscall
    
    # Imprimo mensaje nuevo segundo
    li $v0, 4          
    la $a0, mensaje_nuevo_segundo   
    syscall
    
    # Imprimo el resultado de la suma con el segundo valor
    li $v0, 1
    move $a0, $t4
    syscall
   	
    # fin del programa
    li $v0, 10
    syscall


