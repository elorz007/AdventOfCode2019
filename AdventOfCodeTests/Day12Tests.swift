//
//  Day12Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 22.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day12Tests: XCTestCase {

    func testWhenPositionIsHigherThenGravityIncreasesVelocity() {
        var moon1 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 21)
    }

    func testWhenPositionIsLowerThenGravityDecreasesVelocity() {
        var moon1 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 19)
    }

    func testWhenPositionIsEqualThenGravityDoesntChangeVelocity() {
        var moon1 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 20)
    }

    func testWhenApplyingGravityThenSecondMoonIsChanged() {
        var moon1 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.x, 19)
    }

    func testWhenApplyingGravityThenYAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 5, z: 0), velocity: Velocity3D(x: 0, y: 20, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 2, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.y, 21)
    }

    func testWhenApplyingGravityThenSecondMoonYAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 5, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 2, z: 0), velocity: Velocity3D(x: 0, y: 20, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.y, 19)
    }

    func testWhenApplyingGravityThenZAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 0, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 20))
        var moon2 = Moon(position: Position3D(x: 0, y: 0, z: 5), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.z, 19)
    }

    func testWhenApplyingGravityThenSecondMoonZAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 0, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 0, z: 5), velocity: Velocity3D(x: 0, y: 0, z: 20))
        let universe = Universe()
        universe.applyGravity(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.z, 21)
    }

}
