#include <algorithm>
#include <iterator>
#include <utility>

template <typename T, size_t size>
class fixed_vector {
public:
	typedef T*			iteraror;
	typedef const T*	const_iterator;
	iteraror			begin()			{ return v_; }
	iteraror			end()			{ return v_ + size; }
	const_iterator		begin() const 	{ return v_; }
	const_iterator		end()	const 	{ return v_ + size; }

	fixed_vector() {}

	template<typename O, size_t osize>
	fixed_vector(const fixed_vector<O, osize> &other){
		std::copy(other.begin(),
				  other.begin() + std::min(size, osize),
				  begin());
	}

	template<typename Iter>
	fixed_vector(Iter begin, Iter end){
		copy(begin,
			 begin + std::min(size, std::distance(end, begin)),
			 begin());
	}

	template<typename O, size_t osize>
	fixed_vector<T, size>&
	operator=(const fixed_vector<O, osize> & other){
		std::copy(other.begin(),
				  other.begin() + std::min(size, osize),
				  begin());
		return *this;
	}

private:
	T v_[size];
};

template <typename T, size_t size>
class fixed_vector_safe {
public:
	typedef T* iterator;
	typedef const T* const_iterator;

	fixed_vector_safe() : v_(new T[size]) {}

	template <typename Iter>
	fixed_vector_safe(Iter begin, Iter end) 
	 : fixed_vector_safe() {
	 	try {
	 		copy(begin,
	 			 begin + std::min(size, std::distance(end, begin)),
	 			 begin());
	 	} catch(...){
	 		delete[] v_;
	 		throw;
	 	}
	}

	template <typename O, size_t osize>
	fixed_vector_safe(const fixed_vector_safe<O, osize>& other) 
	 : fixed_vector_safe(other.begin(), other.end()) 
	 {}

	void swap(const fixed_vector_safe<T, size> &other) throw() {
		std::swap(v_, other.v_);
	}

	template <typename O, size_t osize>
	fixed_vector_safe<T, size>
	operator=(const fixed_vector_safe<O, osize> &other){
		fixed_vector_safe<T, size> temp(other);
		swap(temp);
		return *this;
	}

	iterator begin() { return v_; }
	iterator end() { return v_ + size; }
	const_iterator begin() const { return v_; }
	const_iterator end() const { return v_ + size;}
private:
	T* v_;
};

int main() {
	fixed_vector<int, 5> vec;
}