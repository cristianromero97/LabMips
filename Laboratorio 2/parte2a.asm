# los numeros puestos son de ejemplo el resultado deberia ser 12 <-(4x3), si se cambian el mensaje de entrada tambien debe hacerse
.data
mensaje_entrada:   .asciiz   "****** La multiplicacion de (4 x 3) ***************" 	
primer_numero:    .word 4    # primer numero a multiplicar
segundo_numero:   .word 3    # segundo numero a multiplicar
resultado:        .word 0    # resultado de la multiplicacion
mensaje_multiplicacion: .asciiz "Resultado de la multiplicación: "
salto_linea: .asciiz "\n"

.text

main:
   lw  $s0, primer_numero           # defino $s0 = 4 (primer_numero)
   lw  $s1, segundo_numero          # defino $s1 = 3 (segundo_numero)
   li  $t2, 0                       # defino variable auxiliar iniciada en 0
   
while:
   beq  $s1, $zero, escritura  # $s1 = 0 salto a escritura
   add  $t2, $t2, $s0          # sumo el valor de $s0 de forma iterativa y lo guardo, $t2 = $t2 + $s0 o (ej = $t2 = $t2 + 4) 
   addi $s1, $s1, -1           # disminuyo el valor de $s1, $s1 = $s1 - 1 o (ej = $s1 = 3 - 1)
   j while                     # vuelvo al ciclo
 
escritura:
   sw  $t2, resultado       # escribo el valor de $t2 en la variable "resultado",  resultado = $t2
   j salida		    # salto a la salida
    
salida:   
   # Imprimo mensaje de entrada
   li $v0, 4                  
   la $a0, mensaje_entrada     
   syscall  
    	
   # Imprimo salto de linea 
   li $v0, 4          
   la $a0, salto_linea    
   syscall
     
   # Imprimo mensaje de la multiplicacion 
   li $v0, 4                  
   la $a0, mensaje_multiplicacion         
   syscall   	
        	
   # Imprimo resultado
   lw  $a0, resultado          
   li  $v0, 1                  
   syscall                     
           
   # fin del programa
   li  $v0, 10              
   syscall                  
