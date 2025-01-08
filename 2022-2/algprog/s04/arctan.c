// Bruno Samuel Ardenghi Gonçalves
// 15/12/2022
// Calcula o arco tangente de um valor real x através de uma série de potências

#include <stdio.h>
#include <math.h>

int main(void)
{
    // Ler valor de x
    float x;
    printf("Entre com o valor de x para calcular arctan(x): ");
    scanf("%f", &x);

    // Verificar se x está no intervalo válido
    if (x <= -1 || x >= 1) {
        printf("Valor invalido");
    }
    else {
        // Ler número de termos da soma
        int n_termos;
        printf("Entre com o numero de termos: ");
        scanf("%d", &n_termos);

        // Calcular valor aproximado em radianos
        float termo, arctan = 0;
        int exp = 1;
        for (int i = 0; i < n_termos; i++) {
            termo = pow(x, exp) / exp;
            if (i % 2 == 0) {
                arctan += termo;
            }
            else {
                arctan -= termo;
            }
            exp += 2;
        }

        // Imprimir resultado
        printf("Angulo em radianos = %f\n", arctan);
        printf("Angulo em graus = %f", arctan * 180 / M_PI);
    }
}
