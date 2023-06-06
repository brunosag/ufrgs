// Bruno Samuel Ardenghi Gonçalves
// 15/12/2022
// Aproxima o valor de raiz de 2 através do algoritmo de Newton-Raphson partindo de uma aproximação inicial do usuário.

#include <stdio.h>
#include <math.h>

int main(void)
{
    // Ler aproximação inicial do usuário
    float x0;
    printf("Entre com um chute: ");
    scanf("%f", &x0);

    // Definir tolerância de erro
    float tol = 0.000001;

    // Aplicar equação de recorrência
    float x = 0;
    while (x0 - x > tol) {
        if (x != 0) x0 = x;
        x = x0 - (pow(x0, 2) - 2) / (2 * x0);
        printf("%f\n", x);
    }
    printf("Raiz de 2 aproximada: %f", x);
}
