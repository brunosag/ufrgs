// Bruno Samuel Ardenghi Gonçalves
// 26/01/2023
// Gera uma matriz 4x4 com valores aleatórios, imprime os maiores valores de
// cada coluna e os menores valores de cada linha

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#define TAM 4
#define MIN 2
#define MAX 40

int main(void)
{
    // Criar e preencher matriz
    int matriz[TAM][TAM];
    int aleatorio, valor;
    printf("Matriz\n");
    srand(time(0));
    for (int i = 0; i < TAM; i++)
    {
        for (int j = 0; j < TAM; j++)
        {
            // Gerar e adicionar valor aleatório
            aleatorio = MIN + (rand() % (MAX - MIN + 1));
            matriz[i][j] = aleatorio;
            printf(" %2d", aleatorio);
        }
        printf("\n");
    }

    // Imprimir maior elemento de cada coluna
    int maior = MIN;
    printf("Arranjo maiores elementos colunas:\n");
    for (int j = 0; j < TAM; j++)
    {
        maior = MIN;
        for (int i = 0; i < TAM; i++)
        {
            if (matriz[i][j] > maior)
            {
                maior = matriz[i][j];
            }
        }
        printf(" %2d", maior);
    }
    printf("\n");

    // Imprimir menor elemento de cada linha
    int menor = MAX;
    printf("Arranjo menores elementos linhas:\n");
    for (int i = 0; i < TAM; i++)
    {
        menor = MAX;
        for (int j = 0; j < TAM; j++)
        {
            if (matriz[i][j] < menor)
            {
                menor = matriz[i][j];
            }
        }
        printf(" %2d", menor);
    }
}
