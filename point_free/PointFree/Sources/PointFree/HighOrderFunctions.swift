func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
	{ a in { b in f(a, b) } }
}

func curry<A, B, C, D>(_ f: @escaping (A, B, C) -> D) -> (A) -> (B) -> (C) -> D {
	{ a in { b in { c in f(a, b, c) } } }
}

func flip<A, B, C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
	{ b in { a in f(a)(b) } }
}

func flip<A, C>(_ f: @escaping (A) -> () -> C) -> (A) -> C {
	{ a in f(a)() }
}
