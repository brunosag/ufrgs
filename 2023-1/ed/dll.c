#include "dll.h"
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Function to create an empty Doubly-Linked LIst
DoublyLinkedList *createDoublyLinkedList()
{
    DoublyLinkedList *list = (DoublyLinkedList *)malloc(sizeof(DoublyLinkedList));
    list->head = NULL;
    list->tail = NULL;
    return list;
}

// Function to destroy the Doubly-Linked List and free memory
void destroyDoublyLinkedList(DoublyLinkedList *list)
{
    DLLNode *current = list->head;
    while (current != NULL)
    {
        DLLNode *temp = current;
        current = current->next;
        free(temp);
    }
    free(list);
}

// Function to insert a key into the Doubly-Linked List
void insertDLL(DoublyLinkedList *list, int key)
{
    DLLNode *newNode = (DLLNode *)malloc(sizeof(DLLNode));
    newNode->key = key;
    newNode->prev = list->tail;
    newNode->next = NULL;

    if (list->tail != NULL)
    {
        list->tail->next = newNode;
    }
    else
    {
        list->head = newNode;
    }

    list->tail = newNode;
}

// Function to print the Doubly-Linked List
void printDLL(DoublyLinkedList *list)
{
    DLLNode *current = list->head;
    while (current != NULL)
    {
        printf("%d ", current->key);
        current = current->next;
    }
    printf("\n");
}

// Function to find the minimum value in the Doubly-Linked List
int findMinDLL(DoublyLinkedList *list)
{
    compare();
    if (list->head == NULL)
    {
        printf("List is empty.\n");
        return -1;
    }

    int min = list->head->key;
    DLLNode *current = list->head->next;
    compare();
    while (current != NULL)
    {
        compare();
        if (current->key < min)
        {
            min = current->key;
        }
        current = current->next;
        compare();
    }

    return min;
}

// Function to find the maximum value in the Doubly-Linked List
int findMaxDLL(DoublyLinkedList *list)
{
    compare();
    if (list->head == NULL)
    {
        printf("List is empty.\n");
        return -1;
    }

    int max = list->head->key;
    DLLNode *current = list->head->next;
    compare();
    while (current != NULL)
    {
        compare();
        if (current->key > max)
        {
            max = current->key;
        }
        current = current->next;
        compare();
    }

    return max;
}

// Function to calculate the average value in the Doubly-Linked List
float calculateAverageDLL(DoublyLinkedList *list)
{
    compare();
    if (list->head == NULL)
    {
        printf("List is empty.\n");
        return -1;
    }

    unsigned long long sum = 0;
    int count = 0;

    DLLNode *current = list->head;
    compare();
    while (current != NULL)
    {
        sum += current->key;
        count++;
        current = current->next;
        compare();
    }

    return (sum / (float)count);
}

// Function to find the X most frequent values in the Doubly-Linked List
KeyFrequency *findXMostFrequentDLL(DoublyLinkedList *list, int X, int dataSize)
{
    compare();
    if (list->head == NULL || X <= 0)
    {
        return NULL;
    }

    KeyFrequency *frequencies = calloc(dataSize, sizeof(KeyFrequency));
    KeyFrequency *result = calloc(X, sizeof(KeyFrequency));
    int frequencies_size = 0;

    // Find the frequency of each value in the list
    DLLNode *current = list->head;
    compare();
    while (current != NULL)
    {
        bool keyExists = false;
        compare();
        compare();
        for (int i = 0; (i < frequencies_size) && (!keyExists); i++)
        {
            compare();
            if (current->key == frequencies[i].key)
            {
                keyExists = true;
                frequencies[i].frequency++;
            }
            compare();
            compare();
        }
        compare();
        if (!keyExists)
        {
            KeyFrequency newKey = {current->key, 1};
            frequencies[frequencies_size] = newKey;
            frequencies_size++;
        }
        current = current->next;
        compare();
    }

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
void insertDataDLL(DoublyLinkedList *list, int *dataset, int dataSize)
{
    compare();
    for (int i = 0; i < dataSize; i++)
    {
        insertDLL(list, dataset[i]);
        compare();
    }
}
