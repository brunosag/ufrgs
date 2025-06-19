#include <stdio.h>
#include <string.h>

int main(void)
{
    // Ler jogadas do usuário
    char j1, j2;
    printf("Entre com suas jogadas: ");
    scanf("%c %c", &j1, &j2);

    //  Verificar empate
    if (j1 == j2) {
        printf("EMPATE!");
        return 0;
    }

    // Determinar e exibir vencedor
    char jogadas[3] = {j1, j2};
    if (strcmp(jogadas, "pr") == 0 || strcmp(jogadas, "rp") == 0) {
        if (j1 == 'p') {
            printf("Papel cobre pedra! O jogador 1 venceu.");
        }
        else {
            printf("Papel cobre pedra! O jogador 2 venceu.");
        }
    }
    else if (strcmp(jogadas, "rt") == 0 || strcmp(jogadas, "tr") == 0) {
        if (j1 == 'r') {
            printf("Pedra quebra tesoura! O jogador 1 venceu.");
        }
        else {
            printf("Pedra quebra tesoura! O jogador 2 venceu.");
        }
    }
    else {
        if (j1 == 't') {
            printf("Tesoura corta papel! O jogador 1 venceu.");
        }
        else {
            printf("Tesoura corta papel! O jogador 2 venceu.");
        }
    }
}
