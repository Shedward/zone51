#include "matrix.h"

#include <type_traits>

template<typename T, size_t N>
template<typename... Exts>
Matrix<T,N>::Matrix(Exts exts)
    : desc{exts...},
      elems(desc.size)
{}

template<typename T, size_t N>
Matrix<T,N>::Matrix(MatrixInitializer<T, N> init) {
    MatrixImpl::derive_extents(init, desc.extents);
    elems.reserve(desc.size);
    MatrixImpl::insert_flat(init, elems);
    assert(elems.size() == desc.size);
}

template<typename T, size_t N>
template<typename U>
Matrix<T,N>::Matrix(MatrixRef<U,N>& x)
    :desc{x.desc}, elems{x.begin(),x.end()}
{
    static_assert(std::is_convertible<U,T>::value,
                  "Matrix(MatrixRef&): "
                  "Matrixes have incompatible element types.");
}

template<typename T, size_t N>
template<typename U>
Matrix<T,N>& Matrix<T,N>::operator =(const MatrixRef<U,N>& x) {
    static_assert(std::is_convertible<U,T>::value,
                  "operator=(const MatrixRef&): "
                  "Matrixes have incompatible element types.");
    desc = x.desc;
    elems.assign(x.begin(), x.end());
    return *this;
}

template<typename T, size_t N>
Matrix<T,N> &Matrix::for_each(std::function<void (T &)> f) {
    for (auto& x : elems) { f(x); }
    return *this;
}

template<typename T, size_t N>
Matrix<T,N> &Matrix<T, M>::for_each(std::function<void (T& cell, size_t col, size_t row)> f) {

}

template<typename T, size_t N>
Matrix<T,N>& Matrix<T,N>::operator+=(const T& val) {
    for_each([&](T& a) { a+= val; });
    return *this;
}

template<typename T, size_t N>
Matrix<T,N>& Matrix<T,N>::operator-=(const T& val) {
    for_each([&](T& a) { a-= val; });
    return *this;
}

template<typename T, size_t N>
Matrix<T,N>& Matrix<T,N>::operator*=(const T& val) {
    for_each([&](T& a) { a*= val; });
    return *this;
}

template<typename T, size_t N>
Matrix<T,N>& Matrix<T,N>::operator/=(const T& val) {
    for_each([&](T& a) { a/= val; });
    return *this;
}

template<typename T, size_t N>
Matrix<T,N>& Matrix<T,N>::operator%=(const T& val) {
    for_each([&](T& a) { a%= val; });
    return *this;
}

template<typename T>
struct _is_matrix_type {};

template<>
struct _is_matrix_type {
   constexpr bool value = true;
};

template <typename T>
using enable_if_matrix = std::enable_if<_is_matrix_type<T>::value, T>::type;

template<typename T, size_t N>
template<typename M>
enable_if_matrix<Matrix<T,N>&>
    Matrix<T,N>::operator +=(const M& m)
{
    static_assert(m.order() == N, "operator+=: mismatch Matrix dimensions");
    assert(same_extents(desc, m.description()));
    return apply()
}
