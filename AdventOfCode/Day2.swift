//
//  Day2.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

typealias InputClosure = () -> Int
typealias OutputClosure = (Int) -> Void
typealias Program = [Int]

enum ParameterMode {
    case Position
    case Inmediate
}

extension ParameterMode {
    init(_ value: Int) {
        switch value {
        case 0: self = .Position
        case 1: self = .Inmediate
        default: self = .Position
        }
    }
}

struct Address {
    let position: Int
    let mode: ParameterMode
}

struct BinaryInstructionDescription {
    let address1: Address
    let address2: Address
    let result: Address
}

struct Opcode {
    let position: Int
    let value: Int
    let mode1: ParameterMode
    let mode2: ParameterMode
    let mode3: ParameterMode
    
    init(position:Int, rawValue:Int) {
        self.position = position
        self.value = rawValue % 100
        mode1 = ParameterMode((rawValue / 100) % 2)
        mode2 = ParameterMode((rawValue / 1000) % 2)
        mode3 = ParameterMode((rawValue / 10000) % 2)
    }
}

extension Program {
    subscript (address: Address) -> Element {
        get {
            switch address.mode {
            case .Inmediate:
                return self[address.position]
            case .Position:
                return self[self[address.position]]
            }
        }
        set (value) {
            self[self[address.position]] = value
        }
    }
}

class IntcodeComputer: NSObject {
    var program: Program?
    var input: InputClosure?
    var output: OutputClosure?
    
    func executeBinary(_ opcode:Opcode, operation: (Int, Int) -> Int) {
        let address1 = Address(position:opcode.position + 1, mode: opcode.mode1)
        let address2 = Address(position:opcode.position + 2, mode: opcode.mode2)
        let result = Address(position:opcode.position + 3, mode: opcode.mode3)
        let description = BinaryInstructionDescription(address1: address1, address2: address2, result: result)
        executeBinary(description, operation:operation)
    }
    
    func executeBinary(_ description: BinaryInstructionDescription, operation: (Int, Int) -> Int) {
        if var program = self.program {
            let firstOperand = program[description.address1]
            let secondOperand = program[description.address2]
            let result = operation(firstOperand, secondOperand)
            program[description.result] = result
            self.program = program
        }
    }
    
    func executeInput(_ opcode: Opcode) {
        if var program = self.program, let input = input {
            let address = Address(position: opcode.position + 1, mode: opcode.mode1)
            program[address] = input()
            self.program = program
        }
    }
    
    func executeOutput(_ opcode: Opcode) {
        if let program = self.program, let output = output {
            let address = Address(position: opcode.position + 1, mode: opcode.mode1)
            output(program[address])
        }
    }
    
    func executeInstruction(at position:(Int)) -> Int {
        var instructionLength = 0
        let opcode = Opcode(position:position, rawValue:program![position])
        switch opcode.value {
        case 1:
            executeBinary(opcode, operation:+)
            instructionLength = 4
        case 2:
            executeBinary(opcode, operation:*)
            instructionLength = 4
        case 3:
            executeInput(opcode)
            instructionLength = 2
        case 4:
            executeOutput(opcode)
            instructionLength = 2
        default: break
        }
        return instructionLength
    }
    
    func run() {
        var instructionPointer = 0
        while program![instructionPointer] != 99 {
            let instructionLength = executeInstruction(at: instructionPointer)
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
    
    func findNounAndVerb() -> Int {
        let computer = IntcodeComputer()
        let initial = 0
        let limit = 99
        var noun = initial
        var verb = initial
        computer.program = inputProgram(noun: noun, verb: verb)
        computer.run()
        while (computer.program![0] != 19690720) {
            noun = noun + 1
            if noun > limit {
                noun = initial
                verb = verb + 1
            }
            computer.program = inputProgram(noun: noun, verb: verb)
            computer.run()
        }
        return 100 * noun + verb
    }
    
    func inputProgram(noun : Int = 12, verb : Int = 2) -> Program {
        var program = input().split { $0.isPunctuation }.map { Int(String($0))! }
        program[1] = noun
        program[2] = verb
        return program
    }
}
