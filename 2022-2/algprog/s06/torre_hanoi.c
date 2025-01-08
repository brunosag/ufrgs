// Bruno Samuel Ardenghi Gonçalves
// 22/01/2023
// Descreve a menor sequência de passos possível para solucionar a Torre de Hanói dado um número n de discos

#include <stdio.h>

void torre_hanoi(int n, char src, char dest, char aux)
{
    if (n == 0)
        return;
    torre_hanoi(n - 1, src, aux, dest);
    printf("Mova o disco %d do pino %c para o pino %c\n", n, src, dest);
    torre_hanoi(n - 1, aux, dest, src);
}

int main(void)
{
    // Ler número de discos, pino origem e pino destino
    int n;
    char src, dest, aux;
    printf("Informe o numero de discos: ");
    scanf(" %d", &n);
    printf("Informe o pino origem (A, B ou C): ");
    scanf(" %c", &src);
    printf("Informe o pino destino (A, B ou C): ");
    scanf(" %c", &dest);

    // Atribuir pino restante ao pino auxiliar
    for (int i = 0; i < 3; i++)
    {
        char c = 'A' + i;
        if (c != src && c != dest)
            aux = c;
    }

    // Imprimir passos
    printf("\nPASSOS:\n");
    torre_hanoi(n, src, dest, aux);
}
