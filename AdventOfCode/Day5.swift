//
//  Day5.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 08.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

class Day5: NSObject {
    func input() -> String {
        try! String(contentsOfFile: "./Day5.txt")
    }
    
    func inputProgram() -> Program {
        return input().split(separator:",").map {
            let s = String($0)
            let i = Int(s)!
            return i
        }
    }
    
    func finalOutput() -> Int {
        let computer = IntcodeComputer()
        computer.program = inputProgram()
        computer.input = { 1 }
        var finalOutput = 0
        computer.output = { output in
            finalOutput = output
        }
        computer.run()
        return finalOutput
    }
}
