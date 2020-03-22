//
//  Day12.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 22.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Moon: Equatable {
    var position: Position3D
    var velocity = Velocity3D(x: 0, y: 0, z: 0)
}

class Universe {
    var moons: [Moon]
    init(moons: [Moon]) {
        self.moons = moons
    }

    func applyGravity() {
        let gravity = Gravity()
        PairsIterator().iterate(&moons) { gravity.apply(&$0, &$1) }
    }

    func applyVelocity() {
        let velocity = Velocity()
        moons = moons.map { velocity.apply($0) }
    }

    func step() {
        applyGravity()
        applyVelocity()
    }

    func totalEnergy() -> Int {
        let energy = Energy()
        return moons.map { energy.total(from: $0) }.reduce(0, +)
    }
}

class Gravity {
    func apply(_ moon1: inout Moon, _ moon2: inout Moon) {
        let velocityDifferenceX = velocityDifference(moon1.position.x, moon2.position.x)
        moon1.velocity.x += velocityDifferenceX
        moon2.velocity.x -= velocityDifferenceX
        let velocityDifferenceY = velocityDifference(moon1.position.y, moon2.position.y)
        moon1.velocity.y += velocityDifferenceY
        moon2.velocity.y -= velocityDifferenceY
        let velocityDifferenceZ = velocityDifference(moon1.position.z, moon2.position.z)
        moon1.velocity.z += velocityDifferenceZ
        moon2.velocity.z -= velocityDifferenceZ
    }
    func velocityDifference(_ dimensionValue1: Int, _ dimensionValue2: Int) -> Int {
        -min(max(dimensionValue1 - dimensionValue2, -1), 1)
    }
}

class Velocity {
    func apply(_ inMoon: Moon) -> Moon {
        var moon = inMoon
        moon.position.x += moon.velocity.x
        moon.position.y += moon.velocity.y
        moon.position.z += moon.velocity.z
        return moon
    }
}

class Energy {
    func kinetic(from moon: Moon) -> Int {
        absoluteAdd([moon.velocity.x, moon.velocity.y, moon.velocity.z])
    }

    func potential(from moon: Moon) -> Int {
        absoluteAdd([moon.position.x, moon.position.y, moon.position.z])
    }

    func absoluteAdd(_ array: [Int]) -> Int {
        array.map(abs).reduce(0, +)
    }

    func total(from moon: Moon) -> Int {
        return kinetic(from: moon) * potential(from: moon)
    }
}

class PairsIterator<T> {
    func iterate(_ objects: inout [T], do action: (inout T, inout T) -> Void) {
        iterate(&objects, at: 0, do: action)
    }

    func iterate(_ objects: inout [T], at index: Int, do action: (inout T, inout T) -> Void) {
        guard objects.count >= 2 else { return }
        if objects.count - index == 2 {
            let lastIndex = objects.count - 1
            let previousToLastIndex = objects.count - 2
            var object1 = objects[lastIndex]
            var object2 = objects[previousToLastIndex]
            action(&object1, &object2)
            objects[lastIndex] = object1
            objects[previousToLastIndex] = object2
        } else {
            var current = objects[index]
            for otherIndex in index + 1..<objects.count {
                var other = objects[otherIndex]
                action(&current, &other)
                objects[otherIndex] = other
            }
            objects[index] = current
            iterate(&objects, at: index + 1, do: action)
        }
    }
}

class Day12: NSObject {

}
