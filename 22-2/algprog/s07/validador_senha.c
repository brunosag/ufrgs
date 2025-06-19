#include <stdio.h>
#include <string.h>
#define TAM 64
#define N 5
#define TRUE 1
#define FALSE 0

int main(void)
{
	int regra_a = FALSE, regra_b = FALSE;

	// Ler senha do usuário
	char senha[TAM];
	printf("Entre com a senha: ");
	fgets(senha, TAM, stdin);
	senha[strlen(senha) - 1] = '\0';

	// Se primeira letra for permitida, aprovar regra A
	if (senha[0] >= 97 && senha[0] <= 122)
	{
		regra_a = TRUE;
	}

	if (regra_a)
	{
		char especiais[N] = {'!', '#', '$', '%', '&'};

		// Para cada caractere da senha
		int i = 0, senha_len = strlen(senha);
		while(!regra_b && i < senha_len)
		{
			// Para cada caractere especial
			int j = 0;
			while(!regra_b && j < N)
			{
				// Se caracteres forem iguais, aprovar regra B
				if ((int)senha[i] == (int)especiais[j])
				{
					regra_b = TRUE;
				}
				else
				{
					j++;
				}
			}
			i++;
		}
	}

	// Aprovar senha caso ambas regras forem aprovadas
	if (regra_a && regra_b)
	{
		printf("APROVADA\n");
	}
	else
	{
		printf("REPROVADA\n");
	}
}
