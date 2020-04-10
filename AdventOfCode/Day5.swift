//
//  Day5.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 08.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

public class Day5: Day {
    public func finalOutput() -> Int {
        let computer = IntcodeComputer(program: input())
        computer.input = { 1 }
        var finalOutput = 0
        computer.output = { finalOutput = $0 }
        computer.run()
        return finalOutput
    }

    public func diagnosticCodeThermalRadiator() -> Int {
        let computer = IntcodeComputer(program: input())
        computer.input = { 5 }
        var output = 0
        computer.output = { output = $0 }
        computer.run()
        return output
    }
}
