#include <stdio.h>
#include <math.h>
#define TRUE 1
#define FALSE 0

int main(void)
{
	int i = 0, termo_valido = TRUE;
	float resultado = 0, termo = 0;

	while (termo_valido)
	{
		// Calcular termo
		termo = 1 / (1 + ((float)i * 4));

		// Se iterador ímpar, trocar sinal
		if (i % 2 != 0)
		{
			termo *= -1;
		}

		// Se valor absoluto do termo for maior que limite
		if (fabs(termo) > 0.0001)
		{
			// Adicionar termo ao resultado
			resultado += termo;
			i++;
		}
		else
		{
			termo_valido = FALSE;
		}
	}

	// Imprimir resultado
	printf("S = %f\n", resultado);
}
