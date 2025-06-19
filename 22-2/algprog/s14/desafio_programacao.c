/*
    Introdução à Engenharia de Computação - 2022/2
    Prof. Renato Ventura
    Desafio de Programação
    Bruno Samuel Ardenghi Gonçalves - 550402
*/

#include <stdio.h>
#include <stdlib.h>
#define MIN 1
#define MAX 3

void gerar_simulacao(int n)
{
    FILE *arquivo = fopen("simulacao.txt", "w");
    fprintf(arquivo, "%d\n", n);
    int aleatorio;
    srand(0);
    for (int i = 0; i < n; i++)
    {
        aleatorio = MIN + (rand() % (MAX - MIN + 1));
        fprintf(arquivo, "%d\n", aleatorio);
    }
    fclose(arquivo);
}

int main(void)
{
    int portas[3] = {0};

    // Ler número de simulações
    int n_simulacoes = 0;
    do
    {
        printf("Entre com o numero de simulacoes [1, 104]: ");
        scanf("%d", &n_simulacoes);
    } while (n_simulacoes < 1 || n_simulacoes > 104);

    // Criar e abrir arquivo de simulação
    gerar_simulacao(n_simulacoes);
    FILE *arquivo = fopen("simulacao.txt", "r");
    int carro;

    // Pular primeira linha
    fscanf(arquivo, "%d", &carro);

    // Para cada simulação
    int n_vitorias = 0;
    int escolha_jogador, escolha_apresentador;
    srand(0);
    for (int i = 0; i < n_simulacoes; i++)
    {
        escolha_jogador = 1;

        // Esvaziar portas
        for (int j = 0; j < MAX; j++)
            portas[j] = 0;

        // Preencher porta do carro
        fscanf(arquivo, "%d", &carro);
        portas[carro - 1] = 1;

        // Gerar escolha do apresentador
        for (int j = 1; j < MAX + 1; j++)
        {
            if (j != escolha_apresentador && j != carro)
                escolha_apresentador = j;
        }

        // Trocar escolha do jogador
        for (int j = 1; j < MAX + 1; j++)
        {
            if (j != escolha_jogador && j != escolha_apresentador)
                escolha_jogador = j;
        }

        // Se escolha do jogador for carro
        if (escolha_jogador == carro)
            n_vitorias++;
    }
    fclose(arquivo);

    // Imprimir número de vitórias
    printf("O jogador ganhou %d das %d simulacoes.", n_vitorias, n_simulacoes);
}
