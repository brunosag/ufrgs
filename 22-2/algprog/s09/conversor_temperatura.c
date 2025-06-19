// Bruno Samuel Ardenghi Gonçalves
// 09/02/2023
// Exibe um menu ao usuário e dá a opção de converter graus celsius para fahrenheit ou vice-versa

#include <stdio.h>

int menu(void);
float f_to_c(void);
float c_to_f(void);

int main(void)
{
    int opcao = 0;
    while (opcao != 3)
    {
        opcao = menu();
        if (opcao == 1)
        {
            float temp_f = c_to_f();
            printf("Temperatura equivalente em fahrenheit: %.2f\n", temp_f);
        }
        else if (opcao == 2)
        {
            float temp_c = f_to_c();
            printf("Temperatura equivalente em celsius: %.2f\n", temp_c);
        }
    }
}

int menu(void)
{
    // Apresentar o menu, ler e retornar opção do usuário
    int opcao = 0;
    printf("Entre com uma das opções:\n");
    printf("1 – Converte centígrados para fahrenheit:\n");
    printf("2 – Converte fahrenheit para centígrados:\n");
    printf("3 - Sair\n");
    printf("Opção: ");
    scanf("%d", &opcao);
    return opcao;
}

float f_to_c(void)
{
    // Ler uma temperatura em fahrenheit e converter para centigrados
    float temp_f = 0;
    printf("Entre com a temperatura em graus fahrenheit: ");
    scanf("%f", &temp_f);
    float temp_c = (temp_f - 32) / 1.8;
    return temp_c;
}

float c_to_f(void)
{
    // Ler uma temperatura em celsius e converter para fahrenheit
    float temp_c = 0;
    printf("Entre com a temperatura em graus celsius: ");
    scanf("%f", &temp_c);
    float temp_f = (temp_c * 1.8) + 32;
    return temp_f;
}
