#ifndef MAIN_H
#define MAIN_H

// Structure to store key-frequency pairs
typedef struct
{
    int key;
    int frequency;
} KeyFrequency;

void compare();
void printMostFrequent(KeyFrequency *result, int X);

#endif /* MAIN_H */
