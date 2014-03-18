#include <iostream>
#include <typeinfo>
#include <string>

//-------------------------------------------

template<bool C, typename T, typename F>
struct _static_if {
	using type = T;
};

template<typename T, typename F>
struct  _static_if<false, T, F> {
	using type = F;	
};

template<bool C, typename T, typename F>
using static_if = typename _static_if<C, T, F>::type;

//-------------------------------------------

template<typename T>
const char* type_name(const T& val) noexcept {
	return typeid(val).name();
}

//-------------------------------------------

template<int S, typename T, typename... Cases>
struct _static_select;

template<int S, typename T, typename... Cases>
struct _static_select : _static_select<S-1, Cases...>
{ };

template<typename T, typename... Cases>
struct _static_select<0, T, Cases...> {
	using type = T;
};

template<int S, typename... Cases>
using static_select = typename _static_select<S, Cases...>::type;
			
//-------------------------------------------

struct Nil { 
	Nil() {
	}
};

//--------------------------------------------------

template<int Size>
using Integer = 
	static_select<Size,Nil,bool,char,Nil,unsigned,Nil,Nil,Nil,long>;

int main(int argc, char const *argv[])
{
	using ChoosenOne = static_if<(sizeof(int) > 2), int, double>;
	using ChoosenTwo = static_if<(sizeof(int) < 2), double, std::string>;

	ChoosenOne val;
	ChoosenTwo val2;

	std::cout << type_name(val) << std::endl
	 				  << type_name(val2) << std::endl;


	Integer<1> bool_val;
	Integer<2> char_val;
	Integer<4> int_val;
	Integer<8> long_val;
	Integer<3> nil_val;

	std::cout << type_name(bool_val) << std::endl
						<< type_name(char_val) << std::endl
						<< type_name(int_val) << std::endl
						<< type_name(long_val) << std::endl
						<< type_name(nil_val) << std::endl;

	return 0;
}