// Bruno Samuel Ardenghi Gonçalves
// 22/12/2022
// Lê e conta número de caracteres minúsculas e maiúsculas inseridas pelo usuario até uma específica que para o laço

#include <stdio.h>

int main(void)
{
    // Inicializar iterador, caractere e contadores
    int i = 0, minusculo = 0, maiusculo = 0;
    char c = 0;

    // Até usuário digitar '!'
    while (c != '!')
    {
        i++;

        // Ler caractere do usuário
        printf("Entre com o %do caractere: ", i);
        scanf(" %c", &c);

        // Contabilizar minúscula
        if (c >= 'a' && c <= 'z') {
            minusculo++;
        }

        // Contabilizar maiúscula
        if (c >= 'A' && c <= 'Z') {
            maiusculo++;
        }
    }

    // Imprimir número de caracteres minúsculos e maiúsculos informados
    printf("Voce digitou %d caracteres em minusculo e %d em maiusculo", minusculo, maiusculo);
}
