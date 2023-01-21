#include <stdio.h>
#include <math.h>
#define MAXLIDOS 10

int main(void)
{
    // Ler valores do usuário até um negativo ou até o limite
    float n, valores[MAXLIDOS];
    int i = 0, positivo = 1;
    printf("Entre os valores: ");
    while (positivo && i < MAXLIDOS)
    {
        scanf(" %f", &n);
        if (n >= 0)
        {
            valores[i] = n;
            i++;
        }
        else
        {
            positivo = 0;
        }
    }
    int qtd_valores = i;

    // Imprimir média dos quadrados
    float acumulado = 0;
    for (int i = 0; i < qtd_valores; i++)
    {
        acumulado += pow(valores[i], 2);
    }
    float media_quadrados = acumulado / qtd_valores;
    printf("Media dos quadrados: %f\n", media_quadrados);

    // Imprimir média das raízes
    acumulado = 0;
    for (int i = 0; i < qtd_valores; i++)
    {
        acumulado += sqrt(valores[i]);
    }
    float media_raizes = acumulado / qtd_valores;
    printf("Media das raizes quadradas: %f\n", media_raizes);

    // Imprimir quantidade de valores entre os calculados
    int entre_medias = 0;
    for (int i = 0; i < qtd_valores; i++)
    {
        if (valores[i] > media_raizes && valores[i] < media_quadrados)
        {
            entre_medias++;
        }
    }
    printf("Quantidade de valores entre as duas medias: %d", entre_medias);
}
