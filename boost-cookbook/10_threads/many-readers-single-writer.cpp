#include <iostream>
#include <map>
#include <utility>

#include <boost/thread/mutex.hpp>
#include <boost/thread/locks.hpp>
#include <boost/thread/shared_mutex.hpp>

struct user_info {
    using age_t = unsigned short;
    std::string name;
    age_t age;
};

class users_online {
public:
    bool is_online(const std::string& login) const {
        boost::shared_lock<mutex_t> lock(mutex_);
        return users_.count(login);
    }

    user_info::age_t get_age(const std::string& login) const {
        boost::shared_lock<mutex_t> lock(mutex_);
        return users_.at(login).age;
    }

    void set_online(const std::string& login, const user_info& data) {
        boost::lock_guard<mutex_t> lock(mutex_);
        users_.insert(std::make_pair(login, data));
    }

private:
    using mutex_t = boost::shared_mutex;
    std::map<std::string,user_info> users_;
    mutable mutex_t mutex_;
};

int main(int argc, char *argv[])
{

    return 0;
}

