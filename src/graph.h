#ifndef __GRAPH_H__

#define __GRAPH_H__

#include "config.h"

typedef char edge_name[LENGTH_NAME];
typedef char vertex_name[LENGTH_NAME];

typedef struct edge_list_t {
    edge_name name;
    struct edge_list_t *next;
} edge_list_t;

typedef struct {
    vertex_name name;
    edge_list_t *edges;
} vertex_t;

typedef struct {
    int nb_vertices;
    vertex_t **vertices;
} graph_t;

#endif /* __GRAPH_H__ */
