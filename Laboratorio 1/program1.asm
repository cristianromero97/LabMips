.data
    numero1:   .word 4     # Variable que utilizare como primer numero , a modo de ejemplo esta puesto el 4, se puede cambiar este valor
    numero2:   .word 3     # Variable que utilizare como segundo numero , a modo de ejemplo esta puesto el 3 , se puede cambiar este valor
    resultado: .word 0     # Variable para almacenar el resultado, la necesitare para hacer la multiplicacion sucesivaa

    # Cadena de formato para la impresión
    nuevalinea: .asciiz "\nResultado de la multiplicación: %d\n"

.text
    main:
        lw  $t0, numero1           # Carga el primer número y lo guardo en el registro $t0
        lw  $t1, numero2           # Carga el segundo número y lo guardo en el registro $t1
        li  $t2, 0                 # Inicializar el registro de $t2 a 0 (para almacenar el resultado), esto lo usare como variable auxiliar

    loop:
        beq  $t1, $zero, done    # Compara el valor del registro $t1 con $0, Si $t1 es igual a 0, sale del bucle , basicamente $t1 == $0
        add  $t2, $t2, $t0       # Sumar el valor del registro $t0 con el registro $t2  y lo almacena en el registro $t2 , basicamente $t2 = $t2 + $t0
        addi $t1, $t1, -1        # Decrementar el valor del registro de $t1 en 1 y lo almaceno en $$t1, basicamente $t1 = $t1 -1
        j    loop                # Volver al inicio del bucle

    done:
        sw  $t2, resultado          # Almacenar el resultado en la memoria

        # Mostrar el resultado por consola
        lw  $a0, resultado          # Carga el valor de resultado en $a0
        li  $v0, 1                  # Carga el código la constante 1 en el registro $v0, esto me servira para imprimir un valor numerico
        syscall                     # Realiza la llamada de salida para imprimir el valor por consola, el valor equivaldra a la multiplicacion entre numero1 y numero2

        # Imprimir una nueva línea
        li  $v0, 4                  # Carga el código la constante 4 en el registro $v0, esto me servira para imprimir cadenas de strings
        la  $a0, nuevalinea         # Carga la direccion de la cadena de nuevalinea
        syscall                     # Realiza la llamada de salida para imprimir un salto de linea por consola 

        # Terminar el programa
        li  $v0, 10              # Carga el código la constante 10 en el registro $v0, esto me indicara la finalizacion de la salida del programa
        syscall                  # Realiza la llamada de salida para finalizar el programa
