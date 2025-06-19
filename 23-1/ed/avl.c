#include "avl.h"
#include <limits.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX_DATASIZE 1000000

// Function to create an empty AVL Tree
AVLTree *createAVLTree()
{
    AVLTree *tree = malloc(sizeof(AVLTree));
    tree->root = NULL;
    return tree;
}

// Helper function to free the memory occupied by the AVL nodes
void destroyAVLNodes(AVLNode *node)
{
    if (node != NULL)
    {
        destroyAVLNodes(node->left);
        destroyAVLNodes(node->right);
        free(node);
    }
}

// Function to destroy the AVL Tree and free memory
void destroyAVLTree(AVLTree *tree)
{
    destroyAVLNodes(tree->root);
    free(tree);
}

// Helper function to create a new AVL node
AVLNode *createAVLNode(int key)
{
    AVLNode *node = (AVLNode *)malloc(sizeof(AVLNode));
    node->key = key;
    node->left = NULL;
    node->right = NULL;
    node->height = 1;
    node->size = 1;
    return node;
}

// Helper function to update the height and size of a node
void updateNode(AVLNode *node)
{
    compare();
    int left_height = node->left ? node->left->height : 0;
    compare();
    int right_height = node->right ? node->right->height : 0;

    compare();
    node->height = 1 + (left_height > right_height ? left_height : right_height);
    compare();
    compare();
    node->size = 1 + (node->left ? node->left->size : 0) + (node->right ? node->right->size : 0);
}

// Helper function to perform a right rotation on the AVL Tree
AVLNode *rightRotateAVL(AVLNode *y)
{
    compare();
    if (y == NULL || y->left == NULL)
        return y;

    AVLNode *x = y->left;
    AVLNode *T2 = x->right;

    // Perform the rotation
    x->right = y;
    y->left = T2;

    // Update heights and sizes
    updateNode(y);
    updateNode(x);

    return x;
}

// Helper function to perform a left rotation on the AVL Tree
AVLNode *leftRotateAVL(AVLNode *x)
{
    compare();
    if (x == NULL || x->right == NULL)
        return x;

    AVLNode *y = x->right;
    AVLNode *T2 = y->left;

    // Perform the rotation
    y->left = x;
    x->right = T2;

    // Update heights and sizes
    updateNode(x);
    updateNode(y);

    return y;
}

// Helper function to insert a key into the AVL Tree
AVLNode *insertAVLNode(AVLNode *node, int key)
{
    compare();
    if (node == NULL)
        return createAVLNode(key);

    compare();
    if (key < node->key)
        node->left = insertAVLNode(node->left, key);
    else if (key > node->key)
        node->right = insertAVLNode(node->right, key);
    else
        return node;

    // Update height and size
    updateNode(node);

    // Calculate balance factor
    int balance = (node->left ? node->left->height : 0) - (node->right ? node->right->height : 0);

    // Left-Left case
    compare();
    if (balance > 1 && key < node->left->key)
        return rightRotateAVL(node);

    // Right-Right case
    compare();
    if (balance < -1 && key > node->right->key)
        return leftRotateAVL(node);

    // Left-Right case
    compare();
    if (balance > 1 && key > node->left->key)
    {
        node->left = leftRotateAVL(node->left);
        return rightRotateAVL(node);
    }

    // Right-Left case
    compare();
    if (balance < -1 && key < node->right->key)
    {
        node->right = rightRotateAVL(node->right);
        return leftRotateAVL(node);
    }

    return node;
}

// Function to insert a key into the AVL Tree
void insertAVL(AVLTree *tree, int key)
{
    tree->root = insertAVLNode(tree->root, key);
}

// Helper function to recursively print the AVL Tree
void printAVLNode(AVLNode *node)
{
    if (node != NULL)
    {
        printAVLNode(node->left);
        printf("%d ", node->key);
        printAVLNode(node->right);
    }
}

// Function to print the AVL Tree
void printAVL(AVLTree *tree)
{
    printAVLNode(tree->root);
    printf("\n");
}

// Function to find the minimum value in the AVL Tree
int findMinAVL(AVLTree *tree)
{
    AVLNode *current = tree->root;

    compare();
    if (current == NULL)
    {
        printf("Tree is empty.\n");
        return -1;
    }

    compare();
    while (current->left != NULL)
    {
        current = current->left;
        compare();
    }

    return current->key;
}

// Function to find the maximum value in the AVL Tree
int findMaxAVL(AVLTree *tree)
{
    AVLNode *current = tree->root;

    compare();
    if (current == NULL)
    {
        printf("Tree is empty.\n");
        return -1;
    }

    while (current->right != NULL)
    {
        current = current->right;
        compare();
    }

    return current->key;
}

// Helper function to recursively calculate the average value in the AVL Tree
double calculateAverageAVLNode(AVLNode *node, unsigned long long *sum, int *numNodes)
{
    compare();
    if (node == NULL)
        return 0.0;

    calculateAverageAVLNode(node->left, sum, numNodes);
    *sum += node->key;
    (*numNodes)++;
    calculateAverageAVLNode(node->right, sum, numNodes);

    return (double)(*sum) / (*numNodes);
}

// Function to calculate the average value in the AVL Tree
double calculateAverageAVL(AVLTree *tree)
{
    unsigned long long sum = 0;
    int numNodes = 0;

    return calculateAverageAVLNode(tree->root, &sum, &numNodes);
}

// Helper function to find the frequency of each key in the AVL Tree
void findKeyFrequenciesAVL(AVLNode *node, int dataSize, KeyFrequency *frequencies, int *arrSize)
{
    compare();
    if (node != NULL)
    {
        findKeyFrequenciesAVL(node->left, dataSize, frequencies, arrSize);

        bool keyFound = false;
        compare();
        compare();
        for (int i = 0; (i < *arrSize) && (!keyFound); i++)
        {
            compare();
            if (frequencies[i].key == node->key)
            {
                frequencies[i].frequency++;
                keyFound = true;
            }
            compare();
            compare();
        }
        compare();
        if (!keyFound)
        {
            KeyFrequency newKey = {node->key, 1};
            frequencies[*arrSize] = newKey;
            (*arrSize)++;
        }

        findKeyFrequenciesAVL(node->right, dataSize, frequencies, arrSize);
    }
}

// Function to find the X most frequent values in the AVL Tree
KeyFrequency *findXMostFrequentAVL(AVLTree *tree, int X, int dataSize)
{
    compare();
    if (tree == NULL || X <= 0)
    {
        return NULL;
    }

    KeyFrequency *frequencies = calloc(dataSize, sizeof(KeyFrequency));
    KeyFrequency *result = calloc(X, sizeof(KeyFrequency));
    int frequencies_size = 0;

    // Find the frequency of each key in the tree
    findKeyFrequenciesAVL(tree->root, dataSize, frequencies, &frequencies_size);

    // Find the X highest frequencies in the array
    compare();
    for (int i = 0; i < X; i++)
    {
        KeyFrequency most_frequent = {0, 0};
        int most_frequent_index = -1;
        compare();
        for (int j = 0; j < frequencies_size; j++)
        {
            compare();
            if (frequencies[j].frequency > most_frequent.frequency)
            {
                most_frequent = frequencies[j];
                most_frequent_index = j;
            }
            compare();
        }
        result[i] = most_frequent;
        frequencies[most_frequent_index].frequency = -1; // Prevent key from being counted again
        compare();
    }

    return result;
}

// Function to insert data from the dataset into the AVL Tree
void insertDataAVL(AVLTree *tree, int *dataset, int dataSize)
{
    compare();
    for (int i = 0; i < dataSize; i++)
    {
        insertAVL(tree, dataset[i]);
        compare();
    }
}
