//
//  Day9Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day9Tests: XCTestCase {

    func testQuine() {
        let computer = IntcodeComputer()
        computer.program = [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99]
        var output = [Int]()
        computer.output = { output.append($0) }
        computer.run()
        XCTAssertEqual(computer.program, output)
    }
    
    func testExampleProgramShouldOutput16DigitNumber() {
        let computer = IntcodeComputer()
        computer.program = [1102,34915192,34915192,7,4,7,99,0]
        var result = 0
        computer.output = { result = $0 }
        
        computer.run()
        XCTAssertEqual(result, 1219070632396864)
    }
    func testExampleProgramShouldOutputBigNumber() {
        let computer = IntcodeComputer()
        computer.program = [104,1125899906842624,99]
        var result = 0
        computer.output = { result = $0 }
        
        computer.run()
        XCTAssertEqual(result, 1125899906842624)
    }
}
