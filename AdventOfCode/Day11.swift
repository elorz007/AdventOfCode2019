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

struct PaintingOutput: RawParsable {
    static var size: Int { 2 }
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

class PaintingRobot: IntcodeMachine<PaintingOutput> {
    var currentPosition = Position(x: 0, y: 0)
    var currentDirection = Direction.up
    var panels = Panels()

    init(computer: IntcodeComputer, initialColor: Color = .black) {
        super.init(computer: computer)
        self.panels[self.currentPosition] = initialColor
    }

    override func input() -> Int {
        self.inputColor().rawValue
    }

    func inputColor() -> PanelColor {
        if let currentColor = self.panels[self.currentPosition] {
            return currentColor
        } else {
            return .black
        }
    }

    override func output(_ output: PaintingOutput) {
        switch output.color {
        case .white:
            self.panels[self.currentPosition] = .white
        case .black:
            self.panels[self.currentPosition] = .black
        case .transparent:
            break
        }

        self.currentDirection.rotate(output.rotation)
        self.currentPosition.advance(in: self.currentDirection)
    }

    var coveredArea: Int {
        panels.count
    }
}

extension Panels {
    var description: String {
        let panels = self
        let allX = panels.keys.map { $0.x }
        guard let minX = allX.min(), let maxX = allX.max() else {
            return ""
        }
        let allY = panels.keys.map { $0.y }
        guard let minY = allY.min(), let maxY = allY.max() else {
            return ""
        }

        var result = ""
        for y in (minY...maxY).reversed() {
            for x in minX...maxX {
                let position = Position(x: x, y: y)
                let color = panels[position] ?? .black
                result += color.description
                result += x == maxX ? "\n" : ""
            }
        }
        return result
    }
}

public class Day11: Day {
    public func coveredArea() -> Int {
        let computer = IntcodeComputer(program: input())
        let robot = PaintingRobot(computer: computer)
        robot.run()
        return robot.coveredArea
    }

    public func paintRegistrationIdentifier() {
        print(registrationIdentifierPanels().description)
    }

    func registrationIdentifierPanels() -> Panels {
        let computer = IntcodeComputer(program: input())
        let robot = PaintingRobot(computer: computer)
        robot.panels[robot.currentPosition] = .white
        robot.run()
        return robot.panels
    }
}
