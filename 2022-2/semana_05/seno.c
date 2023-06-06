// Bruno Samuel Ardenghi Gonçalves
// 22/12/2022
// Calcula o valor aproximado do seno de um ângulo utilizando uma série de termos

#include <stdio.h>
#include <math.h>

int main(void)
{
    // Ler valores do usuário
    float angulo;
    float erro;
    printf("Entre com o valor do angulo em graus: ");
    scanf("%f", &angulo);
    printf("Entre com o valor do erro: ");
    scanf("%f", &erro);

    // Converter ângulo para radianos
    angulo *= M_PI / 180;

    // Enquanto valor absoluto do termo for inferior ao erro
    float termo = 0, seno = 0;
    int j, i = 0, exp = 1, fatorial = 1, flag = 1;
    while (flag)
    {
        // Calcular fatorial
        fatorial = 1;
        for (j = 1; j <= exp; j++) {
            fatorial *= j;
        }

        // Calcular termo
        termo = pow(angulo, exp) / fatorial;

        if (termo > erro)
        {
            // Adicionar ou subtrair termo do resultado
            if (i % 2 == 0)
                seno += termo;
            else
                seno -= termo;

            exp += 2;
            i++;
        }
        else
        {
            // Parar repetição
            flag = 0;
        }
    }

    // Imprimir resultado
    printf("Valor aproximado do seno: %f", seno);
}
