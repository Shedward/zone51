//
//  Func.swift
//  
//
//  Created by Vladislav Maltsev on 18.04.2023.
//

struct Func<A, R> {
    let apply: (A) -> R
}

struct AsyncAction<A> {
    let run: (@escaping (A) -> Void) -> Void
}

func map<A, B>(_ t: @escaping (A) -> B) -> (AsyncAction<A>) -> AsyncAction<B> {
    return { asyncAction in
        return AsyncAction { callback in
            asyncAction.run { callback(t($0)) }
        }
    }
}
