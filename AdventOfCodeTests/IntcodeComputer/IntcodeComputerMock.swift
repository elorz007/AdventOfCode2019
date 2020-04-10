//
//  IntcodeComputerMock.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

class IntcodeComputerMock: IntcodeComputer {
    var didRun = false
    var outputs = [Int]()
    var inputs = [Int]()
    var askForInput = 0

    override func run() {
        didRun = true
        for _ in 0..<askForInput {
            inputs.append(input!())
        }
        outputs.forEach { output!($0) }
    }
}
