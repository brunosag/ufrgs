#include <stdio.h>

int main(void)
{
    // Ler valor inteiro do usuário
    int n;
    printf("Entre com o valor de N: ");
    scanf("%d", &n);
    int dezena = n / 10;
    int unidade = n % 10;

    // Verificar valor fora do intervalo
    if (n < 20 || n > 39) {
        printf("Valor fora do intervalo!");
    }

    else {
        // Imprimir soma dos algarismos
        printf("Soma dos algarismos = %d\n", dezena + unidade);

        // Imprimir dezena por extenso
        printf("Extenso: ");
        switch (dezena)
        {
        case 2:
            printf("Vinte");
            break;
        case 3:
            printf("Trinta");
            break;
        }

        // Verificar se há unidade
        if (unidade == 0) {
            return 0;
        }
        else {
            printf(" e ");
        }

        // Imprimir unidade por extenso
        switch (unidade)
        {
        case 1:
            printf("um");
            break;
        case 2:
            printf("dois");
            break;
        case 3:
            printf("três");
            break;
        case 4:
            printf("quatro");
            break;
        case 5:
            printf("cinco");
            break;
        case 6:
            printf("seis");
            break;
        case 7:
            printf("sete");
            break;
        case 8:
            printf("oito");
            break;
        case 9:
            printf("nove");
            break;
        }
    }

}
