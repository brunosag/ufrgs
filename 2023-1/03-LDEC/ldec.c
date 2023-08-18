#include "ldec.h"

ptLDEC *insere(ptLDEC *ptLista, int num)
{
    // Caso: Lista vazia
    if (ptLista == NULL)
    {
        ptLista = malloc(sizeof(ptLDEC));
        ptLista->numero = num;
        ptLista->prox = ptLista;
        ptLista->ant = ptLista;

        return ptLista;
    }

    ptLDEC *atual = ptLista;

    // Procurar número na lista
    do
    {
        if (atual->numero == num)
        {
            ptLDEC *menor = malloc(sizeof(ptLDEC));
            ptLDEC *maior = malloc(sizeof(ptLDEC));

            menor->numero = num - 1;
            maior->numero = num + 1;

            if (atual != ptLista)
            {
                menor->ant = atual->ant;
                maior->prox = atual->prox;
                atual->prox->ant = maior;
                atual->ant->prox = menor;
            }
            else
            {
                menor->ant = maior;
                maior->prox = menor;
                ptLista = menor;
            }
            menor->prox = atual;
            maior->ant = atual;
            atual->prox = maior;
            atual->ant = menor;

            return ptLista;
        }

        atual = atual->prox;
    } while (atual != ptLista);

    // Caso: Número não encontrado
    int qtdNodos = 1;
    while (qtdNodos < 4 && atual->prox != ptLista)
    {
        qtdNodos++;
        atual = atual->prox;
    }

    ptLDEC *primeiroNodo = ptLista;
    ptLDEC *ultimoNodo = ptLista->ant;

    if (qtdNodos >= 4)
    {
        ptLista->prox->ant = ptLista->ant->ant;
        ptLista->ant->ant->prox = ptLista->prox;
        ptLista = ptLista->prox;
    }
    else if (qtdNodos == 3)
    {
        ptLista->prox->prox = ptLista->prox;
        ptLista->prox->ant = ptLista->prox;
        ptLista = ptLista->prox;
    }
    else
    {
        ptLista = NULL;
    }

    free(primeiroNodo);
    free(ultimoNodo);

    return ptLista;
}

void destroi(ptLDEC *ptLista)
{
    if (ptLista != NULL)
    {
        ptLDEC *atual = ptLista;
        do
        {
            ptLDEC *prox = atual->prox;
            free(atual);
            atual = prox;
        } while (atual != ptLista);
    }
}

void imprime(ptLDEC *ptLista)
{
    if (ptLista == NULL)
    {
        printf("A lista está vazia.\n");
    }
    else
    {
        ptLDEC *atual = ptLista;
        do
        {
            printf("%d ", atual->numero);
            atual = atual->prox;
        } while (atual != ptLista);
        printf("\n");
    }
}
