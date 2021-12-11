func prop<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>) -> (@escaping (Value) -> Value) -> (Root) -> Root {
	{ update in
		{ root in
			var copy = root
			copy[keyPath: keyPath] = update(copy[keyPath: keyPath])
			return copy
		}
	}
}

func setProp<Root, Value>(_ keyPath: WritableKeyPath<Root, Value>, to newValue: Value) -> (Root) -> Root {
	{ root in
		var copy = root
		copy[keyPath: keyPath] = newValue
		return copy
	}
}
