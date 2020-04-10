//
//  Day9.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

public class Day9: Day {

    func runBoostComputer(withInput value: Int) -> Int {
        let computer = IntcodeComputer(program: input())
        computer.input = {
            return value
        }
        var result = 0
        computer.output = { result = $0 }
        computer.run()
        return result
    }

    public func boostKeyCode() -> Int {
        runBoostComputer(withInput: 1)
    }

    public func boostCoordinates() -> Int {
        runBoostComputer(withInput: 2)
    }
}
