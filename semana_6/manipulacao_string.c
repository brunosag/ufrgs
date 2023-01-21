#include <stdio.h>
#include <ctype.h>
#include <string.h>
#define MAX_LEN 25

int main(void)
{
    // Ler string do usuário
    char s[MAX_LEN];
    printf("Entre com uma string: ");
    fgets(s, MAX_LEN, stdin);
    int s_len = strlen(s);
    s[s_len - 1] = NULL;
    s_len--;

    // Transformar letras em maiúsculas e imprimir
    printf("String todo maiusculo: ");
    for (int i = 0; i < s_len; i++)
    {
        printf("%c", toupper(s[i]));
    }
    printf("\n");

    // Inverter string e imprimir
    printf("String invertido: ");
    for (int i = s_len - 1; i >= 0; i--)
    {
        printf("%c", s[i]);
    }
}
