#ifndef AVL_H
#define AVL_H

#include "main.h"

// Node structure for AVL Tree
typedef struct AVLNode
{
    int key;
    struct AVLNode *left;
    struct AVLNode *right;
    int height;
    int size;
} AVLNode;

// AVL Tree ADT
typedef struct AVLTree
{
    AVLNode *root;
} AVLTree;

struct AVLTree *createAVLTree(); // Core ADT Functions
void destroyAVLTree(struct AVLTree *tree);
void insertAVL(struct AVLTree *tree, int key);
void printAVL(struct AVLTree *tree);

int findMinAVL(struct AVLTree *tree); // Statistical Functions
int findMaxAVL(struct AVLTree *tree);
double calculateAverageAVL(struct AVLTree *tree);
KeyFrequency *findXMostFrequentAVL(AVLTree *tree, int X, int dataSize);

void insertDataAVL(AVLTree *tree, int *dataset, int dataSize); // Data Management Functions

#endif /* AVL_H */
