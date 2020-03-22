//
//  Day12Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 22.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day12Tests: XCTestCase {

    // MARK: - Gravity
    func testWhenPositionIsHigherThenGravityIncreasesVelocity() {
        var moon1 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 21)
    }

    func testWhenPositionIsLowerThenGravityDecreasesVelocity() {
        var moon1 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 19)
    }

    func testWhenPositionIsEqualThenGravityDoesntChangeVelocity() {
        var moon1 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 20)
    }

    func testWhenApplyingGravityThenSecondMoonIsChanged() {
        var moon1 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.x, 19)
    }

    func testWhenApplyingGravityThenYAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 5, z: 0), velocity: Velocity3D(x: 0, y: 20, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 2, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.y, 21)
    }

    func testWhenApplyingGravityThenSecondMoonYAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 5, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 2, z: 0), velocity: Velocity3D(x: 0, y: 20, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.y, 19)
    }

    func testWhenApplyingGravityThenZAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 0, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 20))
        var moon2 = Moon(position: Position3D(x: 0, y: 0, z: 5), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.z, 19)
    }

    func testWhenApplyingGravityThenSecondMoonZAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 0, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 0, z: 5), velocity: Velocity3D(x: 0, y: 0, z: 20))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.z, 21)
    }

    // MARK: - Velocity

    func testWhenApplyingVelocityThenXAxisIsChanged() {
        var moon = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 5, y: 0, z: 0))
        let velocity = Velocity()
        velocity.apply(&moon)
        XCTAssertEqual(moon.position, Position3D(x: 5, y: 0, z: 0))
    }

    func testWhenApplyingVelocityThenYAxisIsChanged() {
        var moon = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 5, z: 0))
        let velocity = Velocity()
        velocity.apply(&moon)
        XCTAssertEqual(moon.position, Position3D(x: 0, y: 5, z: 0))
    }

    func testWhenApplyingVelocityThenZAxisIsChanged() {
        var moon = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 5))
        let velocity = Velocity()
        velocity.apply(&moon)
        XCTAssertEqual(moon.position, Position3D(x: 0, y: 0, z: 5))
    }

    // MARK: - Universe gravity
    func testWhenApplyingGravityToTwoMoonsThenAllPairsAreChanged() {
        let moon1 = Moon(position: Position3D(x: 5, y: 6, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        let moon2 = Moon(position: Position3D(x: 2, y: 3, z: 0), velocity: Velocity3D(x: 0, y: 30, z: 0))
        let universe = Universe(moons: [moon1, moon2])
        universe.applyGravity()
        let resultMoon1 = universe.moons[0]
        let resultMoon2 = universe.moons[1]
        XCTAssertEqual(resultMoon1.velocity.x, 21)
        XCTAssertEqual(resultMoon2.velocity.y, 29)
    }

    func testWhenApplyingGravityToThreeMoonsThenAllPairsAreChanged() {
        let moon1 = Moon(position: Position3D(x: 5, y: 6, z: 2), velocity: Velocity3D(x: 20, y: 0, z: 0))
        let moon2 = Moon(position: Position3D(x: 2, y: 3, z: 2), velocity: Velocity3D(x: 0, y: 30, z: 0))
        let moon3 = Moon(position: Position3D(x: 2, y: 6, z: 9), velocity: Velocity3D(x: 0, y: 0, z: 40))
        let universe = Universe(moons: [moon1, moon2, moon3])
        universe.applyGravity()
        let resultMoon1 = universe.moons[0]
        let resultMoon2 = universe.moons[1]
        let resultMoon3 = universe.moons[2]
        XCTAssertEqual(resultMoon1.velocity.x, 22)
        XCTAssertEqual(resultMoon2.velocity.y, 28)
        XCTAssertEqual(resultMoon3.velocity.z, 42)
    }

    func testWhenApplyingGravityToMoreMoonsThenAllPairsAreChanged() {
        let moon1 = Moon(position: Position3D(x: 5, y: 6, z: 2), velocity: Velocity3D(x: 20, y: 0, z: 0))
        let moon2 = Moon(position: Position3D(x: 2, y: 3, z: 2), velocity: Velocity3D(x: 0, y: 30, z: 0))
        let moon3 = Moon(position: Position3D(x: 2, y: 6, z: 9), velocity: Velocity3D(x: 0, y: 0, z: 40))
        let moon4 = Moon(position: Position3D(x: 2, y: 6, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 0))

        let universe = Universe(moons: [moon1, moon2, moon3, moon4])
        universe.applyGravity()
        let resultMoon1 = universe.moons[0]
        let resultMoon2 = universe.moons[1]
        let resultMoon3 = universe.moons[2]
        let resultMoon4 = universe.moons[3]
        XCTAssertEqual(resultMoon1.velocity.x, 23)
        XCTAssertEqual(resultMoon2.velocity.y, 27)
        XCTAssertEqual(resultMoon3.velocity.z, 43)
        XCTAssertEqual(resultMoon4.velocity, Velocity3D(x: -1, y: 1, z: -1))
    }

    func testWhenApplyingGravityToOnlyOneMoonThenItIsNotChanged() {
        let moon1 = Moon(position: Position3D(x: 5, y: 6, z: 2), velocity: Velocity3D(x: 20, y: 30, z: 40))
        let universe = Universe(moons: [moon1])
        universe.applyGravity()
        let resultMoon1 = universe.moons[0]
        XCTAssertEqual(moon1, resultMoon1)
    }

    // MARK: - Universe velocity

//    func testWhenApplyingVelocityToOnlyOneMoonThenItIsChanged() {
//        let moon1 = Moon(position: Position3D(x: 1, y: 2, z: 3), velocity: Velocity3D(x: 20, y: 30, z: 40))
//        let universe = Universe(moons: [moon1])
//        universe.applyGravity()
//        let resultMoon1 = universe.moons[0]
//        XCTAssertEqual(resultMoon1.position)
//    }
}
