#include <boost/graph/adjacency_list.hpp>
#include <boost/graph/graphviz.hpp>
#include <string>

typedef std::string vertex_t;
typedef boost::adjacency_list<
    boost::vecS,
    boost::vecS,
    boost::bidirectionalS,
    vertex_t
    > graph_t;

template <typename Graph_t>
void find_and_print(const Graph_t& g, const std::string& name) {
    typedef typename boost::graph_traits<Graph_t>
            ::vertex_iterator vert_it_t;
    vert_it_t it, end;
    boost::tie(it, end) = boost::vertices(g);

    typedef typename boost::graph_traits<Graph_t>::vertex_descriptor desc_t;

    for (; it != end; ++it) {
        desc_t desc = *it;
        if (boost::get(boost::vertex_bundle, g)[desc]
                == name.data()) {
            break;
        }
    }
    assert(it != end);
    std::cout << name << std::endl;
}

std::ostream& operator<<(std::ostream& out, const graph_t& g) {
    typedef typename boost::graph_traits<graph_t>::vertex_descriptor v_desc;
    boost::write_graphviz(out, g, [&](std::ostream& stream, const v_desc& vertex){
        stream << " [label=\""
               << boost::get(boost::vertex_bundle, g)[vertex]
               << "\"]";
    });
    return out;
}

int main(int argc, char* argv[]) {
    graph_t graph;

    auto cpp = boost::add_vertex(vertex_t("C++"), graph);
    auto stl = boost::add_vertex(vertex_t("STL"), graph);
    auto boost = boost::add_vertex(vertex_t("Boost"), graph);
    auto guru = boost::add_vertex(vertex_t("C++ guru"), graph);
    auto ansi_c = boost::add_vertex(vertex_t("C"), graph);

    boost::add_edge(cpp, stl, graph);
    boost::add_edge(stl, boost, graph);
    boost::add_edge(boost, guru, graph);
    boost::add_edge(ansi_c, guru, graph);

    std::cout << graph << std::endl;
}
