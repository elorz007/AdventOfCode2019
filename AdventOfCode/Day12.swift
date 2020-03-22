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
    var velocity: Velocity3D
}

class Universe {
    var moons: [Moon]
    init(moons: [Moon]) {
        self.moons = moons
    }
    func applyGravity() {
        let gravity = Gravity()
        iterate(moons: &moons, at: 0) { gravity.apply(&$0, &$1) }
    }

    func iterate(moons: inout [Moon], at index: Int, do action: (inout Moon, inout Moon) -> Void) {
        guard moons.count >= 2 else { return }
        if moons.count - index == 2 {
            let lastIndex = moons.count - 1
            let previousToLastIndex = moons.count - 2
            var moon1 = moons[lastIndex]
            var moon2 = moons[previousToLastIndex]
            action(&moon1, &moon2)
            moons[lastIndex] = moon1
            moons[previousToLastIndex] = moon2
        } else {
            var current = moons[index]
            for otherIndex in index + 1..<moons.count {
                var other = moons[otherIndex]
                action(&current, &other)
                moons[otherIndex] = other
            }
            moons[index] = current
            iterate(moons: &moons, at: index + 1, do: action)
        }
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
        min(max(dimensionValue1 - dimensionValue2, -1), 1)
    }
}

class Velocity {
    func apply(_ moon: inout Moon) {
        moon.position.x += moon.velocity.x
        moon.position.y += moon.velocity.y
        moon.position.z += moon.velocity.z
    }
}

class Day12: NSObject {

}
