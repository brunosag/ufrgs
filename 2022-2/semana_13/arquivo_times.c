// Bruno Samuel Ardenghi Gonçalves
// 23/03/2023
// Lê informações de clubes de um arquivo texto, calcula as pontuações e transfere para um arquivo
// de saída.

#include <stdio.h>
#include <stdlib.h>
#define MAX_CLUBES 100

typedef struct
{
    char nome[30];
    int vit, emp, der;
    int pontos;
    float publico;
} CLUBE;

int le_arquivo_times(FILE *fp_in, CLUBE c[]);
void escreve_arquivo_saida(CLUBE c[], int nc, FILE *fp_out);

int main(void)
{
    // Ler arquivo de entrada
    CLUBE clubes[MAX_CLUBES];
    FILE *fp_in = fopen("brasileiro.txt", "r");
    int n_clubes = le_arquivo_times(fp_in, clubes);
    fclose(fp_in);

    // Escrever arquivo de saída
    FILE *fp_out = fopen("pontuacao.txt", "w+");
    escreve_arquivo_saida(clubes, n_clubes, fp_out);
    fclose(fp_out);
}

int le_arquivo_times(FILE *fp_in, CLUBE c[])
{
    CLUBE clube;
    int n_clubes = 0;
    while (!feof(fp_in))
    {
        // Ler e armazenar informações do clube
        fscanf(fp_in, "%s", clube.nome);
        fscanf(fp_in, "%d", &clube.vit);
        fscanf(fp_in, "%d", &clube.emp);
        fscanf(fp_in, "%d", &clube.der);
        fscanf(fp_in, "%f", &clube.publico);

        // Calcular e armazenar pontos
        clube.pontos = (clube.vit * 3) + clube.emp;

        // Adicionar clube ao arranjo de clubes
        c[n_clubes] = clube;
        n_clubes++;
    }
    return n_clubes;
}

void escreve_arquivo_saida(CLUBE c[], int nc, FILE *fp_out)
{
    // Escrever número de clubes lidos
    fprintf(fp_out, "%d\n", nc);

    // Escrever informações de cada clube
    float aproveitamento;
    for (int i = 0; i < nc; i++)
    {
        aproveitamento = (float)c[i].pontos / ((c[i].vit + c[i].emp + c[i].der) * 3) * 100;
        fprintf(fp_out, "%s, %d pontos, aproveitamento de %.2f%%.\n", c[i].nome, c[i].pontos,
                aproveitamento);
    }
}
