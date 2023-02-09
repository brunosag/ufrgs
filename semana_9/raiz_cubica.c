// Bruno Samuel Ardenghi Gonçalves
// 09/02/2023
// Lê do usuário um número r, um x0 e uma tolerância e calcula uma aproximação da raíz cúbica de r

#include <stdio.h>
#include <math.h>

float raiz_cubica(float r, float x0, float t);

int main(void)
{
    // Ler valores do usuário
    float r = 0;
    float x0 = 0;
    float t = 0;
    printf("Entre com o valor de r: ");
    scanf("%f", &r);
    printf("Entre com o valor de x0: ");
    scanf("%f", &x0);
    printf("Entre a tolerância: ");
    scanf("%f", &t);

    // Validar valor de t
    if (t > 0)
        printf("A raiz cubica aproximada de %.4f é %f\n", r, raiz_cubica(r, x0, t));
    else
        printf("Valor de t inválido!\n");
}

float raiz_cubica(float r, float x0, float t)
{
    // Calcular aproximação da raíz cúbica de r
    float x = x0;
    do
    {
        x -= (pow(x, 3) - r) / (3 * pow(x, 2));
    }
    while (fabs((pow(x, 3) - r) >= t));
    return x;
}
