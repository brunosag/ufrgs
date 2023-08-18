#define NOME_MAX 50
#define SOCIOS_MAX 100

typedef enum
{
    Fundamental = 1,
    Secundario,
    Superior
} grau_instrucao_t;

typedef enum
{
    Manha = 1,
    Tarde,
    Noite
} turno_t;

typedef enum
{
    Natacao = 1,
    Hidroginastica,
    Danca,
    KungFu,
    Futebol,
    Volei
} atividade_t;

typedef struct socio
{
    int matricula;
    char nome[NOME_MAX];
    int idade;
    int grau_instrucao;
    int turno;
    int atividade;
    float frequencia;
} socio_t;

typedef struct clube
{
    int qtd_socios;
    socio_t socios[SOCIOS_MAX];
} clube_t;

void atribui_dados(clube_t *clube, socio_t *socio);
void calcula_estatisticas(clube_t clube);
void socio_nota_10(clube_t clube);
