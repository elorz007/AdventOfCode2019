//
//  Day11Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 02.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day11Tests: XCTestCase {

    func testWhenColorIsBlackThenBinaryIs0() {
        XCTAssertEqual(PanelColor.black.binary, 0)
    }

    func testWhenColorIsWhiteThenBinaryIs1() {
        XCTAssertEqual(PanelColor.white.binary, 1)
    }
}
