//
//  ManyFacesOfZipPt1.swift
//  
//
//  Created by Vladislav Maltsev on 17.04.2023.
//

import Foundation

func zip2<A, B>(_ a: [A], _ b: [B]) -> [(A, B)] {
    (0..<min(a.count, b.count)).map { indx in (a[indx], b[indx]) }
}

func zip2<A, B, R>(with t: @escaping (A, B) -> R) -> ([A], [B]) -> [R] {
    { a, b in zip2(a, b).map(t) }
}

func zip3<A, B, C>(_ a: [A], _ b: [B], _ c: [C]) -> [(A, B, C)] {
    zip2(a, zip2(b, c)).map(unpack)
}

func zip3<A, B, C, R>(with t: @escaping (A, B, C) -> R) -> ([A], [B], [C]) -> [R] {
    { a, b, c in zip3(a, b, c).map(t) }
}

func zip4<A, B, C, D>(_ a: [A], _ b: [B], _ c: [C], _ d: [D]) -> [(A, B, C, D)] {
    zip2(a, zip2(b, zip2(c, d))).map(unpack)
}

func zip2<A, B>(a: A?, b: B?) -> (A, B)? {
    guard let a, let b else { return nil }
    return (a, b)
}

func unpack<A, B, C>(_ t: (A, (B, C))) -> (A, B, C) {
    (t.0, t.1.0, t.1.1)
}

func unpack<A, B, C, D>(_ t: (A, (B, (C, D)))) -> (A, B, C, D) {
    (t.0, t.1.0, t.1.1.0, t.1.1.1)
}

func zip2<A, B, Failure: Error>(_ a: Result<A, Failure>, _ b: Result<B, Failure>) -> Result<(A, B), Failure> {
    switch (a, b) {
    case (.success(let aRes), .success(let bRes)):
        return .success((aRes, bRes))
    case (.failure(let aFail), .success):
        return .failure(aFail)
    case (.success, .failure(let bFail)):
        return .failure(bFail)
    case (.failure(let aFail), .failure):
        return .failure(aFail)
    }
}

func zip2<A, B, X>(_ x2a: Func<X, A>, _ x2b: Func<X, B>) -> Func<X, (A, B)> {
    Func { x in
        (x2a.apply(x), x2b.apply(x))
    }
}

func zip2seq<A, B>(_ x2a: AsyncAction<A>, _ x2b: AsyncAction<B>) -> AsyncAction<(A, B)> {
    AsyncAction { callback in
        x2a.run { resultA in
            x2b.run { resultB in
                callback((resultA, resultB))
            }
        }
    }
}

func zip2par<A, B>(_ x2a: AsyncAction<A>, _ x2b: AsyncAction<B>) -> AsyncAction<(A, B)> {
    AsyncAction { callback in
        var a: A?
        var b: B?

        x2a.run { resultA in
            a = resultA
            if let b = b { callback((resultA, b))}
        }
        x2b.run { resultB in
            b = resultB
            if let a = a { callback((a, resultB))}
        }
    }
}
