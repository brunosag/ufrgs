#include "ldec.h"

int main()
{
    // a) Cria lista vazia
    ptLDEC *ptLista = NULL;

    // b) Insere os elementos na lista (número indeterminado de elementos)
    int num;
    do
    {
        printf("Digite o valor a ser inserido (0 para sair): ");
        scanf("%d", &num);
        if (num != 0)
            ptLista = insere(ptLista, num);
    } while (num != 0);
    printf("\n");

    // c) Exibe todos os elementos da lista
    imprime(ptLista);

    // d) Destrói a lista
    destroi(ptLista);
    ptLista = NULL;

    // e) Exibe todos os elementos da lista
    imprime(ptLista);

    return 0;
}
