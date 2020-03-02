//
//  DAy10.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 23.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

extension Position {
    var encoded: Int {
        x * 100 + y
    }
}

struct Vector: Comparable {
    let a: Position
    let b: Position

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

enum SpaceObject: Character, CustomDebugStringConvertible {
    case empty = "."
    case asteroid = "#"

    var debugDescription: String {
        String(rawValue)
    }
}

struct Tile: Equatable, Comparable, CustomDebugStringConvertible {
    let object: SpaceObject
    let position: Position
    var visibleAsteroids: Int = 0

    static func == (lhs: Tile, rhs: Tile) -> Bool {
        lhs.object == rhs.object && lhs.position == rhs.position
    }
    static func < (lhs: Tile, rhs: Tile) -> Bool {
        lhs.visibleAsteroids < rhs.visibleAsteroids
    }

    var debugDescription: String {
        "\(object) \(position)"
    }
}

typealias AsteroidMap = [Tile]

extension AsteroidMap {
    init(from stringRepresentation: String) {
        self.init()
        for (y, line) in stringRepresentation.components(separatedBy: .newlines).enumerated() {
            for (x, char) in line.enumerated() {
                if let object = SpaceObject(rawValue: char) {
                    let tile = Tile(object: object, position: Position(x: x, y: y))
                    self.append(tile)
                }
            }
        }
    }

    func filter(equalTo object: SpaceObject) -> AsteroidMap {
        self.filter { $0.object == object}
    }

    func allAsteroids() -> AsteroidMap {
        self.filter(equalTo: .asteroid)
    }

    func countAsteroids() -> AsteroidMap {
        map {
            var tile = $0
            tile.visibleAsteroids = visibleAsteroids(from: tile.position).count
            return tile
        }
    }

    func maxAsteroids() -> Int {
        self.max { $0 < $1 }?.visibleAsteroids ?? 0
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

    func maxAsteroids() -> Int {
        AsteroidMap(from: input()).countMaxAsteroids()
    }

    func betAsteroidEncodedPosition() -> Int {
        let destroyedAsteroids = AsteroidMap(from: input()).destroyedAsteroids(from: Position(x: 22, y: 19))
        let betAsteroid = destroyedAsteroids[199]
        return betAsteroid.position.encoded
    }

    func input() -> String {
        // swiftlint:disable force_try
        try! String(contentsOfFile: "./Day10.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }
}
