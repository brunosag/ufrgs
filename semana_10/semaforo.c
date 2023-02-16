#include <conio.h>
#include <stdio.h>
#include <windows.h>
#define N_VIAS 4
#define N_PEDS 8
#define TEMPO 3000
#define TRUE 1
#define FALSE 0
#define ON 1
#define OFF 0

// ENTRADAS
int veiculo[N_VIAS] = {0};
int pedestre[N_PEDS] = {0};

// SAÍDAS
int semaforo[N_VIAS] = {0};
int sinalizador[N_PEDS] = {0};

void ligar_semaforo(int via);
void ligar_sinalizador(int via);
void atender_veiculo(int via);
void atender_pedestre(int via);
void registrar_entrada(char c);
void imprimir_dados(void);

int main(void) {
    while (TRUE) {

        // Ler e registrar entradas do teclado
        char entrada = '\0';
        while (kbhit()) {
            entrada = getch();
            registrar_entrada(entrada);
        }

        int vazio = TRUE;
        for (int via = 0; via < N_VIAS; via++) {

            // Verificar pedestres na via
            if (pedestre[2 * via] == TRUE || pedestre[2 * via + 1] == TRUE) {
                vazio = FALSE;
                atender_pedestre(via);
            }

            // Verificar veículos na via
            if (veiculo[via] == TRUE) {
                vazio = FALSE;
                atender_veiculo(via);
            }
        }
        if (vazio && semaforo[0] == OFF) {

            // Ligar semáforo padrão
            ligar_semaforo(0);
        }
    }
}

void ligar_semaforo(int via) {

    // Desligar todos os semáforos
    for (int via = 0; via < N_VIAS; via++) {
        semaforo[via] = OFF;
        sinalizador[2 * via] = ON;
        sinalizador[2 * via + 1] = ON;
    }

    // Ligar semáforo da via
    semaforo[via] = ON;
    sinalizador[2 * via] = OFF;
    sinalizador[2 * via + 1] = OFF;

    imprimir_dados();
}

void ligar_sinalizador(int via) {

    // Desligar semáforo da via
    semaforo[via] = OFF;

    // Ligar sinalizadores da via
    sinalizador[2 * via] = ON;
    sinalizador[2 * via + 1] = ON;

    imprimir_dados();
}

void atender_veiculo(int via) {
    if (semaforo[via] == OFF) {
        ligar_semaforo(via);
    }
    Sleep(TEMPO);
    veiculo[via] = FALSE;
}

void atender_pedestre(int via) {
    if (semaforo[via] == ON) {
        ligar_sinalizador(via);
    }
    Sleep(TEMPO);
    pedestre[2 * via] = FALSE;
    pedestre[2 * via + 1] = FALSE;
}

void registrar_entrada(char c) {

    // Registrar pedestre
    if (c >= '1' && c <= '8') {
        pedestre[(int)c - 49] = TRUE;
    }

    // Registrar veículo
    else {
        switch (c) {
        case 'n':
            veiculo[0] = TRUE;
            break;
        case 'l':
            veiculo[1] = TRUE;
            break;
        case 's':
            veiculo[2] = TRUE;
            break;
        case 'o':
            veiculo[3] = TRUE;
            break;
        }
    }
}

void imprimir_dados(void) {
    printf("VEICULOS:");
    for (int i = 0; i < N_VIAS; i++) {
        printf(" %d", veiculo[i]);
    }
    printf("\n");

    printf("PEDESTRES:");
    for (int i = 0; i < N_PEDS; i++) {
        printf(" %d", pedestre[i]);
    }
    printf("\n");

    printf("SEMAFOROS:");
    for (int i = 0; i < N_VIAS; i++) {
        printf(" %d", semaforo[i]);
    }
    printf("\n");

    printf("SINALIZADORES:");
    for (int i = 0; i < N_PEDS; i++) {
        printf(" %d", sinalizador[i]);
    }
    printf("\n\n");
}
