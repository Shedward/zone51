#include <vector>

template<typename T, size_t N>
class Matrix {
public:
	using value_type = T;
	using iterator = typename std::vector<T>::iterator;
	using const_iterator = typename std::vector<T>::const_iterator;

	Matrix() = default;
	Matrix(Matrix&&) = default;
	Matrix& operator=(Matrix&&) = default;
	Matrix(const Matrix&) = default;
	Matrix& operator=(const Matrix&) = default;
	~Matrix() = default;

	template<typename U>
		Matrix(const MatrixRef<U,N>&);
	template<typename U>
		Matrix& operator=(const MatrixRef<U,N>&);

	template<typename... Exts>
	explicit Matrix(Exts... exts);
	
	Matrix(MatrixInitializer<T,N>);
	Matrix& operator=(MatrixInitializer<T,N>);

	template<typename U>
		Matrix(initializer_list<U>) = delete;
	template<typename U>
		Matrix(initializer_list<U>) = delete;

	static constexpr size_t order = N;
	size_t extent(size_t n) const { return desc.extents[n]; }
	size_t size() const { return elems.size(); }
	const MatrixSlice<N>& descriptor() const { return desc; }

	T* data() { return elems.data(); }
	const T* data() const { return elems.data(); }

private:
	MatrixSlice<N> desc;
	std::vector<T> elems;
};

template<typename T, size_t N>
template<typename... Exts>
Matrix<T,N>::Matrix(Exts... exts)
	: desc{exts...},
	  elems(desc.size())
{}

