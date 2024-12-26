#ifndef __GRAPH_H__

#define __GRAPH_H__

#include "config.h"

typedef char edge_name[LENGTH_NAME];
typedef char vertex_name[LENGTH_NAME];

typedef struct edge_list {
    edge_name name;
    struct edge_list* next;
} edge_list_t;

typedef struct vertex {
    vertex_name name;
    struct edge_list* edges;
} vertex_t;

typedef struct graph {
    uint16_t nb_vertices;
    struct vertex** vertices;
} graph_t;

graph_t* init_graph(uint16_t nb_vertices);

#endif /* __GRAPH_H__ */
