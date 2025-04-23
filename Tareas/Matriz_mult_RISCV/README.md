
# Multiplicación de Matrices 3x3 en Ensamblador RISC-V

## Descripción

Este programa realiza la multiplicación de dos matrices 3x3 (`A × B`) usando instrucciones del conjunto **RISC-V 32I**.  
El resultado se almacena en una tercera matriz `C`, y luego se imprime fila por fila en consola.

---

## Entradas

Las matrices `A` y `B` están definidas en la sección `.data` como vectores lineales de 9 enteros:

# Matriz A (3x3)
```
A:  .word 1, 2, 3
    .word 4, 5, 6
    .word 7, 8, 9

# Matriz B (3x3)
B:  .word 9, 8, 7
    .word 6, 5, 4
    .word 3, 2, 1

# Matriz resultado C (3x3), inicializada en ceros
C:  .word 0, 0, 0
    .word 0, 0, 0
    .word 0, 0, 0

# Constantes
size:     .word 3           # Tamaño de la matriz
newline:  .asciz "\n"       # Salto de línea
space:    .asciz " "        # Espacio entre elementos
```


###  Estructura de bucles

- `i`: recorre las filas de `A`
- `j`: recorre las columnas de `B`
- `k`: recorre los elementos para calcular el producto escalar entre la fila `i` y la columna `j`

###  Cálculo del índice

Para acceder a un elemento `M[i][j]`, se utiliza la fórmula:

```
dirección = base + ((i * size + j) * 4)
```

Esto se usa para acceder correctamente a los datos de A, B y C, ya que están almacenados como vectores lineales.

### Multiplicación y acumulación

```text
C[i][j] = A[i][0] * B[0][j]
        + A[i][1] * B[1][j]
        + A[i][2] * B[2][j]
```

La suma de estos productos se guarda en el acumulador `sum`, y luego en `C[i][j]`.

---

## Impresión de la matriz `C`

Una vez calculada la matriz `C`, se imprimen sus valores con:

- `ecall 1`: para imprimir enteros
- `ecall 4`: para imprimir un espacio (`" "`) o salto de línea (`"\n"`)

### Ejemplo de salida esperada en memoria (C)

```
30 24 18 
84 69 54 
138 114 90 
```

---




