#ifndef __HASH_TABLE_H__

#define __HASH_TABLE_H__

#include "config.h"

#define HT_PRIME_1 151
#define HT_PRIME_2 163
#define DEFAULT_HT_SIZE 64

typedef struct {
    char key[LENGTH_NAME];
    int value;
} ht_item;

typedef struct {
    int size;
    int count;
    ht_item** items;
} ht_hash_table;

double pow(double, double);

static ht_item* ht_new_item(const char* k, const int v);
ht_hash_table* ht_new();

static void ht_del_item(ht_item* i);
void ht_del_hash_table(ht_hash_table* ht);

static int ht_hash(const char* s, const int a, const int m);
static int ht_get_hash(const char* s, const int num_buckets, const int attempt);

void ht_insert(ht_hash_table* ht, const char* key, const int value);
int ht_search(ht_hash_table* ht, const char* key);
void ht_delete(ht_hash_table* h, const char* key);

#endif
