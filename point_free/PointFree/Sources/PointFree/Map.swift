
func mapDic<K, V, W>(_ t: @escaping (V) -> W) -> ([K:V]) -> [K:W] {
    { dic in
        dic.mapValues(t)
    }
}

func r_first<A>(_ xs: [A]) -> A? {
    xs.first
}

func r_last<A>(_ xs: [A]) -> A? {
    xs.last
}

func r_nth<A>(_ n: Int) -> ([A]) -> A? {
    { xs in
        if xs.indices.contains(n) {
            return xs[n]
        } else {
            return nil
        }
    }
}

func maybe_map<A, B>(_ a: A) -> B? {
    nil
}


func rs<A, B>(_ f: (A) -> B, _ xs: [A]) -> B? {
    xs.map(maybe_map as (A) -> B?).first ?? nil
}
