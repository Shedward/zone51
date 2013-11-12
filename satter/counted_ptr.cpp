
#include <cstdlib>
#include <stdio.h>

template <typename T>
class CounterPtr {
public:
	CounterPtr(T *p) : impl_(new Impl(p)) {}

	CounterPtr(const CounterPtr &other){
		impl_ = other.impl_;
		inc();
	}

	~CounterPtr(){ dec(); }

	T* operator->() { return impl_->p_; }
	T& operator*() { return *(impl_->p_); }
private:
	class Impl {
	public:
		Impl(T *p) : p_(p), ref_(1) {}
		~Impl() { delete p_; }
		size_t ref_;
		T *p_;
	};

	Impl *impl_;

	void inc(){	
		++(impl_->ref_);
		printf("inc %i\n", impl_->ref_);
	}

	void dec(){
		if (--(impl_->ref_) == 0){
			delete impl_;
			printf("~impl\n");
		} else {
			printf("dec %i\n", impl_->ref_);
		}
	}
};

template <typename Ptr>
void test(Ptr p){
	printf("Copy %i\n", *p);
}

int main() {
	CounterPtr<int> p1 = new int;
	*p1 = 50;
	printf("%i\n", *p1);
	CounterPtr<int> p2 = p1;
	printf("%i\n", *p2);
	test(p2);
	printf("%i\n", *p1);
	printf("%i\n", *p2);
}