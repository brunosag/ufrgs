#include <stdio.h>
#include <time.h>
#include <locale.h>

int main(void) {
    setlocale(LC_ALL, "");

    // Ler ano de nascimento do usu�rio
    int ano_nascimento;
    printf("Entre com o ano de seu nascimento: ");
    scanf("%d", &ano_nascimento);

    // Obter ano atual
    time_t segundos = time(NULL);
    struct tm* data_atual = localtime(&segundos);
    int ano_atual = (data_atual->tm_year + 1900);

    // Calcular e exibir idade
    int idade = ano_atual - ano_nascimento;
    printf("Voc� tem %d anos.", idade);
}
