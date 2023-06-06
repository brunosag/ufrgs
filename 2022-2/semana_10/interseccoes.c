// Bruno Samuel Ardenghi Gonçalves
// 02/03/2023
// Lê coordenadas de múltiplos retângulos do usuário e verifica intersecções

#include <stdio.h>
#include <stdbool.h>
#define XL 0
#define YL 1
#define XR 2
#define YR 3

int ler_n_retangulos(void);
bool intersect(float a[4], float b[4]);

int main(void)
{
    // Inicializar matriz e ler número de retângulos
    float retangulo[10][4] = {{0, 0, 0, 0}};
    int n_retangulos = ler_n_retangulos();

    // Ler coordenadas de cada retângulo
    for (int i = 0; i < n_retangulos; i++)
    {
        printf("Retangulo %d:\n", i);
        printf("Digite a coordenada esquerda (x,y): ");
        scanf("%f %f", &(retangulo[i][XL]), &(retangulo[i][YL]));
        printf("Digite a coordenada direita (x,y): ");
        scanf("%f %f", &(retangulo[i][XR]), &(retangulo[i][YR]));
    }

    // Verificar intersecção dos pares de retângulos
    int n_interseccoes = 0;
    for (int i = 0; i < n_retangulos; i++)
    {
        for (int j = i + 1; j < n_retangulos; j++)
        {
            if (intersect(retangulo[i], retangulo[j]))
            {
                // Confirmar intersecção
                printf("Interseccao entre os retangulos %d e %d\n", i, j);
                n_interseccoes++;
            }
        }
    }
    printf("O nro de ocorrencias de interseccao eh %d", n_interseccoes);
}

int ler_n_retangulos(void)
{
    int n_retangulos = 0;
    do
    {
        printf("Digite o nro de retangulos: ");
        scanf("%d", &n_retangulos);
    }
    while (n_retangulos < 2 || n_retangulos > 10);
    return n_retangulos;
}

bool intersect(float a[4], float b[4])
{
    bool interseccao = true;
    if (a[XL] > b[XR]
     || a[YR] < b[YL]
     || a[YL] > b[YR]
     || a[XR] < b[XL])
    {
        interseccao = false;
    }
    return interseccao;
}
