infix operator <>: SingleTypeComposition

func <> <A>(
	f: @escaping (A) -> A,
	g: @escaping (A) -> A
) -> ((A) -> A) {
	f >>> g
}

func <> <A>(
	f: @escaping (inout A) -> Void,
	g: @escaping (inout A) -> Void
) -> ((inout A) -> Void) {
	{ a in
		f(&a)
		g(&a)
	}
}

func <> <A: AnyObject>(
	f: @escaping (A) -> Void,
	g: @escaping (A) -> Void
) -> (A) -> Void {
	{ a in
		f(a)
		g(a)
	}
}

func fromInout<A>(
	_ f: @escaping (inout A) -> Void
) -> (A) -> A {
	{ a in
		var copy = a
		f(&copy)
		return copy
	}
}

func toInout<A>(
	_ f: @escaping (A) -> A
) -> ((inout A) -> Void) {
	{ a in
		a = f(a)
	}
}
