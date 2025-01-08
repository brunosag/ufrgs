// Bruno Samuel Ardenghi Gonçalves
// 01/12/2022
// Lê um o raio de um círculo e calcula o perímetro e área do seu maior quadrado inscrito.

#include <stdio.h>

int main()
{
    // Ler número inteiro do usuário
    int segundos;
    printf("Entre com o total de segundos: ");
    scanf("%d", &segundos);

    // Calcular dias e retirar do total
    int dias = segundos / (60 * 60 * 24);
    segundos = segundos - dias * (60 * 60 * 24);

    // Com a sobra, calcular horas e retirar do total
    int horas = segundos / (60 * 60);
    segundos = segundos - horas * (60 * 60);

    // Com a sobra, calcular minutos e retirar do total
    int minutos = segundos / 60;
    segundos = segundos - minutos * 60;

    printf("%d Dia(s) %d hora(s) %d min(s) %d sec(s)", dias, horas, minutos, segundos);
}
