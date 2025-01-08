// Bruno Samuel Ardenghi Gonçalves
// 16/03/2023
// Registra um número de alunos e suas informações em um arquivo binário e faz
// consultas relacionadas a média

#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#define MAX_NOME 30

typedef struct aluno
{
    char nome[MAX_NOME];
    int idade;
    int media;
} aluno_t;

int main(void)
{
    // Ler nome do arquivo
    char nome_arquivo[MAX_NOME];
    printf("Entre com o nome do arquivo: ");
    scanf("%s", &nome_arquivo);

    // Abrir arquivo de alunos
    FILE *arquivo = fopen(nome_arquivo, "w+b");

    // Ler alunos até parada ser solicitada
    aluno_t aluno;
    bool para_leitura = false;
    while (!para_leitura)
    {
        // Ler nome do aluno
        printf("Nome: ");
        scanf("%s", &aluno.nome);

        // Verificar parada
        if (strcmp(aluno.nome, "sair") != 0)
        {
            // Ler informações do aluno
            printf("Idade: ");
            scanf("%d", &aluno.idade);
            printf("Media: ");
            scanf("%d", &aluno.media);

            // Registrar informações no arquivo
            fwrite(&aluno, sizeof(aluno_t), 1, arquivo);
        }
        else
            para_leitura = true;

        printf("\n");
    }

    // Ler média para busca
    int media_busca;
    printf("Entre com a media para busca: ");
    scanf("%d", &media_busca);

    // Ler média de cada aluno
    float idade_media = 0;
    int n_alunos = 0;
    printf("Lista todos alunos com media maior ou igual a %d:\n", media_busca);
    rewind(arquivo);
    while (!feof(arquivo))
    {
        if (fread(&aluno, sizeof(aluno_t), 1, arquivo))
        {
            // Verificar média maior ou igual à buscada
            if (aluno.media >= media_busca)
                printf("Aluno: %s; Media: %d\n", aluno.nome, aluno.media);

            // Somar idade à idade média
            idade_media += aluno.idade;
            n_alunos++;
        }
    }

    // Calcular e imprimir média geral
    idade_media /= n_alunos;
    printf("Idade media de todos os alunos: %.2f\n", idade_media);

    // Fechar arquivo de alunos
    fclose(arquivo);
}
