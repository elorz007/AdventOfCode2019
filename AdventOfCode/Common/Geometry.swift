//
//  Geometry.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 02.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Position: Equatable, CustomDebugStringConvertible, Hashable {
    let x: Int
    let y: Int

    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }

    var debugDescription: String {
        "(\(x),\(y))"
    }
}

enum Direction: Character, CustomDebugStringConvertible {
    case up = "^"
    case down = "v"
    case left = "<"
    case right = ">"

    var debugDescription: String {
        String(rawValue)
    }
}

enum Rotation: Int {
    case left = 0
    case right = 1
}

extension Direction {
    mutating func rotate(_ rotation: Rotation) {
        switch self {
        case .up:
            switch rotation {
            case .left:
                self = .left
            case .right:
                self = .right
            }
        case .down:
            switch rotation {
            case .left:
                self = .right
            case .right:
                self = .left
            }
        case .left:
            switch rotation {
            case .left:
                self = .down
            case .right:
                self = .up
            }
        case .right:
            switch rotation {
            case .left:
                self = .up
            case .right:
                self = .down
            }
        }
    }
}
