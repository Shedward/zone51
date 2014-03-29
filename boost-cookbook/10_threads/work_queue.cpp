#include <deque>
#include <boost/function.hpp>
#include <boost/thread/mutex.hpp>
#include <boost/thread/locks.hpp>
#include <boost/thread/condition_variable.hpp>
#include <boost/thread/thread.hpp>

class work_queue {
public:
    using task_type = boost::function<void()>;

    void push_task(const task_type& task) {
        boost::unique_lock<boost::mutex> lock(tasks_mutex_);
        tasks_.push_back(task);
        lock.unlock();
        cond_.notify_one();
    }

    task_type try_pop_task() {
        task_type res;
        boost::lock_guard<boost::mutex> lock(tasks_mutex_);
        if (!tasks_.empty()) {
            res = tasks_.front();
            tasks_.pop_front();
        }
        return res;
    }

    task_type pop_task() {
        boost::unique_lock<boost::mutex> lock(tasks_mutex_);
        while (tasks_.empty()) {
            cond_.wait(lock);
        }
        task_type res = tasks_.front();
        tasks_.pop_front();
        return res;
    }

private:
    std::deque<task_type> tasks_;
    boost::mutex          tasks_mutex_;
    boost::condition_variable cond_;
};

work_queue g_queue;
void do_nothing() {
    static boost::mutex mutex;
    boost::lock_guard<boost::mutex> lock(mutex);
    std::cout << "Done nothing at " << boost::this_thread::get_id() << "\n";
}

const std::size_t tests_task_count = 50;

void pusher() {
    for (std::size_t i = 0; i < tests_task_count; ++i) {
        g_queue.push_task(&do_nothing);
    }
}

void popper_sync() {
    for (std::size_t i = 0; i <= tests_task_count; ++i) {
        g_queue.pop_task()();
    }
}

const std::size_t pair_count = 5;

int main() {
    std::vector<boost::thread> threads;

    for (std::size_t i = 0; i <= pair_count; ++i){
        threads.emplace_back(&pusher);
    }

    for (std::size_t i = 0; i <= pair_count; ++i){
        threads.emplace_back(&popper_sync);
    }

    std::for_each(threads.begin(), threads.end(),
                  std::mem_fn(&boost::thread::join));
    return 0;
}
