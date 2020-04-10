//
//  Day13.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

public enum ArcadeTileType: Int {
    case empty = 0
    case wall = 1
    case block = 2
    case paddle = 3
    case ball = 4
}

public struct ArcadeTile: RawParsable, Equatable {
    public static let scorePosition = Position(x: -1, y: 0)
    public static var size: Int { 3 }

    public let type: ArcadeTileType
    public let position: Position
    public let score: Int?

    init(type: ArcadeTileType, position: Position) {
        self.type = type
        self.position = position
        self.score = nil
    }

    public init?(raw: [Int]) {
        guard raw.count == 3 else {
            return nil
        }
        self.position = Position(x: raw[0], y: raw[1])
        let lastComponent = raw[2]
        if self.position == ArcadeTile.scorePosition {
            self.type = .empty
            self.score = lastComponent
        } else if let type = ArcadeTileType(rawValue: lastComponent) {
            self.type = type
            self.score = nil
        } else {
            return nil
        }
    }
}

public enum Joystick: Int {
    case neutral = 0
    case left = -1
    case right = 1
}

public typealias Tiles = [Position: ArcadeTile]

public class ArcadeCabinet: IntcodeMachine<ArcadeTile> {
    public var tiles = Tiles()
    public var joystick = Joystick.neutral
    public var preInput : (() -> Void)?

    override public func output(_ output: ArcadeTile) {
        self.tiles[output.position] = output
    }

    override public func input() -> Int {
        preInput?()
        return joystick.rawValue
    }

    public func insertCoin() {
        self.computer.program?[0] = 2
    }
}

public class Day13: Day {

    public func numberOfBlockTiles() -> Int {
        let cabinet = arcadeCabinet()
        cabinet.run()
        return cabinet.tiles.filter { $0.value.type == .block }.count
    }

    public func arcadeCabinet() -> ArcadeCabinet {
        ArcadeCabinet(computer: IntcodeComputer(program: input()))
    }
}
