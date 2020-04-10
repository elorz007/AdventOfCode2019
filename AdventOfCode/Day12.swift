//
//  Day12.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 22.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Moon: Hashable {
    var position: Position3D
    var velocity = Velocity3D(x: 0, y: 0, z: 0)

    func restrictTo(axis: Axis3D) -> Moon {
        var newMoon = self
        newMoon.position.restrictTo(axis: axis)
        newMoon.velocity.restrictTo(axis: axis)
        return newMoon
    }
}

extension Moon: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(position) \(velocity)"
    }
}

class Universe {
    var moons: [Moon]
    var previousStates: Set<Int> = []
    var steps: Int = 0
    let gravity = Gravity()
    let velocity = Velocity()
    init(moons: [Moon]) {
        self.moons = moons
        insertCurrentState()
    }

    func applyGravity() {
        PairsIterator().iterate(&moons) { gravity.apply(&$0, &$1) }
    }

    func applyVelocity() {
        moons = moons.map { velocity.apply($0) }
    }

    @discardableResult func step() -> Bool {
        applyGravity()
        applyVelocity()
        steps += 1
        return insertCurrentState()
    }

    @discardableResult func insertCurrentState() -> Bool {
        self.previousStates.insert(self.currentState()).inserted
    }

    func currentState() -> Int {
        moons.hashValue
    }

    func totalEnergy() -> Int {
        let energy = Energy()
        return moons.map { energy.total(from: $0) }.reduce(0, +)
    }
}

class RestrictedUniverse: Universe {
    init(moons: [Moon], restrictTo axis: Axis3D) {
        let restrictedMoons = moons.map { $0.restrictTo(axis: axis) }
        super.init(moons: restrictedMoons)
    }
}

class EfficientCycleFinder {
    func stepsUntilCycle(moons: [Moon]) -> Int {
        let universeX = RestrictedUniverse(moons: moons, restrictTo: .x)
        let stepsX = stepsUntilCycle(universe: universeX)
        let universeY = RestrictedUniverse(moons: moons, restrictTo: .y)
        let stepsY = stepsUntilCycle(universe: universeY)
        let universeZ = RestrictedUniverse(moons: moons, restrictTo: .z)
        let stepsZ = stepsUntilCycle(universe: universeZ)
        return leastCommonMultiple(stepsX, stepsY, stepsZ)
    }

    func stepsUntilCycle(universe: Universe) -> Int {
        while universe.step() {}
        return universe.steps
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

    // This is horrible, probably easier with 2 for loops
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

public class Day12: Day {
    func inputMoons() -> [Moon] {
        return [
            Moon(position: Position3D(x: 0, y: 6, z: 1)),
            Moon(position: Position3D(x: 4, y: 4, z: 19)),
            Moon(position: Position3D(x: -11, y: 1, z: 8)),
            Moon(position: Position3D(x: 2, y: 19, z: 15))
        ]
    }
    public func totalEnergy() -> Int {
        let universe = Universe(moons: inputMoons())
        for _ in 1...1000 {
            universe.step()
        }
        return universe.totalEnergy()
    }

    public func stepsUntilCycle() -> Int {
        return EfficientCycleFinder().stepsUntilCycle(moons: inputMoons())
    }
}
