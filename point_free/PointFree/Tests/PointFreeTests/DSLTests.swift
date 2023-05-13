//
//  DSLTests.swift
//  
//
//  Created by Vladislav Maltsev on 13.05.2023.
//

import XCTest
@testable import PointFree

final class DSLTests: XCTestCase {
    func testDescription() throws {
        let expression = Expr.mul(.add(.int(2), .var("X")), .var("Y"))
        XCTAssertEqual(PointFree.description(expression), "((2) + (X)) * (Y)")
    }

    func testReduce() throws {
        let e1 = Expr.add(.int(1), .add(.int(2), .add(.int(3), .int(4))))
        XCTAssertEqual(reduce(e1), .int(10))

        let e2 = Expr.add(.var("X"), .add(.int(2), .add(.int(3), .int(4))))
        XCTAssertEqual(reduce(e2), .add(.var("X"), .int(9)))
        XCTAssertEqual(reduce(e2, env: ["X": .int(1)]), .int(10))
        XCTAssertEqual(reduce(e2, env: ["X": e1]), .int(19))
    }

    func testD() throws {
        let e1 = Expr.add(.var("X"), .var("X"))
        let d1 = D(e1, by: "X")
        XCTAssertEqual(reduce(d1), .int(2))

        let e2 = Expr.mul(.var("X"), .var("X"))
        let d2 = D(e2, by: "X")
        XCTAssertEqual(reduce(d2), .add(.mul(.int(1), .var("X")), .mul(.var("X"), .int(1))))

        let e3 = Expr.add(.mul(.var("X"), .int(5)), .add(.var("Y"), .mul(.var("X"), .var("X"))))
        let d3X = D(e3, by: "X")
        XCTAssertEqual(
            reduce(d3X),
            .add(
                .add(.int(5), .mul(.var("X"), .int(0))),
                .add(
                    .int(0),
                    .add(.mul(.int(1), .var("X")), .mul(PointFree.Expr.var("X"), .int(1)))
                )
            )
        )
    }
}
