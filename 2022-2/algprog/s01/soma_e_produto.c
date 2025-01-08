#include <stdio.h>
#include <locale.h>

int main(void) {
    setlocale(LC_ALL, "");

    // Ler 3 valores do usuário
    int val1, val2, val3;
    printf("Entre com o 1º valor: ");
    scanf("%d", &val1);
    printf("Entre com o 2º valor: : ");
    scanf("%d", &val2);
    printf("Entre com o 3º valor: : ");
    scanf("%d", &val3);

    // Calcular e exibir soma e produto
    int soma = val1 + val2 + val3;
    int produto = val1 * val2 * val3;
    printf("Resultado da soma: %d\n", soma);
    printf("Resultado do produto: %d\n", produto);
}
