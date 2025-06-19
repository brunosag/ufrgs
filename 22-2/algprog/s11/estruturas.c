// Bruno Samuel Ardenghi Gonçalves
// 09/03/2023
// Faz cadastros e buscas em uma lista de carros com informações fornecidas pelo usuário.

#include <stdio.h>
#include <stdbool.h>
#define MAX_CARROS 3
#define MAX_STRING 45

typedef struct carro{
    int cod;
    char modelo[MAX_STRING];
    char marca[MAX_STRING];
    float preco;
    int ano;
} CARRO;

int menu(void);
void cadastraCarro(CARRO *c);
void print_carro(CARRO c);
float calcMediaPreco(CARRO carros[], int ncarros);
CARRO procuraCarro(CARRO carros[], int ncarros, int cod);

int main(void)
{
    // Inicializar vetor e contador de carros
    CARRO carros[MAX_CARROS] = {0};
    int ncarros = 0;

    // Exibir opções ao usuário
    int opcao = 0;
    while (opcao != 5)
    {
        CARRO c;
        int cod;
        float preco_medio;

        opcao = menu();

        // Lidar com opções
        switch(opcao)
        {
        case 1:
            // Cadastro de carro
            if (ncarros < MAX_CARROS)
            {
                cadastraCarro(&carros[ncarros]);
                ncarros++;
            }
            else {
                printf("Numero maximo de cadastros atingido.\n\n");
            }
            break;

        case 2:
            // Consulta de carro
            printf("Insira o codigo do carro: ");
            scanf("%d", &cod);
            c = procuraCarro(carros, ncarros, cod);
            if (c.cod != -1)
            {
                print_carro(c);
            }
            else
            {
                printf("Carro nao existe!\n");
            }
            printf("\n");
            break;
        case 3:
            // Preco médio dos carros
            preco_medio = calcMediaPreco(carros, ncarros);
            printf("O preco medio dos carros eh %.2f\n\n", preco_medio);
            break;

        case 4:
            // Imprime estoque revenda
            if (ncarros)
            {
                for (int i = 0; i < ncarros; i++)
                {
                    print_carro(carros[i]);
                }
            }
            else
            {
                printf("\n");
            }
            break;
    }
}

int menu(void)
{
    int opcao = 0;
    printf("1. Cadastro de carro\n");
    printf("2. Consulta de carro\n");
    printf("3. Preco medio dos carros\n");
    printf("4. Imprime estoque revenda\n");
    printf("5. Fim\n");

    while (opcao < 1 || opcao > 5)
    {
        printf("Entre com sua opcao: ");
        scanf("%d", &opcao);
    }

    return opcao;
}

void cadastraCarro(CARRO *c)
{
    printf("Codigo: ");
    scanf("%d", &(c->cod));
    printf("Marca: ");
    scanf("%s", &(c->marca));
    printf("Modelo: ");
    scanf("%s", &(c->modelo));
    printf("Preco: ");
    scanf("%f", &(c->preco));
    printf("Ano: ");
    scanf("%d", &(c->ano));
    printf("\n");
}

void print_carro(CARRO c)
{
    printf("Codigo: %d\n", c.cod);
    printf("Marca: %s\n", c.marca);
    printf("Modelo: %s\n", c.modelo);
    printf("Preco: %.2f\n", c.preco);
    printf("Ano: %d\n", c.ano);
}

float calcMediaPreco(CARRO carros[], int ncarros)
{
    float media = 0;
    for (int i = 0; i < ncarros; i++)
    {
        media += carros[i].preco;
    }
    media /= ncarros;
    return media;
}

CARRO procuraCarro(CARRO carros[], int ncarros, int cod)
{
    CARRO carro = {0};
    bool encontrado = false;
    for (int i = 0; i < ncarros && !encontrado; i++)
    {
        if (cod == carros[i].cod)
        {
            encontrado = true;
            carro = carros[i];
        }
    }
    if (!encontrado)
    {
        carro.cod = -1;
    }
    return carro;
}
