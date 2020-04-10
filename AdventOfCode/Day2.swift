//
//  Day2.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

public class Day2: Day {
    override func input() -> String {
        // swiftlint:disable line_length
        return "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,19,10,23,2,10,23,27,1,27,6,31,1,13,31,35,1,13,35,39,1,39,10,43,2,43,13,47,1,47,9,51,2,51,13,55,1,5,55,59,2,59,9,63,1,13,63,67,2,13,67,71,1,71,5,75,2,75,13,79,1,79,6,83,1,83,5,87,2,87,6,91,1,5,91,95,1,95,13,99,2,99,6,103,1,5,103,107,1,107,9,111,2,6,111,115,1,5,115,119,1,119,2,123,1,6,123,0,99,2,14,0,0"
        // swiftlint:enable line_length
    }

    public func restoredState() -> Int {
        let computer = IntcodeComputer()
        computer.program = inputProgram()
        computer.run()
        return computer.program![0]
    }

    public func findNounAndVerb() -> Int {
        let computer = IntcodeComputer()
        let initial = 0
        let limit = 99
        var noun = initial
        var verb = initial
        computer.program = inputProgram(noun: noun, verb: verb)
        computer.run()
        while computer.program![0] != 19690720 {
            noun += 1
            if noun > limit {
                noun = initial
                verb += 1
            }
            computer.program = inputProgram(noun: noun, verb: verb)
            computer.run()
        }
        return 100 * noun + verb
    }

    func inputProgram(noun: Int = 12, verb: Int = 2) -> Program {
        var program = input().split { $0.isPunctuation }.map { Int(String($0))! }
        program[1] = noun
        program[2] = verb
        return program
    }
}
