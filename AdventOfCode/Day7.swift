//
//  Day7.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 15.01.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Amplifier {
    let inputSignal: Int
    let phaseSetting: Int
    var output: Int?
    let computer: IntcodeComputer
    mutating func run() {
        var inputs = [phaseSetting, inputSignal]
        computer.input = { inputs.removeFirst() }
        var output:Int? = nil
        computer.output = {
            output = $0
        }
        computer.run()
        self.output = output
    }
}

typealias PhaseSetting = Int
typealias PhaseSettings = [PhaseSetting]



class PhaseSettingGenerator {
    let n: UInt
    var current: PhaseSettings?
    var swapCounter:[Int]
    var i:Int
    init(phaseSettingsLimit: UInt) {
        n = phaseSettingsLimit
        swapCounter = [Int](repeating: 0, count: Int(phaseSettingsLimit))
        i = 0
    }
    func next() -> PhaseSettings? {
        if current == nil {
            current = Array(0..<Int(n))
            return current
        } else {
            while i < n {
                if swapCounter[i] < i {
                    if i % 2 == 0 {
                        current!.swapAt(0, i)
                    } else {
                        current!.swapAt(swapCounter[i], i)
                    }
                    swapCounter[i] += 1
                    i = 0
                    return current
                } else {
                    swapCounter[i] = 0
                    i += 1
                }
            }
            return nil
        }
    }
}

struct PhaseSettingsLimit {
    static let `default` = PhaseSettingsLimit(n:5)
    let n: UInt
}

extension PhaseSettingsLimit {
    func all() -> Set<PhaseSettings> {
        var all = Set<PhaseSettings>()
        self.forEach {
            all.insert($0)
        }
        return all
    }
}

extension PhaseSettingsLimit: Sequence {
    typealias Element = PhaseSettings
    typealias Iterator = PhaseSettingsCombinationIterator
    func makeIterator() -> Iterator {
        return PhaseSettingsCombinationIterator(self)
    }
}

struct PhaseSettingsCombinationIterator: IteratorProtocol {
    typealias Element = PhaseSettings
    let generator: PhaseSettingGenerator
    init(_ combination: PhaseSettingsLimit) {
        self.generator = PhaseSettingGenerator(phaseSettingsLimit:combination.n)
    }
    mutating func next() -> Element? {
        return self.generator.next()
    }
}


class Day7: NSObject {
    func findHighestSignal() -> Int {
        var highestSignal = Int.min
        PhaseSettingsLimit.default.forEach { phaseSettings in
            let initialInput = 0
            let outputA = runAmplifier(inputSignal: initialInput, phaseSetting: phaseSettings[0])
            let outputB = runAmplifier(inputSignal: outputA, phaseSetting: phaseSettings[1])
            let outputC = runAmplifier(inputSignal: outputB, phaseSetting: phaseSettings[2])
            let outputD = runAmplifier(inputSignal: outputC, phaseSetting: phaseSettings[3])
            let signal = runAmplifier(inputSignal: outputD, phaseSetting: phaseSettings[4])
            highestSignal = max(signal, highestSignal)
        }
        return highestSignal
    }
    
    func runAmplifier(inputSignal: Int, phaseSetting: Int) -> Int {
        let computer = IntcodeComputer()
        computer.program = createInputProgram()
        var amplifier = Amplifier(inputSignal:inputSignal, phaseSetting:phaseSetting, computer: computer)
        amplifier.run()
        return amplifier.output!
    }
    
    func input() -> String {
        try! String(contentsOfFile: "./Day7.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    lazy var inputProgramCache: Program = readInputProgram()
    
    func readInputProgram() -> Program {
        return input().split(separator:",").map { Int(String($0))! }
    }
    func createInputProgram() -> Program {
        let copyInputProgram = inputProgramCache
        return copyInputProgram
    }
}

