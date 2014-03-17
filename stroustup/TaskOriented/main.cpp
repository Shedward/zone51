#include <algorithm>
#include <iostream>
#include <thread>
#include <vector>
#include <queue>
#include <mutex>
#include <condition_variable>
#include <future>

template <typename RAIter>
int parallel_sum(RAIter beg, RAIter end) {
  typename RAIter::difference_type len = end - beg;
  if (len < 1000) {
    return std::accumulate(beg, end, 0);
  }
  RAIter mid = beg + len/2;
  auto handle = std::async(std::launch::async,
                           parallel_sum<RAIter>, mid, end);
  int sum = parallel_sum(beg, mid);
  return sum + handle.get();
}

void conditional_test() {
  std::queue<int> produced;
  std::mutex m;
  std::condition_variable cond_var;
  bool done = false;
  bool notified = false;

  std::thread producer([&]{
    for (int i = 0; i < 5; ++i) {
      std::this_thread::sleep_for(std::chrono::seconds(1));
      std::unique_lock<std::mutex> lock(m);
      std::cout << "Produced " << i << '\n';
      produced.push(i);
      notified = true;
      cond_var.notify_one();
    }
    done = true;
    cond_var.notify_one();
  });

  std::thread consumer([&]{
    std::unique_lock<std::mutex> lock(m);
    while (!done) {
      cond_var.wait(lock, [notified] { return notified; });
      while (!produced.empty()) {
        std::cout << "Consuming " << produced.front() << '\n';
        produced.pop();
      }
      notified = false;
    }
  });

  producer.join();
  consumer.join();
}

int main() {
  auto threads_count = std::thread::hardware_concurrency() + 1;
  std::cout << "Threads: " << threads_count << std::endl;
  std::vector<int> v(100000,1);
  std::cout << " " << parallel_sum(v.begin(), v.end()) << std::endl;
  conditional_test();
  return 0;
}
