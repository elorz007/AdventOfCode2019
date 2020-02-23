//
//  Day1Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day1Tests: XCTestCase {

    func testMass12() {
        let calculator = FuelCalculator()
        let result = calculator.fuel(mass: 12)
        XCTAssertEqual(result, 2)
    }

    func testMass14() {
        let calculator = FuelCalculator()
        let result = calculator.fuel(mass: 14)
        XCTAssertEqual(result, 2)
    }
    func testMass1969() {
        let calculator = FuelCalculator()
        let result = calculator.fuel(mass: 1969)
        XCTAssertEqual(result, 654)
    }
    func testMass100756() {
        let calculator = FuelCalculator()
        let result = calculator.fuel(mass: 100756)
        XCTAssertEqual(result, 33583)
    }

    func testFuelOfFuelForMass14IsZero() {
        let calculator = FuelCalculator()
        let fuelMass = calculator.fuel(mass: 14)
        let fuelForFuelMass = calculator.fuel(mass: fuelMass)
        XCTAssertEqual(fuelForFuelMass, 0)
    }

    func testRealFuelForMass14() {
        let calculator = FuelCalculator()
        let result = calculator.realFuel(mass: 14)
        XCTAssertEqual(result, 2)
    }

    func testRealFuelForMass1969() {
        let calculator = FuelCalculator()
        let result = calculator.realFuel(mass: 1969)
        XCTAssertEqual(result, 966)
    }

    func testRealFuelForMass100756() {
        let calculator = FuelCalculator()
        let result = calculator.realFuel(mass: 100756)
        XCTAssertEqual(result, 50346)
    }

    func testInputIsFetched() {
        let d = Day1()
        let input = d.input()
        XCTAssertTrue(input.hasPrefix("139936"))
        XCTAssertTrue(input.hasSuffix("110806\n"))
    }

    func testInputHas100Masses() {
        let d = Day1()
        let allMasses = d.allMasses()
        XCTAssertEqual(allMasses.count, 100)
    }

    func testTotalFuelConsuptionIsGreaterThan0() {
        let d = Day1()
        let totalFuel = d.totalFuel()
        XCTAssertGreaterThan(totalFuel, 0)
    }

    func testTotalFuelConsuptionIsCalculated() {
        let d = Day1()
        let totalFuel = d.totalFuel()
        XCTAssertEqual(totalFuel, 3325347)
    }

    func testTotalRealFuelConsuptionIsGreaterThanTotalFuel() {
        let d = Day1()
        let totalFuel = d.totalFuel()
        let totalRealFuel = d.totalRealFuel()
        XCTAssertGreaterThan(totalRealFuel, totalFuel)
    }

    func testTotalRealFuelConsuptionIsCalculated() {
        let d = Day1()
        let totalRealFuel = d.totalRealFuel()
        XCTAssertEqual(totalRealFuel, 4985145)
    }

}
