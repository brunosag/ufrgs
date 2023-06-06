#include "tad.h"
#include <stdio.h>
#include <stdbool.h>

void exibir_mensagem_boas_vindas()
{
    printf("*************************************************************************************\n");
    printf("*                       Bem-vindo ao Sistema de Gerenciamento                       *\n");
    printf("*                                de Sócios do Clube                                 *\n");
    printf("*************************************************************************************\n");
    printf("Por favor, insira os dados do novo sócio:\n");
}

bool cadastrar_outro_socio()
{
    char opcao;
    printf("\nDeseja cadastrar outro sócio? (S/N): ");
    scanf(" %c", &opcao);

    while (getchar() != '\n')
        continue;

    return (opcao == 'S' || opcao == 's');
}

int main()
{
    clube_t clube;
    clube.qtd_socios = 0;

    exibir_mensagem_boas_vindas();

    do
    {
        socio_t novo_socio;
        atribui_dados(&clube, &novo_socio);
    } while (cadastrar_outro_socio());

    printf("\n================================== ESTATÍSTICAS ===================================\n");
    calcula_estatisticas(clube);

    printf("\n================================= SÓCIOS NOTA 10 ==================================\n");
    socio_nota_10(clube);

    return 0;
}