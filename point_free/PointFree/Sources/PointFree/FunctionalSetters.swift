func first<A, B, C>(_ f: @escaping (A) -> C) -> ((A, B)) -> (C, B) {
	{ pair in
		(f(pair.0), pair.1)
	}
}

func second<A, B, C>(_ f: @escaping (B) -> C) -> ((A, B)) -> (A, C) {
	{ pair in
		(pair.0, f(pair.1))
	}
}

func map<A, B>(_ f: @escaping (A) -> B) -> ([A]) -> [B] {
	{ xs in xs.map(f) }
}

func map<A, B>(_ f: @escaping (A) -> B) -> (A?) -> B? {
	{ xs in xs.map(f) }
}

func atIndex<A>(_ index: Int) -> (@escaping (A) -> A) -> ([A]) -> [A] {
	{ f in
		{ xs in
			xs.enumerated().map { currentIndex, value in
				if currentIndex == index {
					return f(value)
				} else {
					return value
				}
			}
		}
	}
}

func atKeyIfExist<K,V>(_ key: K) -> (@escaping (V) -> V) -> ([K:V]) -> [K:V] {
	{ f in
		{ xs in
			var ys = xs
			if let value = xs[key] {
				ys[key] = f(value)
			}
			return ys
		}
	}
}

func atKey<K,V>(_ key: K) -> (@escaping (V?) -> V?) -> ([K:V]) -> [K:V] {
	{ f in
		{ xs in
			var ys = xs
			ys[key] = f(ys[key])
			return ys
		}
	}
}

func not(_ x: Bool) -> Bool {
	!x
}

precedencegroup BackwardComposition {
	associativity: left
}

infix operator <<<: BackwardComposition

func <<< <A, B, C>(
	_ g: @escaping (B) -> C,
	_ f: @escaping (A) -> B
) -> (A) -> C {
	{ x in
		g(f(x))
	}
}
