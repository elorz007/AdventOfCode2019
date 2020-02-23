//
//  Day5Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 08.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day5Tests: XCTestCase {

    func testInputInstructionWorks() {
        let computer = IntcodeComputer()
        computer.program = [3, 1, 3, 0, 99]
        computer.input = { 7 }
        computer.run()
        XCTAssertEqual(computer.program, [7, 7, 3, 0, 99])
    }

    func testOutputInstructionWorks() {
        let computer = IntcodeComputer()
        computer.program = [4, 0, 4, 4, 99]
        var results: [Int] = []
        computer.output = { results.append($0) }
        computer.run()
        XCTAssertEqual(results, [4, 99])
    }

    func testDirectParameterMode1Works() {
        let computer = IntcodeComputer()
        computer.program = [1002, 4, 3, 4, 33]
        computer.run()
        XCTAssertEqual(computer.program, [1002, 4, 3, 4, 99])
    }

    func testDirectParameterMode2Works() {
        let computer = IntcodeComputer()
        computer.program = [102, 33, 4, 4, 3]
        computer.run()
        XCTAssertEqual(computer.program, [102, 33, 4, 4, 99])
    }

    func testDirectParameterOutputWorks() {
        let computer = IntcodeComputer()
        computer.program = [104, 33, 99]
        var result: Int = 0
        computer.output = { result = $0 }
        computer.run()
        XCTAssertEqual(result, 33)
    }

    func testNegativeNumbersWork() {
        let computer = IntcodeComputer()
        computer.program = [1101, 100, -1, 4, 0]
        computer.run()
        XCTAssertEqual(computer.program, [1101, 100, -1, 4, 99])
    }

    func testStepsOfFastestIntersection() {
        let d5 = Day5()
        XCTAssertEqual(d5.finalOutput(), 16489636)
    }

    // MARK: -
    func testEqualPositionMode() {
        let program =  [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
        assert(program: program, witInput: 8, outputs: 1)
    }

    func testNotEqualPositionMode() {
        let program =  [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8]
        assert(program: program, witInput: 5, outputs: 0)
    }

    func testEqualImediateMode() {
        let program = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
        assert(program: program, witInput: 8, outputs: 1)
    }

    func testNotEqualImediateMode() {
        let program = [3, 3, 1108, -1, 8, 3, 4, 3, 99]
        assert(program: program, witInput: -8, outputs: 0)
    }

    func testLessThanPositionMode() {
        let program = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
        assert(program: program, witInput: -6, outputs: 1)
    }

    func testNotLessThanPositionMode() {
        let program = [3, 9, 7, 9, 10, 9, 4, 9, 99, -1, 8]
        assert(program: program, witInput: 8, outputs: 0)
    }

    func testLessThanImediateMode() {
        let program = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
        assert(program: program, witInput: 4, outputs: 1)
    }

    func testNotLessThanImediateMode() {
        let program = [3, 3, 1107, -1, 8, 3, 4, 3, 99]
        assert(program: program, witInput: 9, outputs: 0)
    }
    // MARK
    func test_SLOW_JumpsNonZeroPositionMode() {
        let program = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
        assert(program: program, witInput: 89, outputs: 1)
    }

    func testJumpsZeroPositionMode() {
        let program = [3, 12, 6, 12, 15, 1, 13, 14, 13, 4, 13, 99, -1, 0, 1, 9]
        assert(program: program, witInput: 0, outputs: 0)
    }

    func testJumpsNonZeroImmediateMode() {
        let program = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
        assert(program: program, witInput: 89, outputs: 1)
    }

    func testJumpsZeroImmediateMode() {
        let program = [3, 3, 1105, -1, 9, 1101, 0, 0, 12, 4, 12, 99, 1]
        assert(program: program, witInput: 0, outputs: 0)
    }

    func testLargerExampleBelow8() {
        let program = [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99]
        assert(program: program, witInput: 7, outputs: 999)
    }

    func testLargerExampleIs8() {
        let program = [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99]
        assert(program: program, witInput: 8, outputs: 1000)
    }

    func testLargerExampleIsAbove8() {
        let program = [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 0, 0, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99]
        assert(program: program, witInput: 108, outputs: 1001)
    }

    func assert(program: Program, witInput input: Int, outputs output: Int) {
        let computer = IntcodeComputer()
        computer.program = program
        computer.input = { input }
        var result: Int = 0
        computer.output = { result = $0 }
        computer.run()
        XCTAssertEqual(result, output)
    }

    // MARK: -
    func testDiagnosticCodeThermalRadiator() {
        let d5 = Day5()
        XCTAssertEqual(d5.diagnosticCodeThermalRadiator(), 9386583)
    }

}
