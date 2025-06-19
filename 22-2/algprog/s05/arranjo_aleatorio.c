// Bruno Samuel Ardenghi Gonçalves
// 29/12/2022
// Preenche um arranjo de números inteiros com 20000 valores aleatórios e informa os valores mínimo, máximo e médio, com seus respectivos índices.

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define QTD 20000
#define MIN 1000
#define MAX 100000

int main(void)
{
	// Preencher um arranjo de números inteiros com 20000 valores aleatórios
	int numeros[QTD];
	int aleatorio, valor, maior[2] = {MIN}, menor[2] = {MAX}, acumulado = 0;
	srand(time(NULL));
	for (int i = 0; i < QTD; i++)
    {
		// Adicionar valor aleatório entre 1000 e 100000
		aleatorio = rand();
		valor = MIN + (aleatorio % (MAX - MIN + 1));
		numeros[i] = valor;

		// Verificar maior valor
		if (valor > maior[0])
        {
			maior[0] = valor;
			maior[1] = i;
		}

		// Verificar menor valor
		if (valor < menor[0])
        {
			menor[0] = valor;
			menor[1] = i;
		}

		// Adicionar valor ao acumulado
		acumulado += valor;
	}

	// Calcular valor médio
	int media = acumulado / QTD;

	// Procurar valor mais próximo da média
	int proximo_media, dif_temp, dif = MAX;
	for (int i = 0; i < QTD; i++)
    {
		dif_temp = abs(numeros[i] - media);
		if (dif_temp < dif)
        {
			dif = dif_temp;
			proximo_media = i;
		}
	}

	// Imprimir valores e posições
	printf("MAIOR NUMERO: %d, indice %d\n", maior[0], maior[1]);
	printf("MENOR NUMERO: %d, indice %d\n", menor[0], menor[1]);
	printf("VALOR MEDIO: %d\n", media);
	printf("VALOR MAIS PROXIMO DO MEDIO: indice %d\n", proximo_media);
}
