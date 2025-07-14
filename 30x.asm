#OPERACI�N 30*x, donde x es el �ltimo elemento de un vector donde adem�s se debe indicar el marcador de finalizaci�n#

#CONSIDERACIONES:
#direcci�n base del vector en 0x02 (por ejemplo)
#-1 es el marcador de finalizaci�n en el vector
# $s0: direcci�n base de V
# $t0: valor le�do de memoria
# $t1: �ltimo valor antes del marcador de finalizaci�n (x)
# $t2: valor en la �ltima posici�n del vector (-1 en este caso)
# $t3: offset para recorrer vector
# $t4: auxiliar para la multiplicaci�n (2x, 4x, etc.) #30x = 32x-2x
# $t5: acumulador resultado
#instrucciones permitidas: lw, sw, add, addi, sub, slt, and

.text
#inicializaciones
    	addi $s0, $zero, 2	   # direcci�n en la posicion 2
    	addi $t2, $zero, -1        # constante -1 seleccionada como marcador
    	addi $t3, $zero, 0         # offset inicial = 0

bucle: #para realizar el recorrido hasta encontrar x
	add $t6, $s0, $t3          # direcci�n = base + offset
    	lw  $t0, 0($t6)            # lectura  
    	beq $t0, $t2, final        # si valor == -1, terminar
    	add $t1, $t0, $zero        # guardar �ltimo valor le�do que sea diferente del marcador de finalizaci�n
    	addi $t3, $t3, 1          # offset += 1
    	beq $zero, $zero, bucle     # condici�n trivial 0=0 para convertir el ciclo en un bucle

final: #una vez cumplida la condicion de salto, el valor anterior a -1 se encuentra en $t1 (x)
    	add $t4, $t1, $t1      # 2x
    	add $t4, $t4, $t4      # 4x
    	add $t4, $t4, $t4      # 8x
    	add $t4, $t4, $t4      # 16x
	add $t4, $t4, $t4      # 32x
    	add $t5, $t1, $t1      # 2x
	sub $t5, $t4, $t5      # 30x=32x-2x
    	sw  $t5, 0($s0)        # guardar resultado en la posici�n 0x02
