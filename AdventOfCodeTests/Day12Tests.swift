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
        XCTAssertEqual(moon1.velocity.x, 19)
    }

    func testWhenPositionIsLowerThenGravityDecreasesVelocity() {
        var moon1 = Moon(position: Position3D(x: 2, y: 0, z: 0), velocity: Velocity3D(x: 20, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 5, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.x, 21)
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
        XCTAssertEqual(moon2.velocity.x, 21)
    }

    func testWhenApplyingGravityThenYAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 5, z: 0), velocity: Velocity3D(x: 0, y: 20, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 2, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.y, 19)
    }

    func testWhenApplyingGravityThenSecondMoonYAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 5, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 2, z: 0), velocity: Velocity3D(x: 0, y: 20, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.y, 21)
    }

    func testWhenApplyingGravityThenZAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 0, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 20))
        var moon2 = Moon(position: Position3D(x: 0, y: 0, z: 5), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon1.velocity.z, 21)
    }

    func testWhenApplyingGravityThenSecondMoonZAxisIsChanged() {
        var moon1 = Moon(position: Position3D(x: 0, y: 0, z: 2), velocity: Velocity3D(x: 0, y: 0, z: 0))
        var moon2 = Moon(position: Position3D(x: 0, y: 0, z: 5), velocity: Velocity3D(x: 0, y: 0, z: 20))
        let gravity = Gravity()
        gravity.apply(&moon1, &moon2)
        XCTAssertEqual(moon2.velocity.z, 19)
    }

    // MARK: - Velocity

    func testWhenApplyingVelocityThenXAxisIsChanged() {
        var moon = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 5, y: 0, z: 0))
        let velocity = Velocity()
        moon = velocity.apply(moon)
        XCTAssertEqual(moon.position, Position3D(x: 5, y: 0, z: 0))
    }

    func testWhenApplyingVelocityThenYAxisIsChanged() {
        var moon = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 5, z: 0))
        let velocity = Velocity()
        moon = velocity.apply(moon)
        XCTAssertEqual(moon.position, Position3D(x: 0, y: 5, z: 0))
    }

    func testWhenApplyingVelocityThenZAxisIsChanged() {
        var moon = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 5))
        let velocity = Velocity()
        moon = velocity.apply(moon)
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
        XCTAssertEqual(resultMoon1.velocity.x, 19)
        XCTAssertEqual(resultMoon2.velocity.y, 31)
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
        XCTAssertEqual(resultMoon1.velocity.x, 18)
        XCTAssertEqual(resultMoon2.velocity.y, 32)
        XCTAssertEqual(resultMoon3.velocity.z, 38)
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
        XCTAssertEqual(resultMoon1.velocity.x, 17)
        XCTAssertEqual(resultMoon2.velocity.y, 33)
        XCTAssertEqual(resultMoon3.velocity.z, 37)
        XCTAssertEqual(resultMoon4.velocity, Velocity3D(x: 1, y: -1, z: 1))
    }

    func testWhenApplyingGravityToOnlyOneMoonThenItIsNotChanged() {
        let moon1 = Moon(position: Position3D(x: 5, y: 6, z: 2), velocity: Velocity3D(x: 20, y: 30, z: 40))
        let universe = Universe(moons: [moon1])
        universe.applyGravity()
        let resultMoon1 = universe.moons[0]
        XCTAssertEqual(moon1, resultMoon1)
    }

    // MARK: - Universe velocity

    func testWhenApplyingVelocityToOnlyOneMoonThenItIsChanged() {
        let moon1 = Moon(position: Position3D(x: 1, y: 2, z: 3), velocity: Velocity3D(x: 20, y: 30, z: 40))
        let universe = Universe(moons: [moon1])
        universe.applyVelocity()
        let resultMoon1 = universe.moons[0]
        XCTAssertEqual(resultMoon1.position, Position3D(x: 21, y: 32, z: 43))
    }

    func testWhenApplyingVelocityToMoreMoonsThenTheyAreChanged() {
        let moon1 = Moon(position: Position3D(x: 1, y: 2, z: 3), velocity: Velocity3D(x: 20, y: 30, z: 40))
        let moon2 = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let moon3 = Moon(position: Position3D(x: 2, y: 3, z: 4), velocity: Velocity3D(x: 10, y: 20, z: 30))
        let universe = Universe(moons: [moon1, moon2, moon3])
        universe.applyVelocity()
        let resultMoon3 = universe.moons[2]
        XCTAssertEqual(resultMoon3.position, Position3D(x: 12, y: 23, z: 34))
    }

    // MARK: - Energy
    func testWhenKineticEnergyIsCalculatedThenVelocityIsAdded() {
        let energy = Energy()
        let moon = Moon(position: Position3D(x: 1, y: 2, z: 3), velocity: Velocity3D(x: 20, y: 30, z: 40))
        let result = energy.kinetic(from: moon)
        XCTAssertEqual(result, 90)
    }

    func testWhenKineticEnergyIsCalculatedThenAbsoluteValuesOfVelocityAreAdded() {
        let energy = Energy()
        let moon = Moon(position: Position3D(x: 1, y: 2, z: 3), velocity: Velocity3D(x: -10, y: 10, z: -10))
        let result = energy.kinetic(from: moon)
        XCTAssertEqual(result, 30)
    }

    func testWhenPotentialEnergyIsCalculatedThenPositionIsAdded() {
        let energy = Energy()
        let moon = Moon(position: Position3D(x: 1, y: 2, z: 3), velocity: Velocity3D(x: 20, y: 30, z: 40))
        let result = energy.potential(from: moon)
        XCTAssertEqual(result, 6)
    }

    func testWhenPotentialEnergyIsCalculatedThenAbsoluteValuesOfPositionAreAdded() {
        let energy = Energy()
        let moon = Moon(position: Position3D(x: -1, y: 1, z: -1), velocity: Velocity3D(x: -10, y: 10, z: -10))
        let result = energy.potential(from: moon)
        XCTAssertEqual(result, 3)
    }

    func testWhenTotalEnergyIsCalculatedThenPotentialAndKineticAreMultiplied() {
        let energy = Energy()
        let moon = Moon(position: Position3D(x: -1, y: 2, z: -1), velocity: Velocity3D(x: -10, y: 10, z: -10))
        let result = energy.total(from: moon)
        XCTAssertEqual(result, 120)
    }

    func testWhenTotalEnergyFromUniverseIsCalculatedThenAllMoonsAreTakenIntoAccount() {
        let moon1 = Moon(position: Position3D(x: 1, y: 1, z: 1), velocity: Velocity3D(x: 1, y: 1, z: 1))
        let moon2 = Moon(position: Position3D(x: 10, y: 10, z: 10), velocity: Velocity3D(x: 10, y: 10, z: 10))
        let moon3 = Moon(position: Position3D(x: 0, y: 0, z: 0), velocity: Velocity3D(x: 0, y: 0, z: 0))
        let moon4 = Moon(position: Position3D(x: 100, y: 100, z: 100), velocity: Velocity3D(x: 100, y: 100, z: 100))
        let universe = Universe(moons: [moon1, moon2, moon3, moon4])
        let result = universe.totalEnergy()
        XCTAssertEqual(result, 90909)
    }

    // MARK: - Examples
    // swiftlint:disable function_body_length
    func testWhenSteppingThroughExample1ThenResultsAreCalculated() {
        let moons = [
            Moon(position: Position3D(x: -1, y: 0, z: 2)),
            Moon(position: Position3D(x: 2, y: -10, z: -7)),
            Moon(position: Position3D(x: 4, y: -8, z: 8)),
            Moon(position: Position3D(x: 3, y: 5, z: -1))
        ]
        let universe = Universe(moons: moons)

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 2, -1, 1, 3, -1, -1]))
        XCTAssertEqual(universe.moons[1], Moon([ 3, -7, -4, 1, 3, 3]))
        XCTAssertEqual(universe.moons[2], Moon([ 1, -7, 5, -3, 1, -3]))
        XCTAssertEqual(universe.moons[3], Moon([ 2, 2, 0, -1, -3, 1]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 5, -3, -1, 3, -2, -2]))
        XCTAssertEqual(universe.moons[1], Moon([ 1, -2, 2, -2, 5, 6]))
        XCTAssertEqual(universe.moons[2], Moon([ 1, -4, -1, 0, 3, -6]))
        XCTAssertEqual(universe.moons[3], Moon([ 1, -4, 2, -1, -6, 2]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 5, -6, -1, 0, -3, 0]))
        XCTAssertEqual(universe.moons[1], Moon([ 0, 0, 6, -1, 2, 4]))
        XCTAssertEqual(universe.moons[2], Moon([ 2, 1, -5, 1, 5, -4]))
        XCTAssertEqual(universe.moons[3], Moon([ 1, -8, 2, 0, -4, 0]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 2, -8, 0, -3, -2, 1]))
        XCTAssertEqual(universe.moons[1], Moon([ 2, 1, 7, 2, 1, 1]))
        XCTAssertEqual(universe.moons[2], Moon([ 2, 3, -6, 0, 2, -1]))
        XCTAssertEqual(universe.moons[3], Moon([ 2, -9, 1, 1, -1, -1]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ -1, -9, 2, -3, -1, 2]))
        XCTAssertEqual(universe.moons[1], Moon([  4, 1, 5, 2, 0, -2]))
        XCTAssertEqual(universe.moons[2], Moon([  2, 2, -4, 0, -1, 2]))
        XCTAssertEqual(universe.moons[3], Moon([  3, -7, -1, 1, 2, -2]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ -1, -7, 3, 0, 2, 1]))
        XCTAssertEqual(universe.moons[1], Moon([  3, 0, 0, -1, -1, -5]))
        XCTAssertEqual(universe.moons[2], Moon([  3, -2, 1, 1, -4, 5]))
        XCTAssertEqual(universe.moons[3], Moon([  3, -4, -2, 0, 3, -1]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 2, -2, 1, 3, 5, -2]))
        XCTAssertEqual(universe.moons[1], Moon([ 1, -4, -4, -2, -4, -4]))
        XCTAssertEqual(universe.moons[2], Moon([ 3, -7, 5, 0, -5, 4]))
        XCTAssertEqual(universe.moons[3], Moon([ 2, 0, 0, -1, 4, 2]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 5, 2, -2, 3, 4, -3]))
        XCTAssertEqual(universe.moons[1], Moon([ 2, -7, -5, 1, -3, -1]))
        XCTAssertEqual(universe.moons[2], Moon([ 0, -9, 6, -3, -2, 1]))
        XCTAssertEqual(universe.moons[3], Moon([ 1, 1, 3, -1, 1, 3]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 5, 3, -4, 0, 1, -2]))
        XCTAssertEqual(universe.moons[1], Moon([ 2, -9, -3, 0, -2, 2]))
        XCTAssertEqual(universe.moons[2], Moon([ 0, -8, 4, 0, 1, -2]))
        XCTAssertEqual(universe.moons[3], Moon([ 1, 1, 5, 0, 0, 2]))

        universe.step()
        XCTAssertEqual(universe.moons[0], Moon([ 2, 1, -3, -3, -2, 1]))
        XCTAssertEqual(universe.moons[1], Moon([ 1, -8, 0, -1, 1, 3]))
        XCTAssertEqual(universe.moons[2], Moon([ 3, -6, 1, 3, 2, -3]))
        XCTAssertEqual(universe.moons[3], Moon([ 2, 0, 4, 1, -1, -1]))

        XCTAssertEqual(universe.totalEnergy(), 179)
    }
    // swiftlint:enable function_body_length

    func testWhenSteppingThroughExample2ThenResultsAreCalculated() {
        let moons = [
            Moon(position: Position3D(x: -8, y: -10, z: 0)),
            Moon(position: Position3D(x: 5, y: 5, z: 10)),
            Moon(position: Position3D(x: 2, y: -7, z: 3)),
            Moon(position: Position3D(x: 9, y: -8, z: -3))
        ]
        let universe = Universe(moons: moons)

        for _ in 1...100 {
            universe.step()
        }

        XCTAssertEqual(universe.moons[0], Moon([  8, -12, -9, -7, 3, 0]))
        XCTAssertEqual(universe.moons[1], Moon([ 13, 16, -3, 3, -11, -5]))
        XCTAssertEqual(universe.moons[2], Moon([-29, -11, -1, -3, 7, 4]))
        XCTAssertEqual(universe.moons[3], Moon([ 16, -13, 23, 7, 1, 1]))

        XCTAssertEqual(universe.totalEnergy(), 1940)
    }

    func testDay12TotalEnergy() {
        let d12 = Day12()
        XCTAssertEqual(d12.totalEnergy(), 14809)
    }

    // MARK: - Repeated Universe
    func testWhenAStepIsTakenThenNumberIncreases() {
        let moons = [
            Moon(position: Position3D(x: 0, y: 0, z: 0)),
            Moon(position: Position3D(x: 1, y: 0, z: 0))
        ]
        let universe = Universe(moons: moons)
        universe.step()
        universe.step()
        universe.step()
        universe.step()
        universe.step()
        XCTAssertEqual(universe.steps, 5)
    }

    func testWhenSimpleUniverseIsRepeatingThenItReturnsFalseInLessThan20Steps() {
        let moons = [
            Moon(position: Position3D(x: 0, y: 0, z: 0)),
            Moon(position: Position3D(x: 1, y: 0, z: 0))
        ]
        let universe = Universe(moons: moons)
        while universe.step(), universe.steps < 20 {}
        XCTAssertLessThan(universe.steps, 20)
    }

    func testWhenSimpleUniverseIsRepeatingThenItFinishesIn4Steps() {
        let moons = [
            Moon(position: Position3D(x: 0, y: 0, z: 0)),
            Moon(position: Position3D(x: 1, y: 0, z: 0))
        ]
        let universe = Universe(moons: moons)
        while universe.step() {}
        XCTAssertEqual(universe.steps, 4)
    }

    func testWhenSteppingThroughExample1ThenItRepeatsAfter2772Steps() {
        let moons = [
            Moon(position: Position3D(x: -1, y: 0, z: 2)),
            Moon(position: Position3D(x: 2, y: -10, z: -7)),
            Moon(position: Position3D(x: 4, y: -8, z: 8)),
            Moon(position: Position3D(x: 3, y: 5, z: -1))
        ]
        let steps = EfficientCycleFinder().stepsUntilCycle(moons: moons)
        XCTAssertEqual(steps, 2772)
    }

    func testWhenSteppingThroughExample2ThenItRepeatsAfter4686774924Steps() {
        let moons = [
            Moon(position: Position3D(x: -8, y: -10, z: 0)),
            Moon(position: Position3D(x: 5, y: 5, z: 10)),
            Moon(position: Position3D(x: 2, y: -7, z: 3)),
            Moon(position: Position3D(x: 9, y: -8, z: -3))
        ]
        let steps = EfficientCycleFinder().stepsUntilCycle(moons: moons)
        XCTAssertEqual(steps, 4686774924)
    }

    func test_SLOW_Day12StepsUntilCycle() {
        let d12 = Day12()
        XCTAssertEqual(d12.stepsUntilCycle(), 282270365571288)
    }

}

extension Moon {
    init(_ raw: [Int]) {
        let position = Position3D(x: raw[0], y: raw[1], z: raw[2])
        let velocity = Velocity3D(x: raw[3], y: raw[4], z: raw[5])
        self.init(position: position, velocity: velocity)
    }
}
