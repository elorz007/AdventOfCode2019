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
        let computer = IntcodeComputer()
        computer.program = read(input: input())
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
        try! String(contentsOfFile: "./Day9.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    func read(input: String) -> Program {
        return input.split(separator:",").map { Int(String($0))! }
    }
}
