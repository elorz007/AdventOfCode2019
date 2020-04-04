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

enum Direction: Int, CaseIterable {
    case up = 0
    case right = 1
    case down = 2
    case left = 3

    var debugDescription: String {
        String(rawValue)
    }
}

enum Rotation: Int {
    case left = 0
    case right = 1
    var directionDelta: Int {
        return self == .right ? 1 : -1
    }
}

extension Direction {
    mutating func rotate(_ rotation: Rotation) {
        let directionsCount = Direction.allCases.count
        self = Direction(rawValue: ((self.rawValue + directionsCount + rotation.directionDelta) % directionsCount))!
    }
}

extension Position {
    mutating func advance(in direction: Direction) {
        switch direction {
        case .up:
            self = Position(x: self.x, y: self.y + 1)
        case .down:
            self = Position(x: self.x, y: self.y - 1)
        case .left:
            self = Position(x: self.x - 1, y: self.y)
        case .right:
            self = Position(x: self.x + 1, y: self.y)
        }
    }
}

enum Axis3D {
    case x, y, z
}

struct Velocity3D: Hashable, Restrictable3D {
    var x: Int
    var y: Int
    var z: Int
}

struct Position3D: Hashable, Restrictable3D {
    var x: Int
    var y: Int
    var z: Int
}

protocol ThreeDimensions {
    var x: Int { get set }
    var y: Int { get set }
    var z: Int { get set }
}

protocol Restrictable3D: ThreeDimensions {
    mutating func restrictTo(axis: Axis3D)
}

extension ThreeDimensions {
    mutating func restrictTo(axis: Axis3D) {
        let x = self.x
        let y = self.y
        let z = self.z
        self.x = 0
        self.y = 0
        self.z = 0
        switch axis {
        case .x:
            self.x = x
        case .y:
            self.y = y
        case .z:
            self.z = z
        }
    }
}

// Probably there is a way to not repeat this extension twice
extension Velocity3D: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(x),\(y),\(z)"
    }
}
extension Position3D: CustomDebugStringConvertible {
    var debugDescription: String {
        "\(x),\(y),\(z)"
    }
}
