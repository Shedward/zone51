#include <limits>
#include <iostream>
#include <typeinfo>

#define limit_param(name) {std::cout << "\n\t"#name": " << limits::name;}
#define print_type_limits(type) {_print_type_limits<type>(#type);}

template<typename Scalar>
void _print_type_limits(const char* name) {
	using limits = std::numeric_limits<Scalar>;
	std::cout << std::boolalpha;
	std::cout << name << " (" << typeid(Scalar).name() << "):";
	limit_param(is_specialized)
	limit_param(min())
	limit_param(max())
	limit_param(lowest())
	limit_param(digits)
	limit_param(digits10)
	limit_param(is_signed)
	limit_param(is_exact)
	limit_param(radix)
	limit_param(epsilon())
	limit_param(round_error())
	limit_param(min_exponent)
	limit_param(min_exponent10)
	limit_param(max_exponent)
	limit_param(max_exponent10)
	limit_param(has_infinity)
	limit_param(has_quiet_NaN)
	limit_param(has_signaling_NaN)
	limit_param(has_denorm)
	limit_param(has_denorm_loss)
	limit_param(infinity())
	limit_param(quiet_NaN())
	limit_param(signaling_NaN())
	limit_param(denorm_min())
	limit_param(is_iec559)
	limit_param(is_bounded)
	limit_param(is_modulo)
	limit_param(traps)
	limit_param(tinyness_before)
	limit_param(round_style)
	std::cout << std::endl;
}

int main(int argc, char const *argv[])
{
	print_type_limits(bool);
	print_type_limits(char);
	print_type_limits(char16_t);
	print_type_limits(char32_t);
	print_type_limits(wchar_t);
	print_type_limits(signed char);
	print_type_limits(short);
	print_type_limits(int);
	print_type_limits(long);
	print_type_limits(long long);
	print_type_limits(unsigned char);
	print_type_limits(unsigned short);
	print_type_limits(unsigned int);
	print_type_limits(unsigned long);
	print_type_limits(unsigned long long);
	print_type_limits(float);
	print_type_limits(double);
	print_type_limits(long double);
	return 0;
}