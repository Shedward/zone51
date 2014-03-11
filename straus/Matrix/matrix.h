#ifndef MATRIX_H
#define MATRIX_H

#include <stddef.h>
#include <vector>
#include <initializer_list>
#include <type_traits>
#include <functional>

template<typename T, size_t N>
class MatrixRef;

template<typename T, size_t N>
class MatrixInitializer;

template<size_t N>
struct MatrixSlice {
    MatrixSlice() = default;
    MatrixSlice(size_t s, std::initializer_list<size_t> exts);
    MatrixSlice(size_t s, std::initializer_list<size_t> exts,
                std::initializer_list<size_t> strs);

    template<typename... Dims>
    MatrixSlice(Dims... dims);

    template<typename... Dims,
             typename = std::enable_if<std::is_convertible<Dims,size_t>::value>::type>
    size_t operator()(Dims... dims) const;

    size_t size;
    size_t start;
    array<size_t,N> extents;
    array<size_t,N> strides;
};

class MatrixImpl{
    template<typename... Args>
    using RequestingElement = int;
};

template<typename T, size_t N>
class Matrix {
public:
    using value_type = T;
    using iterator = typename std::vector<T>::iterator;
    using const_iterator = typename std::vector<T>::const_iterator;

    // Construction

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
    Matrix(std::initializer_list<U>) = delete;
    template<typename U>
    Matrix& operator=(std::initializer_list<U>) = delete;

    static constexpr size_t order = N;
    size_t extent(size_t n) const { return desc.extents[n]; }
    size_t size() const { return elems.size(); }
    const MatrixSlice<N>& descriptor() const { return desc; }

    T* data() { return elems.data(); }
    const T* data() const { return elems.data(); }

    // Slicing and accessing

    template<typename... Args>
    std::enable_if<MatrixImpl::RequestingElement<Args...>(), T&>::type
        operator()(Args... args);

    template<typename... Args>
    std::enable_if<MatrixImpl::RequestingElement<Args...>(), T&>::type
        operator()(Args... args) const;

    template<typename... Args>
    std::enable_if<MatrixImpl::RequestingSlice<Args...>(), MatrixRef<T,N>>::type
        operator ()(const Args&... args);

    template<typename... Args>
    std::enable_if<MatrixImpl::RequestingSlice<Args...>(), MatrixRef<T,N>>::type
        operator ()(const Args&... args) const;

    MatrixRef<T,N-1> operator[](size_t i) { return row(i); }
    MatrixRef<const T,N-1> operator[](size_t i) { return row(i); }

    MatrixRef<T,N-1> row(size_t n);
    MatrixRef<const T, N-1> row(size_t n) const;

    MatrixRef<T,N-1> col(size_t n);
    MatrixRef<const T,N-1> col(size_t n) const;

    // Arithmetic
    Matrix& apply(std::function<T&& (const T &)>);
    Matrix& for_each(std::function<void(T& cell, size_t col, size_t row)>);

    Matrix& operator=(const T& val);

    Matrix& operator+=(const T& val);
    Matrix& operator-=(const T& val);
    Matrix& operator*=(const T& val);
    Matrix& operator/=(const T& val);
    Matrix& operator%=(const T& val);

    template<typename M>
    Matrix& operator +=(const M& x);
    template<typename M>
    Matrix& operator -=(const M& x);
private:
    MatrixSlice<N> desc;
    std::vector<T> elems;
};

template<typename T, size_t N>
Matrix<T,N> operator+(const Matrix<T,N>&m, const T& val){
    Matrix<T,N> res = m;
    res += val;
    return res;
}

template<typename T, size_t N>
Matrix<T,N> operator-(const Matrix<T,N>&m, const T& val){
    Matrix<T,N> res = m;
    res -= val;
    return res;
}

template<typename T, size_t N>
Matrix<T,N> operator*(const Matrix<T,N>&m, const T& val){
    Matrix<T,N> res = m;
    res *= val;
    return res;
}

template<typename T, size_t N>
Matrix<T,N> operator/(const Matrix<T,N>&m, const T& val){
    Matrix<T,N> res = m;
    res /= val;
    return res;
}

template<typename T, size_t N>
Matrix<T,N> operator%(const Matrix<T,N>&m, const T& val){
    Matrix<T,N> res = m;
    res %= val;
    return res;
}
#endif // MATRIX_H
