
let array = [1, 3, 5, 8, 8, 7, 8, 0, 0, 0]

extension Array {
    func unique(by shouldSkip: (Element, Element) -> Bool) -> [Element] {
        return reduce(into: []) { result, nextElement in
            if result.last.map({ !shouldSkip($0, nextElement) }) ?? true {
                result.append(nextElement)
            }
        }
    }
}

extension Array where Element: Comparable {
    func unique() -> [Element] {
        return unique(by: { $0 == $1 })
    }
}


extension Sequence where Element: Hashable {
    func weightedSum<Weight>(weight: (Element) -> Weight, combine: (Weight, Weight) -> Weight) -> [Element: Weight] {
        return Dictionary(map { ($0, weight($0)) }, uniquingKeysWith: combine)
    }

    func frequency() -> [Element: Int] {
        return weightedSum(weight: { _ in 1 }, combine: +)
    }
}

array.unique()

"Lorem ipsum dolor.met".frequency()
