#include "lse.h"

ptLSE *insere(ptLSE *ptLista, int num)
{
    // Caso: Lista vazia
    if (ptLista == NULL)
    {
        ptLista = malloc(sizeof(ptLSE));
        ptLista->numero = num;
        ptLista->prox = NULL;

        return ptLista;
    }

    ptLSE *atual = ptLista;

    // Caso: Número é o primeiro elemento
    if (atual->numero == num)
    {
        ptLSE *menor = malloc(sizeof(ptLSE));
        ptLSE *maior = malloc(sizeof(ptLSE));

        menor->numero = num - 1;
        maior->numero = num + 1;

        menor->prox = atual;
        maior->prox = atual->prox;
        atual->prox = maior;

        ptLista = menor;
        return ptLista;
    }

    // Procurar número na lista
    while (atual->prox != NULL)
    {
        if (atual->prox->numero == num)
        {
            ptLSE *menor = malloc(sizeof(ptLSE));
            ptLSE *maior = malloc(sizeof(ptLSE));

            menor->numero = num - 1;
            maior->numero = num + 1;

            menor->prox = atual->prox;
            maior->prox = atual->prox->prox;
            atual->prox = menor;
            atual->prox->prox->prox = maior;

            return ptLista;
        }

        atual = atual->prox;
    }

    // Caso: Número não encontrado
    ptLSE *antigo_ptLista = ptLista;
    ptLista = ptLista->prox;
    free(antigo_ptLista);

    if (ptLista != NULL)
    {
        if (ptLista->prox == NULL)
        {
            free(ptLista);
            return NULL;
        }

        atual = ptLista;
        while (atual->prox->prox != NULL)
            atual = atual->prox;

        free(atual->prox);
        atual->prox = NULL;
    }
}

void destroi(ptLSE *ptLista)
{
    ptLSE *atual = ptLista;
    while (atual != NULL)
    {
        ptLSE *prox = atual->prox;
        free(atual);
        atual = prox;
    }
}

void imprime(ptLSE *ptLista)
{
    if (ptLista == NULL)
    {
        printf("A lista está vazia.\n");
    }
    else
    {
        ptLSE *atual = ptLista;
        while (atual != NULL)
        {
            printf("%d ", atual->numero);
            atual = atual->prox;
        }
        printf("\n");
    }
}
