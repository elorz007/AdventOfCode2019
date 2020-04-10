//
//  IntcodeMachineTests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

struct ResultMock: RawParsable, Equatable {
    static var size: Int { 3 }
    let raw: [Int]
    init?(raw: [Int]) {
        self.raw = raw
    }
}

class AscendingInputIntcodeMachine<Result>: IntcodeMachine<Result> where Result: RawParsable {
    var current = 0
    override func input() -> Int {
        current += 1
        return current
    }
}

class GatheringIntcodeMachine<Result>: IntcodeMachine<Result> where Result: RawParsable {
    var results = [Result]()
    override func output(_ result: Result) {
        results.append(result)
    }
}

class IntcodeMachineTests: XCTestCase {

    func testWhenIntcodeMachineRunsThenIntcodeComputerRuns() {
        let computer = IntcodeComputerMock()
        let machine = IntcodeMachine<ResultMock>(computer: computer)
        machine.run()
        XCTAssertTrue(computer.didRun)
    }

    func testWhenComputerOuputsThenOneResultIsGathered() {
        let raw = [1, 2, 3]
        let expected = ResultMock(raw: raw)
        let machine = runMachineWith(output: raw)
        XCTAssertEqual(machine.results.first!, expected)
    }

    func testWhenComputerOutputsThenManyResultsAreGathered() {
        let expected1 = ResultMock(raw: [1, 2, 3])
        let expected2 = ResultMock(raw: [4, 5, 6])
        let expected3 = ResultMock(raw: [7, 8, 9])
        let machine = runMachineWith(output: [1, 2, 3, 4, 5, 6, 7, 8, 9])
        XCTAssertEqual(machine.results[0], expected1)
        XCTAssertEqual(machine.results[1], expected2)
        XCTAssertEqual(machine.results[2], expected3)
    }

    func runMachineWith(output: [Int]) -> GatheringIntcodeMachine<ResultMock> {
        let computer = IntcodeComputerMock()
        computer.outputs = output
        let machine = GatheringIntcodeMachine<ResultMock>(computer: computer)
        machine.run()
        return machine
    }

    func testWhenComputerAsksForOneInputThenItIsGiven() {
        let computer = IntcodeComputerMock()
        computer.askForInput = 1
        let machine = AscendingInputIntcodeMachine<ResultMock>(computer: computer)
        machine.run()
        XCTAssertEqual(computer.inputs.first!, 1)
    }

    func testWhenComputerAsksForManyInputesThenTheyAreGiven() {
        let computer = IntcodeComputerMock()
        computer.askForInput = 10
        let machine = AscendingInputIntcodeMachine<ResultMock>(computer: computer)
        machine.run()
        XCTAssertEqual(computer.inputs, Array(1...10))
    }
}
