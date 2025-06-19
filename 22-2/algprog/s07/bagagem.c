#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define LIN 4
#define COL 15
#define MIN 0
#define MAX 40

int main(void)
{
	// Inicializar matriz 4x15
	int aviao[LIN][COL];

	// Gerar peso aleatório para cada mala (0, 40)
    int aleatorio;
    srand(time(0));
	for (int i = 0; i < LIN; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			aleatorio = MIN + (rand() % (MAX - MIN + 1));
			aviao[i][j] = aleatorio;
		}
	}

	// Calcular média do lado 1
	int peso, acumulado = 0, qtd_malas = 0;;
	for (int i = 0; i < (LIN / 2); i++)
	{
		for (int j = 0; j < COL; j++)
		{
			peso = aviao[i][j];
			if (peso != 0)
			{
				acumulado += peso;
				qtd_malas++;
			}
		}
	}
	float media_lado1 = (float)acumulado / qtd_malas;

	// Calcular média do lado 2
	acumulado = 0, qtd_malas = 0;
	for (int i = 2; i < LIN; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			peso = aviao[i][j];
			if (peso != 0)
			{
				acumulado += peso;
				qtd_malas++;
			}
		}
	}
	float media_lado2 = (float)acumulado / qtd_malas;

	// Imprimir médias
	printf("Lado 1 = %2.1f quilos\n", media_lado1);
	printf("Lado 2 = %2.1f quilos\n", media_lado2);
	
	// Ler valor de peso do usuário
	int entrada;
	printf("Entre com um valor de peso: ");
	scanf("%d", &entrada);

	// Para cada mala
	for (int i = 0; i < LIN; i++)
	{
		for (int j = 0; j < COL; j++)
		{
			// Se peso for maior que a entrada
			peso = aviao[i][j];
			if (peso > entrada)
			{
				// Imprimir linha, coluna e peso
				printf("%2d %2d %2d\n", i, j, peso);
			}
		}
	}
}
