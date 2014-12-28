#include <thread>
#include <future>
#include <iostream>
#include <list>
#include <iterator>

std::thread::id doWork() {
    auto id = std::this_thread::get_id();
    std::cout << "Hello from " << id << std::endl;
    return id;
}

template  <typename T, class A = std::allocator<T>>
class cyclic_list {
public:
    typedef A allocator_type;
    typedef typename A::value_type value_type;
    typedef typename A::reference reference;
    typedef typename A::const_reference const_reference;
    typedef typename A::difference_type difference_type;
    typedef typename A::size_type size_type;

    class iterator {
    public:
        typedef typename A::difference_type difference_type;
        typedef typename A::value_type value_type;
        typedef typename A::reference reference;
        typedef typename A::pointer pointer;
        typedef std::bidirectional_iterator_tag iterator_category;
    };

private:
    std::list<T> list_;
};

template <typename Collection>
class cyclic_iterator {
public:
    using base_iterator = typename Collection::iterator;
    using type = cyclic_iterator<Collection>;
    using value_type = typename Collection::value_type;
    using pointer = value_type*;
    using refference = value_type&;

    cyclic_iterator(const base_iterator& beg, const base_iterator& end, const base_iterator& cur)
        : cur(cur), beg(beg), end(end){
    }

    type& operator++() {
        cur = (cur + 1 == end) ? beg : cur + 1;
        return *this;
    }

    type& operator--() {
        cur = (cur == beg) ? end : cur - 1;
        return *this;
    }

    type& operator++(int) {
        auto ret = *this;
        ++*this;
        return ret;
    }

    type& operator--(int) {
        auto ret = *this;
        --*this;
        return ret;
    }

    refference operator*() {
        return *cur;
    }

    pointer operator->() {
        return cur.operator->();
    }

private:
    base_iterator cur, beg, end;
};

int main() {
    std::list<std::future<std::thread::id>> res;
    for (int i = 0; i < 10; i++) {
        res.push_back(std::async(std::launch::async, doWork));
    }

    using namespace std::chrono_literals;
    for (auto& r : res) {
        if (r.wait_for(1s) == std::future_status::ready) {
            std::cout << "Ended " << r.get() << std::endl;
        }
    }

   auto it = cyclic_iterator<decltype(res)>(res.begin(), res.end(), res.begin());
}
