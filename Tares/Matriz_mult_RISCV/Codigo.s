.data
# Matriz A (3x3)
A:  .word 1, 2, 3
    .word 4, 5, 6
    .word 7, 8, 9

# Matriz B (3x3)
B:  .word 9, 8, 7
    .word 6, 5, 4
    .word 3, 2, 1

# Matriz C (3x3) vacía
C:  .word 0, 0, 0
    .word 0, 0, 0
    .word 0, 0, 0

# Constantes
size:     .word 3
newline:  .asciz "\n"
space:    .asciz " "

.text
.globl _start

_start:
    li t0, 0          # i = 0
    lw t4, size       # t4 = 3

# Recorrer filas de A
outer_loop:
    bge t0, t4, end_outer
    
    li t1, 0          # j = 0

# Recorrer columnas de B
middle_loop:
    bge t1, t4, end_middle

    # Posición de C[i][j]
    mul t5, t0, t4
    add t5, t5, t1
    slli t5, t5, 2
    la t6, C
    add t6, t6, t5

    li t2, 0          # k = 0
    li a2, 0          # sum = 0

# Multiplicar fila por columna
inner_loop:
    bge t2, t4, end_inner

    # A[i][k]
    mul t5, t0, t4
    add t5, t5, t2
    slli t5, t5, 2
    la a3, A
    add a3, a3, t5
    lw a4, 0(a3)

    # B[k][j]
    mul t5, t2, t4
    add t5, t5, t1
    slli t5, t5, 2
    la a5, B
    add a5, a5, t5
    lw a6, 0(a5)

    # A[i][k] * B[k][j]
    mul a7, a4, a6
    add a2, a2, a7

    addi t2, t2, 1    # k++
    j inner_loop

# Guardar en C[i][j]
end_inner:
    sw a2, 0(t6)

    addi t1, t1, 1    # j++
    j middle_loop

# Siguiente fila
end_middle:
    addi t0, t0, 1    # i++
    j outer_loop

end_outer:
    li t0, 0          # i = 0
    lw t4, size

# Imprimir C
print_outer:
    bge t0, t4, end_print
    
    li t1, 0          # j = 0

print_inner:
    bge t1, t4, end_print_row

    # Posición de C[i][j]
    mul t5, t0, t4
    add t5, t5, t1
    slli t5, t5, 2
    la t6, C
    add t6, t6, t5
    lw a0, 0(t6)

    # Imprimir número
    li a7, 1
    ecall

    # Imprimir espacio
    li a7, 4
    la a0, space
    ecall

    addi t1, t1, 1    # j++
    j print_inner

# Imprimir salto de línea
end_print_row:
    li a7, 4
    la a0, newline
    ecall

    addi t0, t0, 1    # i++
    j print_outer

# Fin
end_print:
    li a7, 10
    ecall
