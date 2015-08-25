#ifndef AVG_TREE_H
#define AVG_TREE_H

typedef struct {
    avg_tree *nodes;
    unsigned int node_count;
} avg_tree;

enum avg_tree_opts {
    BALANCE_ALWAYS = 0x01
} ;

int init_root_node(avg_tree *root_node, avg_tree_opts opts);

#endif // AVG_TREE_H
