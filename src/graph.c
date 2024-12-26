#include "graph.h"

graph_t* init_graph(uint16_t nb_vertices) {
    graph_t* new_graph = (graph_t*)malloc(sizeof(struct graph));
    new_graph->nb_vertices = nb_vertices;

    vertex_t** new_vertex = (vertex_t**)calloc(nb_vertices, sizeof(struct vertex*));
    new_graph->vertices = new_vertex;

    return new_graph;
}
