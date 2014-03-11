#include <iostream>
#include <memory>
#include <utility>
#include <stdexcept>
#include <functional>
#include <string>

typedef unsigned int uint;

class matrixs_size_mismatch : public std::logic_error {
public:
	matrixs_size_mismatch(const std::string& str) noexcept: std::logic_error(str) {}
};

template<typename T>
class Matrix;

template<typename T>
void for_each(Matrix<T> &mat, std::function<void(uint r, uint c, T& cell)> fun) {
	for(unsigned r = 0; r < mat.rows(); ++r) {
		for(unsigned c = 0; c < mat.cols(); ++c) {
			fun(r, c, mat(r, c));
		}
	}
}

template <typename T>
class Matrix {
public:

	Matrix(uint rows, uint cols, std::function<T(uint r, uint c)> filler)
	: rows_{rows}, cols_{cols},
	  mat_(new T[cols*rows]) 
	{
		for_each(*this, [&filler](uint r, uint c, T& cell){
			cell = filler(r, c);
		});
	}

	Matrix(uint rows = 1, uint cols = 1, const T &def_value = T())
	: Matrix(rows, cols, [&](uint r, uint c){ return def_value; })
	{}

	Matrix(const Matrix &val)
	: Matrix(val.rows(), val.cols(), [&val](uint r, uint c) { return val(r, c); })
	{}

	Matrix& operator=(const Matrix &val){

		mat_.reset(new T[val.cols()*val.rows()]);
		cols_ = val.cols();
		rows_ = val.rows();

		for_each(*this, [&val](uint r, uint c, T &cell){
			cell = val(r, c);
		});

		return *this;
	}

	uint cols() const { return cols_; }
	uint rows() const { return rows_; }

	T& operator()(uint row, uint col) {
		return cell(row, col);
	}

	T operator()(uint row, uint col) const {
		return mat_[row*cols_ + col];;
	}

private:
	T& cell(uint row, uint col) {	return mat_[row*cols_ + col]; }
	uint  rows_;
	uint  cols_;
	std::unique_ptr<T[]> mat_;
};

template<typename T>
std::istream& operator>>(std::istream &in, Matrix<T> &mat){
	for_each(mat, [&in](uint r, uint c, T &cell){
		in >> cell;
	});
	return in;
}

template<typename T>
std::ostream& operator<<(std::ostream &out, const Matrix<T> &mat){
	for(unsigned c = 0; c < mat.cols(); ++c) {
		for(unsigned r = 0; r < mat.rows(); ++r) {
			out << mat(c, r) << " ";
		}
		out << std::endl;
	}
	return out;
}

template<typename T, typename U>
auto operator+(const Matrix<T> &lhs, const Matrix<U> &rhs) -> Matrix<decltype(T() + U())>
{
	uint max_rows = std::max(lhs.rows(), rhs.rows());
	uint max_cols = std::max(lhs.cols(), rhs.cols());

	return Matrix<decltype(T() + U())>(max_rows, max_cols, [&](uint r, uint c){
		T lhs_cell = (c > lhs.cols() or r > lhs.rows()) ? T() : lhs(r, c);
		U rhs_cell = (c > rhs.cols() or r > rhs.rows()) ? U() : rhs(r, c);
		return lhs_cell + rhs_cell;
	});
}

template<typename T, typename U>
auto operator+(const Matrix<T> &lhs, const U &val) -> Matrix<decltype(T() + U())> 
{
	Matrix<decltype(T() + U())> res = lhs;
	
	for_each(res, [&val](uint r, uint c, T& cell){
		cell += val;
	});

	return res;
}

int main(int argc, char const *argv[])
{
	Matrix<Matrix<int>> mat1(4, 3, Matrix<int>(3, 3, [](uint r, uint c){
		return r + c;
	}));

	// Matrix<Matrix<float>> mat2(4, 3,  Matrix<float>(3, 3, 2.5f));

	std::cout << mat1 << std::endl;
	// std::cout << mat2 << std::endl;
	std::cout << std::endl;
	//std::cout << mat1 + mat2 << std::endl;
	return 0;
}

