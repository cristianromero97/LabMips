.data
  startGame: .asciiz "Comienzo del juego...\n\n"
  prompt: .asciiz "Ingresa tu opción:"
  errMsg: .asciiz "No existe tal opción.\n"
  opt1: .asciiz "1. Ir hacia la puerta.\n2. Tomar la soga.\n3. Hacer un nudo.\n\n"
  opt2: .asciiz "1. Observar el nudo.\n2. Usar el dogal en el gancho.\n3. Inspeccionar la puerta.\n\n"
  route0: .asciiz "Estas en una habitación deteriorada, y al frente tuyo puedes ver una silla, la cual está debajo de un gancho.\nA tu lado puedes ver una soga bastante gruesa, probablemente pueda aguantar el peso de un elefante.\nAl fondo de la habitación, puedes notar una puerta cerrada al lado de una ventana, puedes ver el resplandor de la luna llena.\n\n"
  route1: .asciiz "La puerta está cerrada, y no tiene un cerrojo.\nSin embargo, se siente como si lo fuese.\n"
  route2A: .asciiz "Has tomado la soga, es bastante gruesa.\n"
  route2B: .asciiz "Ya has tomado la soga.\n"
  route3A: .asciiz "No tienes una soga para hacer un nudo.\n"
  route3B: .asciiz "Has hecho un dogal con la soga. Por alguna razon, no quieres deshacer el nudo.\n"
  route3B1: .asciiz "Es un buen nudo, sientes una atracción morbida con el.\n"
  route3B2: .asciiz "Te subiste a la silla, y ataste un nudo firme en el gancho con el otro extremo de la soga.\nLloras al ver la soga atarse a tu cuello como tu piensas que debe ser.\nPerdiste el balance en la silla con la soga en tu cuello y...\n\n- FIN -\n\n"
  route3B3: .asciiz "Usaste el dogal en la perilla de la puerta, pero no tienes fuerza para romper la perilla.\n"
  
.text
#Comienzo de juego
  main:
   add $t1,$0,$0
   li $v0,4
   la $a0,startGame
   syscall
   j option0
  
#Primer Menu - Opciones
  printMenu1:
   li $v0,4
   la $a0,opt1
   syscall
   la $a0,prompt
   syscall
   jr $ra
  
#Primer Menu - Contexto
  option0:
   li $v0,4
   la $a0,route0
   syscall
   j inputPrompt1

#Primer Menu - Input
 inputPrompt1:
   jal printMenu1
   li $v0,5
   syscall
   beq $v0,1,option1
   beq $v0,2,option2
   beq $v0,3,option3
   #Opción Invalida
   li $v0,4
   la $a0,errMsg
   syscall
   j inputPrompt1
 
#Si se escogio la primera opcion
 option1:
   li $v0,4
   la $a0,route1
   syscall
   j inputPrompt1

#Si se escogio la segunda opcion
 option2:
   beq $t1,0,option2A
   beq $t1,1,option2B

#...y no se activó el requerimiento
 option2A:
   li $v0,4
   la $a0,route2A
   syscall
   addi $t1,$0,1
   j inputPrompt1

#...y ya se habia tomado el requerimiento
 option2B:
   li $v0,4
   la $a0,route2B
   syscall
   j inputPrompt1
   
#Si se escogio la tercera opcion
 option3:
   beq $t1,0,option3A
   beq $t1,1,option3B

#...y no se activo el requerimiento
 option3A:
  li $v0,4
  la $a0,route3A
  syscall
  j inputPrompt1
   
#Segundo Menu - Opciones
  printMenu2:
   li $v0,4
   la $a0,opt2
   syscall
   la $a0,prompt
   syscall
   jr $ra
  
#Segundo Menu - Contexto
  option3B:
   li $v0,4
   la $a0,route3B
   syscall
   j inputPrompt2

#Segundo Menu - Input
 inputPrompt2:
   jal printMenu2
   li $v0,5
   syscall
   beq $v0,1,option3B1
   beq $v0,2,option3B2
   beq $v0,3,option3B3
   #Opción Invalida
   li $v0,4
   la $a0,errMsg
   syscall
   j inputPrompt2
   
 option3B1:
  li $v0,4
  la $a0,route3B1
  syscall
  j inputPrompt2
  
 option3B2:
  li $v0,4
  la $a0,route3B2
  syscall
  j main
  
 option3B3:
  li $v0,4
  la $a0,route3B3
  syscall
  j inputPrompt2
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   