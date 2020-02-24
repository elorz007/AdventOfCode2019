//
//  DAy10.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 23.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Position: Equatable {
    let x: Int
    let y: Int
    static func == (lhs: Position, rhs: Position) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct Vector {
    let a: Position
    let b: Position
}

extension Vector {
    func angle() -> Float {
        atan2(Float(b.y - a.y), Float(b.x - a.x))
    }
}

enum SpaceObject {
    case empty, asteroid
}

struct Tile: Equatable, Comparable {
    let object: SpaceObject
    let position: Position
    var visibleAsteroids: Int = 0

    static func == (lhs: Tile, rhs: Tile) -> Bool {
        return lhs.object == rhs.object && lhs.position == rhs.position
    }
    static func < (lhs: Tile, rhs: Tile) -> Bool {
        lhs.visibleAsteroids < rhs.visibleAsteroids
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
            tile.visibleAsteroids = self.asteroidsVisible(in: tile.position)
            return tile
        }
    }

    func maxAsteroids() -> Int {
        self.max { $0 < $1 }?.visibleAsteroids ?? 0
    }

    func asteroidsVisible(in origin: Position) -> Int {
        var angles = Set<Float>()
        for tile in self {
            let vector = Vector(a: origin, b: tile.position)
            if origin != tile.position {
                angles.insert(vector.angle())
            }
        }
        return angles.count
    }

    func countMaxAsteroids() -> Int {
        self.allAsteroids().countAsteroids().maxAsteroids()
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

    func input() -> String {
        // swiftlint:disable force_try
        try! String(contentsOfFile: "./Day10.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }
}
