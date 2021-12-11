func get<Root, Value>(_ keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
	{ $0[keyPath: keyPath] }
}

prefix operator ^
prefix func ^ <Root, Value>(_ keyPath: KeyPath<Root, Value>) -> (Root) -> Value {
	get(keyPath)
}

func their<Root, Value, Result>(
	_ valueFrom: @escaping (Root) -> Value,
	_ composeValues: @escaping (Value, Value) -> Result
) -> (Root, Root) -> Result {
	{ lhs, rhs in
		composeValues(valueFrom(lhs), valueFrom(rhs))
	}
}

func reducer<Root, Value>(
	_ valueFrom: @escaping (Root) -> Value,
	_ combineValues: @escaping (Value, Value) -> Value
) -> (Value, Root) -> Value {
	{ value, root in
		combineValues(value, valueFrom(root))
	}
}
