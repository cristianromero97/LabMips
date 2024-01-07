.data
a: .word 0                    # Variable a con valor inicial de 0
z: .word 1                    # Variable z con valor inicial de 1
nuevalinea: .asciiz  "\n"     # Salto de linea

.text
main:
    lw $t0, a      # Guarda el valor de a en el registro $t0
    lw $t1, z      # Guarda el valor de z en el registro $t1

loop:
    beq $t1, 10, salida    # Compara el valor del registro $t1 con 10, si $t1 = 10 o vale decir z == 10 salta a salida
    add $t0, $t0, $t1      # Suma el valor del registro $t0 y $t1 y lo guarda en $t0, $t0 = $t0 + $t1, basicamente a = a + z
    addi $t1, $t1, 1       # Suma el valor del registro $t1 y una variable constante de 1 y lo guarda en $t1, $t1 = $t1 +1, basicammente z = z + 1
    j loop                 # Salta de nuevo a loop

salida:
    # El siguiente apartado consiste en la impresion de los valores de a y z, esta parte se puede usar como comprobacion  
    # Impresión del valor de $t0 (valor de a)
    li $v0, 1              # Guarda el codigo la constante 1 en el registro $v0, esto me servira para imprimir un valor numerico
    move $a0, $t0          # Mueve el valor del registro $t0 al registro $a0, que sera el argumennto de salida para el valor de a
    syscall                # Realiza la llamada de salida para immprimir el valor del registro $t0 en consola
    
    # Imprimir una nueva línea
    li $v0, 4             # Guarda el codigo la constante 4 en el registro $v0, esto me servira como indicador para imprimir una cadena de string 
    la $a0, nuevalinea    # Carga la direccion de la cadena con la etiqueta nuevalinea 
    syscall               # Realiza la llamada de salida para imprimir el valor del registro $a0 que contiene el salto de linea
    
    # Impresión del valor de $t1 (valor de z)
    li $v0, 1            # Guarda el codigo la constante 1 en el registro $v0 , esto me serviraa para imprimmir un valor numerico
    move $a0, $t1        # Mueve el valor del registro $t1 al registro $a0, que sera el argumento de salida para el valor de z
    syscall              # Realiza la llamada de salida para imprimir el valor del registro $t1 en consola 
    
    # Salida del programa
    li $v0, 10          # Carga el codigo con la constante 10 en el registro $v0, esto me indicara una llamada para finalizar el programa
    syscall            # Realiza la llamada para finalizar el programa 



