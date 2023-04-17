//
//  ManyFacesOfZipPt1Tests.swift
//  
//
//  Created by Vladislav Maltsev on 17.04.2023.
//

import XCTest
@testable import PointFree

final class ManyFacesOfZipPt1Tests: XCTestCase {
    func testZipPairs() throws {
        let xs = [2, 3, 5, 7, 11, 13]
        let pairs = Array(zip(xs, xs.dropFirst()).map { "\($0)-\($1)" })
        XCTAssertEqual(pairs, ["2-3", "3-5", "5-7", "7-11", "11-13"])
    }

    func testZipOverOptionals() throws {
        func zip2<A, B>(a: A?, b: B?) -> (A, B)? {
            guard let a, let b else { return nil }
            return (a, b)
        }

        XCTAssertNil(zip2(a: 1, b: Optional<Int>.none))
        XCTAssertNil(zip2(a: Optional<Int>.none, b: 2))
        XCTAssertNotNil(zip2(a: 1, b: 2))
    }
}
