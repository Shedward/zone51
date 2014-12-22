#include <memory>
#include <iostream>
#include <map>
#include <vector>
#include <regex>
#include <functional>

namespace Game {
struct Artefact {
    std::string Name;
    int Cost;
};

struct Boss {
    std::string Name;
    int Hp;
    int Attack;
};

class Room {
public:
    virtual void draw() const {
        std::cout << "[  ]";
    }
};

class TreasureRoom : public Room {
public:
    TreasureRoom(int gold)
        : prize_(gold) {
    }

    TreasureRoom(Artefact treasure, int count)
        : prize_(treasure.Cost * count){
    }

    void draw() const override {
        std::cout << "[" << prize_ << "$]";
    }

private:
    int prize_;
};

class BossRoom : public Room {
public:
    BossRoom(Boss boss)
        : boss_(boss) {
    }

    void draw() const override {
        std::cout << "[" << boss_.Name << "]";
    }
private:
    Boss boss_;
};
}

namespace DB {
const Game::Artefact getArtefact(int id) {
    static const auto treasures = std::map<int, Game::Artefact> {
        {1,  {"MagicWand",   500}},
        {2,  {"WoodenSword", 50}},
        {10, {"EmptyJar",    0}},
        {99, {"MithrilAxe",  200}}
    };

    return treasures.at(id);
}

const Game::Boss getBoss(int id) {
    static const auto bosses = std::map<int, Game::Boss> {
        {0, {"Dragon", 200, 5}},
        {1, {"Loki",   100, 4}},
        {3, {"Van",    50,  8}}
    };

    return bosses.at(id);
}
}

namespace Tools {
    std::vector<std::string> split(std::string str, char delim) {
        std::stringstream ss(str);
        std::vector<std::string> res;
        std::string item;

        while (std::getline(ss, item, delim)) {
            res.push_back(item);
        }

        return res;
    }
}

class Map {
public:
    using RoomRef = std::shared_ptr<const Game::Room>;

    static Map parse(std::string str) {
        Map res;
        auto lines = Tools::split(str, '\n');
        for (auto line : lines) {
            RoomRef room(std::move(parseRoom(line)));
            res.rooms_.push_back(room);
        }

        return res;
    }

    RoomRef operator[](uint indx) {
        return rooms_[indx];
    }

    void draw() {
        for (auto room : rooms_) {
            room->draw();
        }
    }

private:
    Map() {

    }

    static
    std::unique_ptr<Game::Room> parseRoom(std::string line) {
        auto words = Tools::split(line, ' ');
        std::unique_ptr<Game::Room> room;

        if (words[0] == "room") {
            room.reset(new Game::Room);
        } else if (words[0] == "treasure") {
            std::smatch result;
            if (std::regex_search(words[1], result, std::regex("([0-9]*)\\$"))) {
                int gold = std::stoi(result[0]);
                room.reset(new Game::TreasureRoom(gold));
            } else {
                auto artefact = DB::getArtefact(std::stoi(words[1]));
                auto count = words.size() > 2 ? std::stoi(words[2]) : 1;
                room.reset(new Game::TreasureRoom(artefact, count));
            }
        } else if (words[0] == "boss") {
            room.reset(new Game::BossRoom(DB::getBoss(std::stoi(words[1]))));
        } else {
            throw std::logic_error("Room of type " + words[0] + " not exist. Check your mapfile.");
        }


        return room;
    }

    std::vector<RoomRef> rooms_;
};

int main() {
    std::string mapfile =
            "treasure 100$\n"
            "room\n"
            "room\n"
            "treasure 1\n"
            "boss 3";

    Map::RoomRef room;
    {
        auto map = Map::parse(mapfile);
        map.draw();
        room = map[0];
    }
}
