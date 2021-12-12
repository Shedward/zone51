enum Either<A, B> {
	case left(A)
	case right(B)
}

func filterSome<A>(_ isSome: @escaping (A) -> Bool) -> (A) -> A? {
	{ a in isSome(a) ? .some(a) : .none }
}

func partitionEither<A>(_ isLeft: @escaping (A) -> Bool) -> (A) -> Either<A, A> {
	{ a in isLeft(a) ? .left(a) : .right(a) }
}

extension Array {
	func filterMap<B>(_ transform: (Element) -> B?) -> [B] {
		var result = [B]()
		for x in self {
			switch transform(x) {
			case let .some(x):
				result.append(x)
			case .none:
				continue
			}
		}
		return result
	}

	func partitionMap<A, B>(_ transform: (Element) -> Either<A, B>) -> (lefts: [A], rights: [B]) {
		var result = (lefts: [A](), rights: [B]())
		for x in self {
			switch transform(x) {
			case let .left(a):
				result.lefts.append(a)
			case let .right(b):
				result.rights.append(b)
			}
		}
		return result
	}
}

func filter<A>(_ isPass: @escaping (A) -> Bool) -> ([A]) -> [A] {
	{ $0.filterMap(filterSome(isPass)) }
}

func partition<A>(_ isLeft: @escaping (A) -> Bool) -> ([A]) -> ([A], [A]) {
	{ $0.partitionMap(partitionEither(isLeft)) }
}

func filterMap<A>(_ transform: @escaping (A) -> A?) -> ([A]) -> [A] {
	{ $0.filterMap(transform) }
}

func partitionMap<A>(_ transform: @escaping (A) -> Either<A, A>) -> ([A]) -> ([A], [A]) {
	{ $0.partitionMap(transform) }
}

func filterMapValues<K, V>(_ transform: @escaping (V) -> V?) -> ([K:V]) -> [K:V] {
	{ dict in dict.compactMapValues(transform) }
}
