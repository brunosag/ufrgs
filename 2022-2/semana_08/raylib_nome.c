#include "raylib.h"
#define MAX_INPUT_CHARS 9

int main(void)
{
    // -------------------------------------------------------------------- //
    // Initialize                                                           //
    // -------------------------------------------------------------------- //
    const int screenWidth = 800;
    const int screenHeight = 450;
    InitWindow(screenWidth, screenHeight, "Nome do jogador");

    char name[MAX_INPUT_CHARS + 1] = "\0";
    int letterCount = 0;

    Rectangle textBox = {(screenWidth / 2 - 140), 180, 280, 50};

    SetTargetFPS(60);

    while (!WindowShouldClose())
    {
        // -------------------------------------------------------------------- //
        // Update                                                               //
        // -------------------------------------------------------------------- //
        int key = GetCharPressed();
        while (key)
        {
            if ((key >= 32) && (key <= 125) && (letterCount < MAX_INPUT_CHARS))
            {
                name[letterCount] = (char)key;
                name[letterCount + 1] = '\0';
                letterCount++;
            }
            key = GetCharPressed();
        }

        if (IsKeyPressed(KEY_BACKSPACE))
        {
            if (letterCount > 0)
            {
                letterCount--;
                name[letterCount] = '\0';
            }
        }

        // -------------------------------------------------------------------- //
        // Draw                                                                 //
        // -------------------------------------------------------------------- //
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawText("Digite o seu nome com 9 caracteres:", 210, 140, 20, GRAY);

        DrawRectangleRec(textBox, LIGHTGRAY);
        DrawRectangleLines((int)textBox.x, (int)textBox.y, (int)textBox.width, (int)textBox.height, RED);

        DrawText(name, ((int)textBox.x + 8), ((int)textBox.y + 8), 40, MAROON);

        DrawText(TextFormat("NUM DE CHARS: %i/%i", letterCount, MAX_INPUT_CHARS), 300, 250, 20, DARKGRAY);

        DrawText("Pressione BACKSPACE para deletar chars...", 180, 300, 20, GRAY);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}
