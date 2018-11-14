//
//  main.swift
//  02_Sequence
//
//  Created by Vladislav Maltsev on 11.11.18.
//  Copyright © 2018 Vladislav Maltsev. All rights reserved.
//

import Foundation

struct RepeatingSequence<SequenceType: Sequence>: Sequence {
    typealias Iterator = RepeatingIterator

    struct RepeatingIterator: IteratorProtocol {
        typealias Element = SequenceType.Element

        private let sequence: SequenceType
        private var currentIterator: SequenceType.Iterator?

        init(_ sequence: SequenceType) {
            self.sequence = sequence
        }

        mutating func next() -> SequenceType.Element? {
            if let nextElement = currentIterator?.next() {
                return nextElement
            } else {
                currentIterator = sequence.makeIterator()
                return currentIterator?.next()
            }
        }
    }

    private let sequence: SequenceType

    init(_ sequence: SequenceType) {
        self.sequence = sequence
    }

    func makeIterator() -> RepeatingSequence<SequenceType>.RepeatingIterator {
        return RepeatingIterator(sequence)
    }
}

extension Sequence {
    func repeating() -> RepeatingSequence<Self> {
        return RepeatingSequence(self)
    }
}

for (index, item) in "Testing".repeating().enumerated() {
    if index > 100 {
        break
    }
    print(item)
}
