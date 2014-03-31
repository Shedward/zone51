#include <iostream>
#include <fstream>
#include <utility>

#include <boost/program_options.hpp>
#include <boost/regex.hpp>

namespace po = boost::program_options;

int main(int argc, char *argv[]) {
    po::options_description desc("Option usage.");
    desc.add_options()
            ("help,h", "Show this message")
            ("case-insesetive,i", "Case insensetive")
            ("syntax,s",po::value<std::string>()->default_value("basic"),
             "Regex syntaxes:\n"
             "\t perl    - Perl syntax.\n"
             "\t basic   - Basic POSIX syntax.\n"
             "\t extended - Extended POSIX syntax. \n")
            ("regex,e", po::value<std::string>(), "Regular expression.")
            ("file,f", po::value<std::string>(), "Filename");

    po::positional_options_description pos_desc;
    pos_desc.add("file",1);

    po::variables_map vm;
    po::store(po::command_line_parser(argc,argv).
              options(desc).positional(pos_desc).run(), vm);
    po::notify(vm);

    if (vm.count("help")) {
        std::cout << desc << std::endl;
    }

    std::istream& inp = std::cin;
    std::ifstream file;
    if (vm.count("file")){
        file.open(vm["file"].as<std::string>());
        inp.rdbuf(file.rdbuf());
    }

    boost::regex::flag_type flags = boost::regex::no_except;
    std::string mode = vm["syntax"].as<std::string>();
    if (mode == "perl") {
        flags = boost::regex::perl;
    } else if (mode == "basic") {
        flags = boost::regex::basic;
    } else if (mode == "extended") {
        flags = boost::regex::extended;
    } else {
        std::cerr << "Wrong regex syntax \'" << mode << "\'.\n"
                 << "See --help for more information." << std::endl;
        return -1;
    }

    if (vm.count("case-insensetive")) {
        flags |= boost::regex::icase;
    }

    std::string regex;
    if (vm.count("regex")) {
        regex = vm["regex"].as<std::string>();
    }

    const boost::regex e(regex, flags);

    if (e.status() || regex.empty()) {
        std::cerr << "Incorrect regex pattern: \'" << regex << "\'\n";
        return -2;
    }

    std::string line;
    while (std::getline(inp, line)) {
        if (boost::regex_match(line, e)) {
            std::cout << line << std::endl;
        }
    }
    return 0;
}

