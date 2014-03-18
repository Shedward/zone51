#include <cstdlib>
#include <algorithm>
#include <stdexcept>

template<typename T, size_t size>
class fixed_vector {
public:
	using iterator 			= T*;
	using const_iterator	= const T*;
	iterator begin() { return v_; }
	iterator end() { return v_ + size; }
	const_iterator begin() const { return v_; }
	const_iterator end() const { return v_ + size; }

	fixed_vector() = default;

	template<typename O, size_t osize>
	  fixed_vector(const fixed_vector<O,osize>& v) {
	  	*this = v;
	 }

	template<typename Iter>
	fixed_vector(Iter b, Iter e) {
		if (size < std::distance(b,e))
			throw std::out_of_range("Not enough space to copy.");
		auto copy_end = std::copy(b,e,begin());
	}

	fixed_vector<T,size>& operator=(const fixed_vector<T,size>&) = default;

	template<typename O, size_t osize>
	  fixed_vector<T,size>& operator=(const fixed_vector<O,osize>& val) {
		static_assert(size > osize, "Not enough space to copy.");
		auto copy_end = std::copy(val.begin(), val.end(), begin());
		return *this;
	}
private:
	T v_[size];
};

class B {};
class D : public B {};`

int main(int argc, char const *argv[])
{
	fixed_vector<char,6> v;
	fixed_vector<int,12> w(v);

	fixed_vector<D*,16> x;
	fixed_vector<B*,32> y, z(x.begin(), x.end()-2);
	y = x;
	return 0;
}