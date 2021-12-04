precedencegroup EffectfulComposition {
	associativity: left
	higherThan: ForwardApplication
}

infix operator >=>: EffectfulComposition

struct SideAffected<Value, SideEffect> {
	let value: Value
	let sideEffects: [SideEffect]

	init(_ value: Value, sideEffects: [SideEffect]) {
		self.value = value
		self.sideEffects = sideEffects
	}
}

extension SideAffected: Equatable where Value: Equatable, SideEffect: Equatable {
	static func ==(lhs: Self, rhs: Self) -> Bool {
		lhs.value == rhs.value && lhs.sideEffects == rhs.sideEffects
	}
}

func >=> <A, B, C, SideEffect>(
	_ f: @escaping (A) -> SideAffected<B, SideEffect>,
	_ g: @escaping (B) -> SideAffected<C, SideEffect>
) -> (A) -> SideAffected<C, SideEffect> {
	return { a in
		let fResult = f(a)
		let gResult = g(fResult.value)
		return .init(gResult.value, sideEffects: fResult.sideEffects + gResult.sideEffects)
	}
}

func >=> <A, B, C>(
	_ f: @escaping (A) -> B?,
	_ g: @escaping (B) -> C?
) -> (A) -> C? {
	return { a in
		guard let b = f(a) else { return nil }
		guard let c = g(b) else { return nil }
		return c
	}
}

precedencegroup SingleTypeComposition {
	associativity: left
	higherThan: ForwardApplication
}
