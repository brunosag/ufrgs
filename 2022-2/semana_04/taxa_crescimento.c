// Bruno Samuel Ardenghi Gonçalves
// 15/12/2022
// Calcula o número de anos que levará para o Brasil ultrapassar os EUA em habitantes dado determinadas taxas de crescimento

#include <stdio.h>

int main(void)
{
    // Declarar populações e taxas de crescimento
    float br = 214000000, eua = 332000000;
    float taxa_br = 1.34, taxa_eua = 1.09;

    // Para cada ano que passa, até Brasil ultrapassar EUA
    int i;
    for (i = 0; eua > br; i++)
    {
        // Calcular novas populações
        br *= 1 + (taxa_br / 100);
        eua *= 1 + (taxa_eua / 100);

        // Calcular nova taxa dos EUA
        if ((taxa_eua - 0.1) > 0) {
            taxa_eua -= 0.1;
        }
        else {
            taxa_eua = 0;
        }
    }

    // Imprimir anos decorridos
    printf("%d anos", i);
}
