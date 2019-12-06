//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day1Tests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testMass12() {
        let calculator = FuelCalculator();
        let result = calculator.fuel(mass: 12)
        XCTAssertEqual(result, 2)
    }

    func testMass14() {
        let calculator = FuelCalculator();
        let result = calculator.fuel(mass: 14)
        XCTAssertEqual(result, 2)
    }
    func testMass1969() {
        let calculator = FuelCalculator();
        let result = calculator.fuel(mass: 1969)
        XCTAssertEqual(result, 654)
    }
    func testMass100756() {
        let calculator = FuelCalculator();
        let result = calculator.fuel(mass: 100756)
        XCTAssertEqual(result, 33583)
    }
    
    func testInputIsFetched() {
        let d = Day1()
        let input = d.fetchInput()!
        XCTAssertTrue(input.hasPrefix("90149"))
        XCTAssertTrue(input.hasSuffix("110806"))
    }
    
}
