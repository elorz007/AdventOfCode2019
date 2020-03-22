//
//  Day9.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

class Day9: NSObject {

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

    func boostKeyCode() -> Int {
        runBoostComputer(withInput: 1)
    }

    func boostCoordinates() -> Int {
        runBoostComputer(withInput: 2)
    }

    func input() -> String {
        // swiftlint:disable force_try
        try! String(contentsOfFile: "./Day9.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }
}
