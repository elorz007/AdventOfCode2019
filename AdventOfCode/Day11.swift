//
//  Day11.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 02.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

typealias PanelColor = Color

typealias Panels = [Position: PanelColor]

struct PaintingOutput {
    let color: PanelColor
    let rotation: Rotation
    init?(raw: [Int]) {
        guard let color = PanelColor(rawValue: raw[0]) else {
            return nil
        }
        guard let rotation = Rotation(rawValue: raw[1]) else {
            return nil
        }
        self.color = color
        self.rotation = rotation
    }
}

class PaintingRobot {
    init(computer: IntcodeComputer) {
        self.computer = computer
    }

    let computer: IntcodeComputer
    var currentPosition = Position(x: 0, y: 0)
    var currentDirection = Direction.up
    var panels = Panels()

    func run() {
        panels[currentPosition] = .black
        self.computer.input = rawInput
        self.computer.output = rawOutput
        self.computer.run()
    }

    var coveredArea: Int {
        panels.count
    }

    func rawInput() -> Int {
        self.input().rawValue
    }

    func input() -> PanelColor {
        if let currentColor = self.panels[self.currentPosition] {
            return currentColor
        } else {
            return .black
        }
    }

    var gatheredOutput = [Int]()
    let gatheredOutputSize = 2
    func rawOutput(_ out: Int) {
        self.gatheredOutput.append(out)
        if self.gatheredOutput.count == self.gatheredOutputSize {
            if let paintingOutput = PaintingOutput(raw: self.gatheredOutput) {
                self.output(paintingOutput)
            }
            self.gatheredOutput.removeAll()
        }
    }

    func output(_ output: PaintingOutput) {
        switch output.color {
        case .white:
//            self.panels.removeValue(forKey: self.currentPosition)
            self.panels[self.currentPosition] = .white
        case .black:
            self.panels[self.currentPosition] = .black
        case .transparent:
            break
        }

        self.currentDirection.rotate(output.rotation)
        self.currentPosition.advance(in: self.currentDirection)
    }
}

class Day11: NSObject {
    func input() -> String {
        // swiftlint:disable force_try
        try! String(contentsOfFile: "./Day11.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }

    func coveredArea() -> Int {
        let computer = IntcodeComputer(program: input())
        let robot = PaintingRobot(computer: computer)
        robot.run()
        return robot.coveredArea
    }
}
