#include "raylib.h"

typedef struct
{
    Vector2 position;
    Vector2 size;
    Color color;
} Player;

int main()
{
    // -------------------------------------------------------------------- //
    // Initialize                                                           //
    // -------------------------------------------------------------------- //
    const int screenWidth = 800;
    const int screenHeight = 450;
    const float playerMovement = 0.5;

    InitWindow(screenWidth, screenHeight, "Movimento do jogador");

    Player p;
    p.position = (Vector2){(screenWidth / 2 - 20), (screenHeight / 2 - 20)};
    p.size = (Vector2){40, 40};
    p.color = MAGENTA;

    while (!WindowShouldClose())
    {
        // -------------------------------------------------------------------- //
        // Update                                                               //
        // -------------------------------------------------------------------- //
        if (IsKeyDown(KEY_UP) && p.position.y > 0)
        {
            p.position.y -= playerMovement;
        }
        if (IsKeyDown(KEY_DOWN) && (p.position.y + p.size.y) < screenHeight)
        {
            p.position.y += playerMovement;
        }
        if (IsKeyDown(KEY_LEFT) && p.position.x > 0)
        {
            p.position.x -= playerMovement;
        }
        if (IsKeyDown(KEY_RIGHT) && (p.position.x + p.size.x) < screenWidth)
        {
            p.position.x += playerMovement;
        }

        // -------------------------------------------------------------------- //
        // Draw                                                                 //
        // -------------------------------------------------------------------- //
        BeginDrawing();

        ClearBackground(RAYWHITE);

        DrawRectangleV(p.position, p.size, p.color);

        DrawText("Mova o jogador com as setinhas do teclado", 10, 10, 20, DARKGRAY);

        EndDrawing();
    }

    CloseWindow();
    return 0;
}
