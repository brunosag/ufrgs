#include <stdio.h>
#include <stdlib.h>

typedef struct tipoNo ptLSE;
struct tipoNo
{
    int numero;
    ptLSE *prox;
};

ptLSE *insere(ptLSE *ptLista, int num);
void destroi(ptLSE *ptLista);
void imprime(ptLSE *ptLista);
