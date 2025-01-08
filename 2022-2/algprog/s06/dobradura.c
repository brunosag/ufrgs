// Bruno Samuel Ardenghi Gonçalves
// 22/01/2023
// Calcula o número de pedaços de papel resultantes de um número n de dobraduras feitas em um papel em adição a um corte vertical e um horizontal ao final

#include <stdio.h>
#include <math.h>

int main(void)
{
    // Ler número de dobraduras realizadas
    int n;
    printf("Insira o numero de dobraduras: ");
    scanf("%d", &n);

    // Calcular número de pedaços de papel resultante
    int x = (1 + 2 * (n - 1));
    int resultado = pow(x, 2) + (4 * x) + 4;
    printf("Pedacos de papel obtidos: %d", resultado);
}
