//
//  Day2Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day2Tests: XCTestCase {

    func testWhenCalculatorHasAddInstructionThenItDoesIt() {
        let computer = IntcodeComputer()
        computer.program = [1, 0, 0, 0, 99]
        computer.run()
        XCTAssertEqual(computer.program, [2, 0, 0, 0, 99])
    }

    func testWhenCalculatorHasMultiplyInstructionThenDoestIt() {
        let computer = IntcodeComputer()
        computer.program = [2, 3, 0, 3, 99]
        computer.run()
        XCTAssertEqual(computer.program, [2, 3, 0, 6, 99])
    }

    func testWhenResultIsOutsideItIsCalculated() {
        let computer = IntcodeComputer()
        computer.program = [2, 4, 4, 5, 99, 0]
        computer.run()
        XCTAssertEqual(computer.program, [2, 4, 4, 5, 99, 9801])
    }

    func testWhenCalculatorHasMultipleInstructionThenTheyAreComputed() {
        let computer = IntcodeComputer()
        computer.program = [1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50]
        computer.run()
        XCTAssertEqual(computer.program, [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50])
    }

    func testWhenProgramModifiesItsOwnHaltCondition() {
        let computer = IntcodeComputer()
        computer.program = [1, 1, 1, 4, 99, 5, 6, 0, 99]
        computer.run()
        XCTAssertEqual(computer.program, [30, 1, 1, 4, 2, 5, 6, 0, 99])
    }

    func testInputContainsHalt() {
        let d = Day2()
        let program = d.inputProgram()
        XCTAssertTrue(program.contains(99))
    }

    func testRunningInputProgramChangesTheResult() {
        let d = Day2()
        let program = d.inputProgram()
        let restored = d.restoredState()
        XCTAssertNotEqual(program[0], restored)
    }

    func testRunningInputProgramResultsIn4090701() {
        let d = Day2()
        let restored = d.restoredState()
        XCTAssertEqual(4090701, restored)
    }

    func test_SLOW_NounAndVerbCanBeSearched() {
        let d = Day2()
        let noundAndVerb = d.findNounAndVerb()
        XCTAssertEqual(6421, noundAndVerb)
    }
}
