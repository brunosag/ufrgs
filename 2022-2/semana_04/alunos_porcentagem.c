// Bruno Samuel Ardenghi Gonçalves
// 15/12/2022
// Calcula a porcentagem de alunos do gênero feminino e que prestaram vestibular mais de 3 vezes em um número de entradas

#include <stdio.h>

int main(void)
{
    // Ler número total de alunos
    int alunos;
    printf("Entre com o numero total de alunos: ");
    scanf("%d", &alunos);

    // Para cada aluno
    char genero;
    int vest;
    float contador_fem = 0, contador_vest = 0;
    for (int i = 0; i < alunos; i++)
    {
        // Ler gênero do aluno e contar se feminino
        printf("Entre com o genero do aluno: ");
        scanf(" %c", &genero);
        if (genero == 'f') {
            contador_fem++;
        }

        // Ler quantidade de vestibulares e contar se maior que 3
        printf("Entre com o nro de vezes que fez vestibular: ");
        scanf("%d", &vest);
        if (vest >= 3) {
            contador_vest++;
        }
    }

    // Calcular e imprimir percentuais
    printf("Percentual alunos genero feminino: %.2f\n", contador_fem / alunos * 100);
    printf("Percentual alunos vestibular 3 vezes ou mais: %.2f\n", contador_vest / alunos * 100);
}
