//
//  FloydWarshallTests.swift
//
//
//  Created by Jerome Bach on 29/10/2023.
//

import XCTest
@testable import SwiftGraph

final class FloydWarshallTests: XCTestCase {
    func testExample() throws {
        let a: [[Int?]] = [
            [nil,2,7],
            [2,nil,3],
            [7,3,nil]
        ]
        let b: [[Int?]] = [
            [nil,2,5],
            [2,nil,3],
            [5,3,nil]
        ]
        let c: [[Int?]] = [
            [nil,2,1],
            [2,nil,3],
            [1,3,nil]
        ]
        let (d, e) = FloydWarshall.plusCourtChMatriciel(G: a)
        XCTAssertEqual(b, d)
        XCTAssertEqual(c, e)
    }
}

