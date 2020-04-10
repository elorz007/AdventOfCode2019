//
//  Day3.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 07.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Instruction: Hashable {
    let direction: Direction
    let steps: UInt
}

typealias Wire = [Instruction]

class WireParser {
    func parse(_ input: String) -> Wire {
        input.split(separator: ",").map { String($0) }.compactMap { convert($0) }
    }

    func convert(_ input: String) -> Instruction? {
        let direction: Direction? = extract(input)
        let steps: UInt? = UInt(input.dropFirst())
        if let steps = steps, let direction = direction {
            return Instruction(direction: direction, steps: steps)
        } else {
            return nil
        }
    }

    func extract(_ input: String) -> Direction? {
        switch input.first {
        case "U":
            return .up
        case "D":
            return .down
        case "L":
            return .left
        case "R":
            return .right
        default:
            return nil
        }
    }

}

struct Point: Hashable {
    let x: Int
    let y: Int
    var stepsTaken: UInt = 0
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

extension Point {
    var manhattanDistance: UInt { UInt(abs(self.x) + abs(self.y)) }
}

extension Point: Comparable {
    static func < (lhs: Point, rhs: Point) -> Bool {
        if lhs.manhattanDistance == rhs.manhattanDistance {
            if lhs.x == rhs.x {
                return lhs.y < rhs.y
            } else {
                return lhs.x < rhs.x
            }
        } else {
            return lhs.manhattanDistance < rhs.manhattanDistance
        }
    }
}

typealias Path = Set<Point>

class WireExtender: NSObject {
    func extend(_ wire: Wire) -> Path {
        var path: Set = [Point(x: 0, y: 0, stepsTaken: 0)]
        var x = 0
        var y = 0
        var stepsTaken: UInt = 0
        wire.forEach { instruction in
            for _ in 1...instruction.steps {
                switch instruction.direction {
                case .up:
                    y += 1
                case .down:
                    y -= 1
                case .left:
                    x -= 1
                case .right:
                    x += 1
                }
                stepsTaken += 1
                path.insert(Point(x: x, y: y, stepsTaken: stepsTaken))
            }

        }
        return path
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class PathActions: NSObject {
    func closestIntersection(_ path1: Path, _ path2: Path) -> Point? {
        path1.intersection(path2).sorted()[safe: 1] // First one is always 0,0
    }
    func fastestIntersection(_ path1: Path, _ path2: Path) -> Point? {
        let intersectionsFromPath1 = path1.intersection(path2).sorted()
        let intersectionsFromPath2 = path2.intersection(path1).sorted()
        return zip(intersectionsFromPath1, intersectionsFromPath2).map { (p1: Point, p2: Point ) -> (Point) in
            return Point(x: p1.x, y: p1.y, stepsTaken: p1.stepsTaken + p2.stepsTaken)
        }.sorted { $0.stepsTaken < $1.stepsTaken }[safe: 1]
    }
}

public class Day3: Day {

    func pathsFrom(input: String) -> (Path, Path) {
        let rawWires = input.split(separator: "\n")
        let wireParser = WireParser()
        let wire1 = wireParser.parse(String(rawWires[0]))
        let wire2 = wireParser.parse(String(rawWires[1]))

        let wireExtender = WireExtender()
        let path1 = wireExtender.extend(wire1)
        let path2 = wireExtender.extend(wire2)
        return (path1, path2)
    }

    public func mahattanDistanceOfClosestIntersection() -> UInt {
        let (path1, path2) = pathsFrom(input: input())
        let pathActions = PathActions()
        let closestIntersection = pathActions.closestIntersection(path1, path2)
        return closestIntersection!.manhattanDistance
    }

    public func stepsOfFastestIntersection() -> UInt {
        let (path1, path2) = pathsFrom(input: input())
        let pathActions = PathActions()
        let fastestIntersection = pathActions.fastestIntersection(path1, path2)
        return fastestIntersection!.stepsTaken
    }

}
