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
        computer.run()
        XCTAssertEqual(computer.program, [109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99])
    }
    
    

}
