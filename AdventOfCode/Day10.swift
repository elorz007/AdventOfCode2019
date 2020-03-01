//
//  DAy10.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 23.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Position: Equatable, CustomDebugStringConvertible {
    let x: Int
    let y: Int
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    var encoded: Int {
        return x * 100 + y
    }

    var debugDescription: String {
        return "(\(x),\(y))"
    }
}

struct Vector {
    let a: Position
    let b: Position
}

extension Vector: Comparable {
    func angle() -> Float {
        atan2(Float(b.y - a.y), Float(b.x - a.x))
    }

    func magnitude() -> Float {
        sqrtf(powf(Float(b.y - a.y), 2) + powf(Float(b.x - a.x), 2))
    }

    static func < (lhs: Vector, rhs: Vector) -> Bool {
        lhs.magnitude() < rhs.magnitude()
    }
}

extension Float {
    func rotated(by angle: Float) -> Float {
        let newAngle = self + angle
        if newAngle >= -ulp { // >= 0 but taking into account float precission
            return newAngle
        } else {
            return newAngle + 2 * .pi
        }
    }
    func rotatedUp() -> Float {
        self.rotated(by: .pi / 2)
    }
}

enum SpaceObject {
    case empty, asteroid
}

extension SpaceObject: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .empty:
            return "."
        case .asteroid:
            return "#"
        }
    }
}

struct Tile: Equatable, Comparable, CustomDebugStringConvertible {
    let object: SpaceObject
    let position: Position
    var visibleAsteroids: Int = 0

    static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.object == rhs.object && lhs.position == rhs.position
    }
    static func < (lhs: Tile, rhs: Tile) -> Bool {
        lhs.visibleAsteroids < rhs.visibleAsteroids
    }

    var debugDescription: String {
        return "\(object) \(position)"
    }
}

typealias Map = [Tile]

extension Map {
    func filter(equalTo object: SpaceObject) -> Map {
        self.filter { $0.object == object}
    }

    func allAsteroids() -> Map {
        self.filter(equalTo: .asteroid)
    }

    func countAsteroids() -> Map {
        map {
            var tile = $0
            tile.visibleAsteroids = self.countVisibleAsteroids(from: tile.position)
            return tile
        }
    }

    func maxAsteroids() -> Int {
        self.max { $0 < $1 }?.visibleAsteroids ?? 0
    }

    func countVisibleAsteroids(from origin: Position) -> Int {
        visibleAsteroids(from: origin).count
    }

    func countMaxAsteroids() -> Int {
        self.allAsteroids().countAsteroids().maxAsteroids()
    }

    func visibleAsteroids(from origin: Position) -> [Tile] {
        var visibleAsteroids = [Float: Tile]()
        for tile in self where origin != tile.position {
            let vector = Vector(a: origin, b: tile.position)
            let angle = vector.angle().rotatedUp()
            if let tileInSameDirection = visibleAsteroids[angle] {
                let vectorInSameDirection = Vector(a: origin, b: tileInSameDirection.position)
                if vector < vectorInSameDirection {
                    visibleAsteroids[angle] = tile
                }
            } else {
                visibleAsteroids[angle] = tile
            }
        }
        return visibleAsteroids.sorted { $0.key < $1.key }.map { $0.value }
    }

    func destroyedAsteroids(from origin: Position) -> [Tile] {
        var allAsteroids = self.allAsteroids()
        var allDestroyed = [Tile]()
        while allAsteroids.count > 1 {
            let destroyedInThisRotation = allAsteroids.visibleAsteroids(from: origin)
            allAsteroids = allAsteroids.filter { !destroyedInThisRotation.contains($0) }
            allDestroyed.append(contentsOf: destroyedInThisRotation)
        }
        return allDestroyed
    }
}

class Day10: NSObject {
    func map(from input: String) -> Map {
        var map = Map()
        for (y, line) in input.components(separatedBy: .newlines).enumerated() {
            for (x, char) in line.enumerated() {
                let object: SpaceObject = char == "#" ? .asteroid : .empty
                let tile = Tile(object: object, position: Position(x: x, y: y))
                map.append(tile)
            }
        }
        return map
    }

    func maxAsteroids() -> Int {
        map(from: input()).countMaxAsteroids()
    }

    func betAsteroidEncodedPosition() -> Int {
        let destroyedAsteroids = map(from: input()).destroyedAsteroids(from: Position(x: 22, y: 19))
        let betAsteroid = destroyedAsteroids[199]
        return betAsteroid.position.encoded
    }

    func input() -> String {
        // swiftlint:disable force_try
        try! String(contentsOfFile: "./Day10.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }
}
