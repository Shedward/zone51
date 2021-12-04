precedencegroup ForwardApplication {
	associativity: left
}

infix operator |>: ForwardApplication

func |> <A, B>(a: A, f: (A) -> B) -> B {
	return f(a)
}

func |> <A>(a: inout A, f: (inout A) -> Void) -> Void {
	f(&a)
}

precedencegroup ForwardComposition {
	associativity: left
	higherThan: ForwardApplication
}

infix operator >>>: ForwardComposition

func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
	{ a in
		g(f(a))
	}
}
