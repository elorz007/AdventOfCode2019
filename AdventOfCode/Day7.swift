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
        var output: Int?
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
    var offset: Int
    var current: PhaseSettings?
    var swapCounter: [Int]
    var i: Int

    init(phaseSettingsLimit: UInt, offset: Int) {
        self.offset = offset
        n = phaseSettingsLimit
        swapCounter = [Int](repeating: 0, count: Int(phaseSettingsLimit))
        i = 0
    }

    func next() -> PhaseSettings? {
        if current == nil {
            current = Array(offset..<Int(n)+offset)
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
    static let `default` = PhaseSettingsLimit(n: 5)
    static let feedbackMode = PhaseSettingsLimit(n: 5, offset: 5)
    let n: UInt
    let offset: Int
    init(n: UInt, offset: Int = 0) {
        self.n = n
        self.offset = offset
    }
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
        self.generator = PhaseSettingGenerator(phaseSettingsLimit: combination.n, offset: combination.offset)
    }
    mutating func next() -> Element? {
        return self.generator.next()
    }
}

class Promise {
    let id: String
    init(id: String) {
        self.id = id
        lock = DispatchQueue(label: id)
    }
    let semaphore = DispatchSemaphore(value: 0)
    let lock: DispatchQueue
    var values: [Int] = []
    func pass(_ value: Int) {
        lock.sync {
            self.values.append(value)
        }
        semaphore.signal()
    }
    func next() -> Int {
        semaphore.wait()
        var next: Int = 0
        lock.sync {
            next = self.values.removeFirst()
        }
        return next
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
        let computer = createComputer()
        var amplifier = Amplifier(inputSignal: inputSignal, phaseSetting: phaseSetting, computer: computer)
        amplifier.run()
        return amplifier.output!
    }

    func findHighestSignalInFeedbackMode() -> Int {
        var highestSignal = Int.min
        PhaseSettingsLimit.feedbackMode.forEach { phaseSettings in
            let signal = self.runAmplifiersInFeedbackMode(phaseSettings: phaseSettings)
            highestSignal = max(signal, highestSignal)
        }
        return highestSignal
    }

    func runAmplifiersInFeedbackMode(phaseSettings: PhaseSettings) -> Int {
        let computerA = createComputer()
        let computerB = createComputer()
        let computerC = createComputer()
        let computerD = createComputer()
        let computerE = createComputer()

        let ea = Promise(id: "ea")
        let ab = Promise(id: "ab")
        let bc = Promise(id: "bc")
        let cd = Promise(id: "cd")
        let de = Promise(id: "de")

        self.connect(computerE, with: computerA, through: ea)
        self.connect(computerA, with: computerB, through: ab)
        self.connect(computerB, with: computerC, through: bc)
        self.connect(computerC, with: computerD, through: cd)
        self.connect(computerD, with: computerE, through: de)

        // Initial value is pased on special first input block
        ea.pass(phaseSettings[0])
        ab.pass(phaseSettings[1])
        bc.pass(phaseSettings[2])
        cd.pass(phaseSettings[3])
        de.pass(phaseSettings[4])

        // First input, given via already setup promise
        ea.pass(0)

        let group = DispatchGroup()
        self.runAsyncAmplifier(computer: computerA, in: group)
        self.runAsyncAmplifier(computer: computerB, in: group)
        self.runAsyncAmplifier(computer: computerC, in: group)
        self.runAsyncAmplifier(computer: computerD, in: group)
        self.runAsyncAmplifier(computer: computerE, in: group)
        group.wait()
        return ea.values.first!
    }

    func runAsyncAmplifier(computer: IntcodeComputer, in group: DispatchGroup) {
        group.enter()
        DispatchQueue.global(qos: .default).async {
            computer.run()
            group.leave()
        }
    }

    func connect(_ output: IntcodeComputer, with input: IntcodeComputer, through promise: Promise) {
        output.output = { promise.pass($0) }
        input.input = { promise.next() }
    }

    func input() -> String {
        // swiftlint:disable force_try
        try! String(contentsOfFile: "./Day7.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }

    lazy var inputCache = input()
    func read(input: String) -> Program {
        return input.split(separator: ",").map { Int(String($0))! }
    }
    func createComputer() -> IntcodeComputer {
        let computer = IntcodeComputer()
        computer.program = read(input: inputCache)
        return computer
    }
}
