//
//  Day2.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

class IntcodeComputer: NSObject {
    var program: [Int]?
    
    func executeBinary(operation: (Int, Int) -> Int, at position: Int) {
        if var program = self.program {
            let firstOperandPosition = program[position + 1]
            let secondOperandPosition = program[position + 2]
            let resultPosition = program[position + 3]
            let firstOperand = program[firstOperandPosition]
            let secondOperand = program[secondOperandPosition]
            let result = operation(firstOperand, secondOperand)
            program[resultPosition] = result
            self.program = program
        }
    }
    
    func executeInstruction(at position:(Int)) {
        switch program![position] {
        case 1:
            executeBinary(operation: +, at:position)
        case 2:
            executeBinary(operation: *, at:position)
        default: break
        }
    }
    
    func run() {
        let instructionLength = 4
        var instructionPointer = 0
        while self.program![instructionPointer] != 99 {
            executeInstruction(at: instructionPointer)
            instructionPointer = instructionPointer + instructionLength
        }
    }
}

class Day2: NSObject {
    func input() -> String {
        return "1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,13,1,19,1,19,10,23,2,10,23,27,1,27,6,31,1,13,31,35,1,13,35,39,1,39,10,43,2,43,13,47,1,47,9,51,2,51,13,55,1,5,55,59,2,59,9,63,1,13,63,67,2,13,67,71,1,71,5,75,2,75,13,79,1,79,6,83,1,83,5,87,2,87,6,91,1,5,91,95,1,95,13,99,2,99,6,103,1,5,103,107,1,107,9,111,2,6,111,115,1,5,115,119,1,119,2,123,1,6,123,0,99,2,14,0,0"
    }
    
    func restoredState() -> Int {
        let computer = IntcodeComputer()
        computer.program = inputProgram()
        computer.run()
        return computer.program![0]
    }
    
    func inputProgram() -> [Int] {
        var program = input().split { $0.isPunctuation }.map { Int(String($0))! }
        program[1] = 12
        program[2] = 2
        return program
    }
}
