#include <iostream>
#include <memory>

typedef unsigned int uint;

template <typename T>
class Matrix {
public:
	Matrix(uint rows = 1, uint cols = 1, const T &def_value = T())
	: rows_{rows}, cols_{cols},
	  mat_(new T[cols*rows]) {}

	uint cols() const { return cols_; }
	uint rows() const { return rows_; }

	T& operator()(uint row, uint col) {
		return mat_[row*cols_ + col];
	}
private:
	uint  rows_;
	uint  cols_;
	std::unique_ptr<T[]> mat_;
};

int main(int argc, char const *argv[])
{
	Matrix<float> mat(3, 3);

	for (int c = 0; c < mat.cols(); ++c){
		for (int r = 0; r < mat.rows(); ++r){
			mat(r, c) = r + c;
		}
	}

	for (int c = 0; c < mat.cols(); ++c){
		for (int r = 0; r < mat.rows(); ++r){
			std::cout << mat(r, c) << " ";
		}
		std::cout << std::endl;
	}
	return 0;
}