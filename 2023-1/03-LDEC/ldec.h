#ifndef LDEC_H
#define LDEC_H

#include <stdio.h>
#include <stdlib.h>

typedef struct tipoNo ptLDEC;
struct tipoNo
{
    int numero;
    ptLDEC *prox;
    ptLDEC *ant;
};

ptLDEC *insere(ptLDEC *ptLista, int num);
void destroi(ptLDEC *ptLista);
void imprime(ptLDEC *ptLista);

#endif
