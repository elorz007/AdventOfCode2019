//
//  Day13.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

enum ArcadeTileType: Int {
    case Empty = 0
    case Wall = 1
    case Block = 2
    case Paddle = 3
    case Ball = 4
}

public struct ArcadeTile: RawParsable, Equatable {
    public static var size: Int { 3 }

    let type: ArcadeTileType
    let position: Position

    init(type: ArcadeTileType, position: Position) {
        self.type = type
        self.position = position
    }

    public init?(raw: [Int]) {
        guard raw.count == 3 else {
            return nil
        }
        guard let type = ArcadeTileType(rawValue: raw[2]) else {
            return nil
        }
        self.position = Position(x: raw[0], y: raw[1])
        self.type = type
    }
}

public class ArcadeCabinet: IntcodeMachine<ArcadeTile> {
    var tiles = [ArcadeTile]()

    override public func output(_ output: ArcadeTile) {
        self.tiles.append(output)
    }
}

public class Day13: Day {

    public func numberOfBlockTiles() -> Int {
        let cabinet = arcadeCabinet()
        cabinet.run()
        return cabinet.tiles.filter { $0.type == .Block }.count
    }

    public func arcadeCabinet() -> ArcadeCabinet {
        ArcadeCabinet(computer: IntcodeComputer(program: input()))
    }
}
