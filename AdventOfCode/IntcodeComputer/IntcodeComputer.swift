//
//  IntcodeComputer.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

typealias InputClosure = () -> Int
typealias OutputClosure = (Int) -> Void
typealias Program = [Int]
typealias ExecutionPointer = Int
typealias DynamicMemory = [Int: Int]

class IntcodeComputer: NSObject {
    var program: Program?
    var input: InputClosure?
    var output: OutputClosure?
    var dynamicMemory = DynamicMemory()
    var relativeBase: Int = 0
    var executionPointer: ExecutionPointer = 0

    fileprivate func executeBinary(_ opcode: Opcode, operation: (Int, Int) -> Int) {
        let address1 = Address(position: opcode.position + 1, relativeBase: relativeBase, mode: opcode.mode1)
        let address2 = Address(position: opcode.position + 2, relativeBase: relativeBase, mode: opcode.mode2)
        let result = Address(position: opcode.position + 3, relativeBase: relativeBase, mode: opcode.mode3)
        let description = BinaryInstructionDescription(address1: address1, address2: address2, result: result)
        executeBinary(description, operation: operation)
    }

    fileprivate func executeBinary(_ description: BinaryInstructionDescription, operation: (Int, Int) -> Int) {
        let firstOperand = self.value(at: description.address1)
        let secondOperand = self.value(at: description.address2)
        let result = operation(firstOperand, secondOperand)
        self.set(result, at: description.result)
        executionPointer += 4
    }

    fileprivate func executeInput(_ opcode: Opcode) {
        if let input = input {
            let address = Address(position: opcode.position + 1, relativeBase: relativeBase, mode: opcode.mode1)
            let value = input()
            self.set(value, at: address)
        }
        executionPointer += 2
    }

    fileprivate func executeOutput(_ opcode: Opcode) {
        if let output = output {
            let address = Address(position: opcode.position + 1, relativeBase: relativeBase, mode: opcode.mode1)
            let value = self.value(at: address)
            output(value)
        }
        executionPointer += 2
    }

    fileprivate func executeJump(_ opcode: Opcode, condition: (Int) -> Bool) {
        var newExecutionPointer = opcode.position
        let valuePosition = opcode.position + 1
        let valueAddress = Address(position: valuePosition, relativeBase: relativeBase, mode: opcode.mode1)
        let value = self.value(at: valueAddress)
        if condition(value) {
            let newPosition = opcode.position + 2
            let newPointerAddress = Address(position: newPosition, relativeBase: relativeBase, mode: opcode.mode2)
            newExecutionPointer = self.value(at: newPointerAddress)
        } else {
            newExecutionPointer += 3
        }
        executionPointer = newExecutionPointer
    }

    fileprivate func executeRelativeBaseAdjust(_ opcode: Opcode) {
        let address = Address(position: opcode.position + 1, relativeBase: relativeBase, mode: opcode.mode1)
        let value = self.value(at: address)
        self.relativeBase += value
        executionPointer += 2
    }

    fileprivate func value(at position: Int) -> Int {
        if position < program!.count {
            return program![position]
        } else {
            return dynamicMemory[position] ?? 0
        }
    }

    fileprivate func set(_ value: Int, at position: Int) {
        if position < program!.count {
            program![position] = value
        } else {
            dynamicMemory[position] = value
        }
    }

    fileprivate func value(at address: Address) -> Int {
        switch address.mode {
        case .Inmediate:
            return self.value(at: address.position)
        case .Position:
            return self.value(at: self.value(at: address.position))
        case .Relative:
            return self.value(at: self.value(at: address.position) + address.relativeBase)
        }
    }

    fileprivate func set(_ value: Int, at address: Address) {
        switch address.mode {
        case .Inmediate:
            assertionFailure("Address in immediate mode cannot be used to set")
        case .Position:
            self.set(value, at: self.value(at: address.position))
        case .Relative:
            self.set(value, at: self.value(at: address.position) + address.relativeBase)
        }
    }

    fileprivate func executeInstruction() {
        let opcode = Opcode(position: executionPointer, rawValue: value(at: executionPointer))
        switch opcode.value {
        case 1:
            executeBinary(opcode, operation: +)
        case 2:
            executeBinary(opcode, operation: *)
        case 3:
            executeInput(opcode)
        case 4:
            executeOutput(opcode)
        case 5:
            executeJump(opcode) { $0 != 0 }
        case 6:
            executeJump(opcode) { $0 == 0 }
        case 7:
            executeBinary(opcode) { $0 < $1 ? 1 : 0 }
        case 8:
            executeBinary(opcode) { $0 == $1 ? 1 : 0 }
        case 9:
            executeRelativeBaseAdjust(opcode)
        default:
            assertionFailure("Unknown opcode value")
        }
    }

    func run() {
        executionPointer = 0
        while value(at: executionPointer) != 99 {
            executeInstruction()
        }
    }
}

private struct Address {
    let position: Int
    let relativeBase: Int
    let mode: ParameterMode
}

private struct BinaryInstructionDescription {
    let address1: Address
    let address2: Address
    let result: Address
}

extension IntcodeComputer {
    convenience init(program: String) {
        self.init()
        self.program = program.split(separator: ",").map { Int(String($0))! }
    }
}
