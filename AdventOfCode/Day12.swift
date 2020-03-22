//
//  Day12.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 22.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Moon {
    var position: Position3D
    var velocity: Velocity3D
}

class Universe {
    func applyGravity(_ moon1: inout Moon, _ moon2: inout Moon) {
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

class Day12: NSObject {

}
