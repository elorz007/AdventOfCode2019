//
//  Day9.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa



class Day9: NSObject {
    
    func boostKeyCode() -> Int {
        let computer = IntcodeComputer()
        computer.program = read(input: input())
        computer.input = {
            return 1
        }
        var result = 0
        computer.output = { result = $0 }
        computer.run()
        return result
    }
    
    func input() -> String {
        try! String(contentsOfFile: "./Day9.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    func read(input: String) -> Program {
        return input.split(separator:",").map { Int(String($0))! }
    }
}
