#include <stdio.h>
#include <unistd.h>
#define QTD 5

int main(void)
{
    int ledPin[QTD] = {5, 6, 9, 10, 11};

    // Ler distância
    int n;
    printf("Entre com a distância: ");
    scanf("%d", &n);

    if (n > 31)
    {
        // Ligar e desligar luzes sequencialmente
        for (int i = 0; i < QTD; i++)
        {
            printf("Ligar %d\n", ledPin[i]);
            sleep(1);
        }
        for (int i = 1; i <= QTD; i++)
        {
            printf("Desligar %d\n", ledPin[QTD - i]);
            sleep(1);
        }
    }
    else
    {
        // Converter decimal para binário
        int bin[QTD] = {0};
        for (int i = 1; n > 0; i++)
        {
            bin[QTD - i] = n % 2;
            n /= 2;
        }

        // Ligar luzes correspondentes
        for (int i = 0; i < QTD; i++)
        {
            if (bin[i])
                printf("Ligar %d\n", ledPin[i]);
            else
                printf("Desligar %d\n", ledPin[i]);
        }
    }
}
