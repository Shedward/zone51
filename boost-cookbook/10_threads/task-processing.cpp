#include <iostream>

#include <boost/asio/io_service.hpp>
#include <boost/asio/deadline_timer.hpp>
#include <boost/thread/thread.hpp>
#include <boost/system/error_code.hpp>
#include <boost/make_shared.hpp>

#include <assert.h>

namespace detail {

template <typename T>
struct task_wrapped {
private:
    T task_unwrapped_;

public:
    explicit task_wrapped(const T& task_unwrapped)
        : task_unwrapped_(task_unwrapped)
    {}

    void operator ()() const {
        try {
            boost::this_thread::interruption_point();
        } catch (const boost::thread_interrupted&) {}

        try {
            task_unwrapped_();
        } catch (const std::exception& e) {
            std::cerr << "Exception: " << e.what() << std::endl;
        } catch (const boost::thread_interrupted&) {
            std::cerr << "Thread interupted" << std::endl;
        }
    }
};

template <typename T>
task_wrapped<T> make_task_wrapped(const T& task_unwrapped) {
    return task_wrapped<T>(task_unwrapped);
}

template <class Func>
struct timer_task : public task_wrapped<Func> {
private:
    typedef task_wrapped<Func> base_t;
    boost::shared_ptr<boost::asio::deadline_timer> timer_;

public:
    template <class Time>
    explicit timer_task(
            boost::asio::io_service& ios,
            const Time& duration_or_time,
            const Func& task_unwrapped)
        : base_t(task_unwrapped),
          timer_(boost::make_shared<boost::asio::deadline_timer>(
                     boost::ref(ios), duration_or_time))
    {}

    void push_task() const {
        timer_->async_wait(*this);
    }

    void operator ()(const boost::system::system_error& err) const {
        if (err.code()) {
            base_t::operator ()();
        } else {
            std::cerr << err.what() << '\n';
        }
    }
};

template <class Time, class Func>
inline timer_task<Func> make_timer_task(
        boost::asio::io_service& ios,
        const Time& duration_or_time,
        const Func& task_unwrapped) {
    return timer_task<Func>(ios, duration_or_time, task_unwrapped);
}
} //  namespace detail

class tasks_processor : private boost::noncopyable {
    boost::asio::io_service         ios_;
    boost::asio::io_service::work   work_;

    tasks_processor()
        : ios_(),
          work_(ios_)
    {}

public:
    static tasks_processor& get() {
        static tasks_processor processor;
        return processor;
    }

    template <typename T>
    inline void push_task(const T& task_unwrapped) {
        ios_.post(detail::make_task_wrapped(task_unwrapped));
    }

    void start() {
        ios_.run();
    }

    void stop() {
        ios_.stop();
    }

    typedef boost::asio::deadline_timer::time_type time_type;
    template <typename Func>
    void run_at(time_type time, const Func& f) {
        detail::make_timer_task(ios_, time, f).push_task();
    }

    typedef boost::asio::deadline_timer::duration_type duration_type;
    template <typename Func>
    void run_after(duration_type duration, const Func& f) {
        detail::make_timer_task(ios_, duration, f).push_task();
    }
};

int g_val = 0;

void func_test() {
    ++g_val;
    if (g_val == 3) {
        throw std::logic_error("Just checking");
    }
    boost::this_thread::interruption_point();
    if (g_val == 10) {
        throw boost::thread_interrupted();
    }

    boost::this_thread::sleep_for(boost::chrono::milliseconds(100));

    if (g_val == 90) {
        tasks_processor::get().stop();
    }
}


int main(int argc, char *argv[])
{
    static const std::size_t tasks_count = 100;
    static_assert(tasks_count > 90, "Should stop at 90s task");

    tasks_processor::get().push_task([]{
        std::cout << "Hello" << std::endl;
    });

    for (std::size_t i = 0; i < tasks_count; ++i) {
        tasks_processor::get().push_task(&func_test);
    }

    tasks_processor::get().push_task(boost::bind(std::plus<int>(), 2, 2));

    std::cout << "Begin task" << std::endl;
    tasks_processor::get().run_after(boost::posix_time::seconds(1), [] {
        std::cout << "End task" << std::endl;
    });

    assert(g_val == 0);
    tasks_processor::get().start();
    assert(g_val == 90);

    return 0;
}
