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
        computer.program = [3,1,3,0,99]
        computer.input = { 7 }
        computer.run()
        XCTAssertEqual(computer.program, [7,7,3,0,99])
    }

    func testOutputInstructionWorks() {
        let computer = IntcodeComputer()
        computer.program = [4,0,4,4,99]
        var results:[Int] = []
        computer.output = { results.append($0) }
        computer.run()
        XCTAssertEqual(results, [4,99])
    }
    
    func testDirectParameterMode1Works() {
        let computer = IntcodeComputer()
        computer.program = [1002,4,3,4,33]
        computer.run()
        XCTAssertEqual(computer.program, [1002,4,3,4,99])
    }
    
    func testDirectParameterMode2Works() {
        let computer = IntcodeComputer()
        computer.program = [102,33,4,4,3]
        computer.run()
        XCTAssertEqual(computer.program, [102,33,4,4,99])
    }
    
    func testDirectParameterOutputWorks() {
        let computer = IntcodeComputer()
        computer.program = [104,33,99]
        var result: Int = 0
        computer.output = { result = $0 }
        computer.run()
        XCTAssertEqual(result, 33)
    }
    
    func testNegativeNumbersWork() {
        let computer = IntcodeComputer()
        computer.program = [1101,100,-1,4,0]
        computer.run()
        XCTAssertEqual(computer.program, [1101,100,-1,4,99])
    }
    
    func testStepsOfFastestIntersection() {
        let d5 = Day5()
        XCTAssertEqual(d5.finalOutput(), 16489636)
    }
}
