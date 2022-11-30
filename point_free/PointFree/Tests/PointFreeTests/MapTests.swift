import XCTest
@testable import PointFree

import XCTest
@testable import PointFree

final class MapTests: XCTestCase {
    func testDictMap() throws {
        let testData = [
            1: "1",
            2: "2",
            3: "3"
        ]

        func addPar(_ str: String) -> String {
            "(\(str))"
        }

        let addParToDic: ([Int:String]) -> [Int:String] = mapDic(addPar)
        let result = testData |> addParToDic

        XCTAssertEqual(result, [
            1: "(1)",
            2: "(2)",
            3: "(3)"
        ])

        let lengthToDic: ([Int:String]) -> [Int:Int] = mapDic(\.count)
        let result2 = testData |> lengthToDic

        XCTAssertEqual(result2, [
            1: 1,
            2: 1,
            3: 1
        ])

        let identity = get(\String.self)
        let identityToDic: ([Int:String]) -> [Int:String] = mapDic(identity)
        let result3 = testData |> identityToDic

        XCTAssertEqual(result3, testData)
    }

    
}
