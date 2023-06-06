#include "tad.h"
#include <stdio.h>
#include <string.h>

void atribui_dados(clube_t *clube, socio_t *socio)
{
    /* Função para atribuir os dados de um sócio */

    printf("Nome: ");
    fgets(socio->nome, NOME_MAX, stdin);
    socio->nome[strcspn(socio->nome, "\n")] = '\0';

    printf("Idade: ");
    scanf("%d", &socio->idade);

    printf("Grau de Instrução (1-Fundamental, 2-Secundário, 3-Superior): ");
    scanf("%d", &socio->grau_instrucao);

    printf("Turno (1-Manhã, 2-Tarde, 3-Noite): ");
    scanf("%d", &socio->turno);

    printf("Atividade (1-Natação, 2-Hidroginástica, 3-Dança, 4-Kung Fu, 5-Futebol, 6-Vôlei): ");
    scanf("%d", &socio->atividade);

    printf("Frequência (%%): ");
    scanf("%f", &socio->frequencia);

    clube->socios[clube->qtd_socios] = *socio;
    clube->qtd_socios++;
}

void calcula_estatisticas(clube_t clube)
{
    /* Função para calcular estatísticas dos sócios */

    // Total de sócios por turno
    int qtd_turno[3] = {0};
    for (int i = 0; i < clube.qtd_socios; i++)
    {
        int turno = clube.socios[i].turno;
        qtd_turno[turno - 1]++;
    }
    printf("Total de sócios:\n- Manhã: %d\n- Tarde: %d\n- Noite: %d\n", qtd_turno[0], qtd_turno[1], qtd_turno[2]);

    // Média de idade por grau
    int qtd_grau[3] = {0};
    int media_grau[3] = {0};
    for (int i = 0; i < clube.qtd_socios; i++)
    {
        int grau = clube.socios[i].grau_instrucao;
        media_grau[grau - 1] += clube.socios[i].idade;
        qtd_grau[grau - 1]++;
    }
    printf("Média de idade dos sócios:\n");
    if (qtd_grau[0] > 0)
        printf("- Fundamental: %d\n", (media_grau[0] / qtd_grau[0]));
    if (qtd_grau[1] > 0)
        printf("- Secundário: %d\n", (media_grau[1] / qtd_grau[1]));
    if (qtd_grau[2] > 0)
        printf("- Superior: %d\n", (media_grau[2] / qtd_grau[2]));

    // Total de sócios que praticam natação
    int natacao = 0;
    for (int i = 0; i < clube.qtd_socios; i++)
    {
        if (clube.socios[i].atividade == Natacao)
            natacao++;
    }
    printf("Total de sócios que praticam natação: %d\n", natacao);

    // Sócio mais idoso que pratica Kung Fu
    int idade = 0;
    int idoso = -1;
    for (int i = 0; i < clube.qtd_socios; i++)
    {
        if (clube.socios[i].atividade == KungFu && clube.socios[i].idade > idade)
        {
            idade = clube.socios[i].idade;
            idoso = i;
        }
    }
    if (idoso >= 0)
        printf("Sócio mais idoso que pratica Kung Fu: %s\n", clube.socios[idoso].nome);
    else
        printf("Nenhum sócio pratica Kung Fu.\n");
}

void socio_nota_10(clube_t clube)
{
    /* Função para exibir os Sócios Nota 10 (com frequência igual ou superior a 70%) */

    for (int i = 0; i < clube.qtd_socios; i++)
    {
        if (clube.socios[i].frequencia >= 70)
            printf("- %s\n", clube.socios[i].nome);
    }
}
