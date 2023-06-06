// Bruno Samuel Ardenghi Gonçalves
// 26/01/2023
// Gera um valor aleatório de 1 a 10 e dá 5 chances de chute ao usuário,
// imprimindo o resultado de cada chute

#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#define MIN 1
#define MAX 10

int main(void)
{
    // Sortear valor aleatório
    srand(time(0));
    int sorteado = MIN + (rand() % (MAX - MIN + 1));
    printf("Sorteado: %d\n", sorteado);

    // Enquanto há tentativas e usuário não acertar
    int chute, tentativas = 0, chute_certo = 0;
    while (tentativas < 5 && !chute_certo)
    {
        // Ler chute do usuário
        printf("Digite seu chute: ");
        scanf("%d", &chute);
        tentativas++;

        // Comparar e imprimir resultado
        if (tentativas == 5 && chute != sorteado)
        {
            printf("Voce ultrapassou o numero maximo de tentativas!");

        }
        else if (chute < sorteado)
        {
            printf("Seu chute eh menor do que o valor sorteado!\n");
        }
        else if (chute > sorteado)
        {
            printf("Seu chute eh maior do que o valor sorteado!\n");
        }
        else
        {
            printf("Parabens! Voce acertou em %d tentativa(s)!", tentativas);
            chute_certo = 1;
        }
    }
}
