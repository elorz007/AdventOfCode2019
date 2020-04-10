//
//  IntcodeMachine.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

public protocol RawParsable {
    static var size: Int { get }
    init?(raw: [Int])
}

public class IntcodeMachine<Result> where Result: RawParsable {
    fileprivate let computer: IntcodeComputer

    init(computer: IntcodeComputer) {
        self.computer = computer
    }

    public func run() {
        computer.output = rawOutput
        computer.input = input
        computer.run()
    }

    var gatheredOutput = [Int]()
    fileprivate func rawOutput(_ out: Int) {
        self.gatheredOutput.append(out)
        if self.gatheredOutput.count == Result.size {
            if let result = Result(raw: self.gatheredOutput) {
                self.output(result)
            }
            self.gatheredOutput.removeAll()
        }
    }

    public func output(_ result: Result) {
        // Should be overridden by subclasses
    }

    public func input() -> Int {
        // Should be overridden by subclasses
        return 0
    }
}
