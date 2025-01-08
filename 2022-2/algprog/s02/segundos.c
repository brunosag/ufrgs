// Bruno Samuel Ardenghi Gonçalves
// 01/12/2022
// Lê um número de segundos e retorna os dias, horas, minutos e segundos equivalentes.

#include <stdio.h>
#include <math.h>
#include <locale.h>

int main()
{
    setlocale(LC_ALL, "");

    // Ler número decimal do usuário
    float raio;
    printf("Entre com um valor para o raio: ");
    scanf("%f", &raio);

    // Calcular lado
    float lado = raio * sqrt(2);

    // Calcular perímetro e área
    float perimetro = lado * 4;
    float area = pow(lado, 2);

    printf("Perímetro do maior quadrado: %.2f\n", perimetro);
    printf("Área do maior quadrado: %.2f", area);
}
