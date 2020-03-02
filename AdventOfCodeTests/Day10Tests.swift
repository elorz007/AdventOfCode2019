//
//  Day10Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 23.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day10Tests: XCTestCase {

    func testTwoDiagonalVectorsHaveSameAngle() {
        let origin = Position(x: 0, y: 0)
        let target1 = Position(x: 1, y: 1)
        let target2 = Position(x: 2, y: 2)
        let vector1 = Vector(a: origin, b: target1)
        let vector2 = Vector(a: origin, b: target2)
        XCTAssertEqual(vector1.angle(), vector2.angle(), accuracy: 0.0000001)
    }

    func testTwoDiagonalVectorsHaveSameAngleWithAccuracyProblems() {
        let origin = Position(x: 0, y: 0)
        let target1 = Position(x: 1, y: 3)
        let target2 = Position(x: 2, y: 6)
        let vector1 = Vector(a: origin, b: target1)
        let vector2 = Vector(a: origin, b: target2)
        XCTAssertEqual(vector1.angle(), vector2.angle(), accuracy: 0.0000001)
    }

    func testTwoVerticalVectorsHaveSameAngle() {
        let origin = Position(x: 0, y: 0)
        let target1 = Position(x: 0, y: 1)
        let target2 = Position(x: 0, y: 200)
        let vector1 = Vector(a: origin, b: target1)
        let vector2 = Vector(a: origin, b: target2)
        XCTAssertEqual(vector1.angle(), vector2.angle(), accuracy: 0.0000001)
    }

    func testTwoHorizontalVectorsHaveSameAngle() {
        let origin = Position(x: 0, y: 0)
        let target1 = Position(x: 1, y: 0)
        let target2 = Position(x: 1000, y: 0)
        let vector1 = Vector(a: origin, b: target1)
        let vector2 = Vector(a: origin, b: target2)
        XCTAssertEqual(vector1.angle(), vector2.angle(), accuracy: 0.0000001)
    }

    func testTwoNegativeVectorsHaveSameAngle() {
        let origin = Position(x: 0, y: 0)
        let target1 = Position(x: -1, y: 3)
        let target2 = Position(x: -1000, y: 3000)
        let vector1 = Vector(a: origin, b: target1)
        let vector2 = Vector(a: origin, b: target2)
        XCTAssertEqual(vector1.angle(), vector2.angle(), accuracy: 0.0000001)
    }

    func testRightVectorHasAngle0() {
        let origin = Position(x: 0, y: 0)
        let target = Position(x: 1, y: 0)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle(), 0, accuracy: 0.0000001)
    }

    func testDownVectorHasAnglePi2() {
        let origin = Position(x: 0, y: 0)
        let target = Position(x: 0, y: 1)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle(), .pi / 2, accuracy: 0.00001)
    }

    func testLeftVectorHasAnglePi() {
        let origin = Position(x: 1, y: 0)
        let target = Position(x: 0, y: 0)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle(), .pi, accuracy: 0.00001)
    }

    func testUpVectorHasAngleMinusPi2() {
        let origin = Position(x: 0, y: 1)
        let target = Position(x: 0, y: 0)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle(), -.pi / 2, accuracy: 0.00001)
    }

    func testRightVectorRotatedUpHasAnglePi2() {
        let origin = Position(x: 0, y: 0)
        let target = Position(x: 1, y: 0)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle().rotatedUp(), .pi / 2, accuracy: 0.0000001)
    }

    func testDownVectorRotatedUpHasAnglePi() {
        let origin = Position(x: 0, y: 0)
        let target = Position(x: 0, y: 1)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle().rotatedUp(), .pi, accuracy: 0.00001)
    }

    func testLeftVectorRotatedUpHasAngle3Pi2() {
        let origin = Position(x: 1, y: 0)
        let target = Position(x: 0, y: 0)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle().rotatedUp(), 3 * .pi / 2, accuracy: 0.00001)
    }

    func testUpVectorRotatedUpHasAngle0() {
        let origin = Position(x: 0, y: 1)
        let target = Position(x: 0, y: 0)
        let vector = Vector(a: origin, b: target)
        XCTAssertEqual(vector.angle().rotatedUp(), 0, accuracy: 0.00001)
    }
    // MARK: - Visible asteroids

    func testTwoAsteroidsInLineOfSightAreCountedAsOne() {
        let origin = Position(x: 0, y: 0)
        let tile1 = Tile(object: .asteroid, position: origin)
        let tile2 = Tile(object: .asteroid, position: Position(x: 1, y: 0))
        let tile3 = Tile(object: .asteroid, position: Position(x: 10, y: 0))
        let map = [tile1, tile2, tile3]
        let result = map.visibleAsteroids(from: origin).count
        XCTAssertEqual(result, 1)
    }

    func testMoreAsteroidsInLineOfSightAreCountedAsOne() {
        let origin = Position(x: 1, y: 2)
        let tile1 = Tile(object: .asteroid, position: origin)
        let tile2 = Tile(object: .asteroid, position: Position(x: 2, y: 4))
        let tile3 = Tile(object: .asteroid, position: Position(x: 4, y: 8))
        let tile4 = Tile(object: .asteroid, position: Position(x: 10, y: 20))
        let tile5 = Tile(object: .asteroid, position: Position(x: 100, y: 200))

        let map = [tile1, tile2, tile3, tile4, tile5]
        let result = map.visibleAsteroids(from: origin).count
        XCTAssertEqual(result, 1)
    }

    // MARK: - Calculate all distances
    func testDistanceInAllTilesIsCalculated() {
        let tile1 = Tile(object: .asteroid, position: Position(x: 1, y: 2))
        let tile2 = Tile(object: .asteroid, position: Position(x: 2, y: 4))
        let tile3 = Tile(object: .asteroid, position: Position(x: 4, y: 8))
        let tile4 = Tile(object: .asteroid, position: Position(x: 10, y: 20))
        let tile5 = Tile(object: .asteroid, position: Position(x: 100, y: 200))
        let originalMap = [tile1, tile2, tile3, tile4, tile5]

        let map = originalMap.countAsteroids()

        XCTAssertEqual(map[0].visibleAsteroids, 1)
        XCTAssertEqual(map[1].visibleAsteroids, 2)
        XCTAssertEqual(map[2].visibleAsteroids, 2)
        XCTAssertEqual(map[3].visibleAsteroids, 2)
        XCTAssertEqual(map[4].visibleAsteroids, 1)
    }

    // MARK: - Filter asteroids

    func testEmptySpacesAreFiltered() {
        let tile1 = Tile(object: .asteroid, position: Position(x: 1, y: 2))
        let tile2 = Tile(object: .empty, position: Position(x: 2, y: 4))
        let tile3 = Tile(object: .empty, position: Position(x: 4, y: 8))
        let tile4 = Tile(object: .asteroid, position: Position(x: 10, y: 20))
        let tile5 = Tile(object: .empty, position: Position(x: 100, y: 200))
        let originalMap = [tile1, tile2, tile3, tile4, tile5]
        let expected = [tile1, tile4]

        let map = originalMap.allAsteroids()

        XCTAssertEqual(map, expected)
    }

    // MARK: - Find max

    func testMaxAsteroidsNumberIsFound() {
        let tile1 = Tile(object: .asteroid, position: Position(x: 1, y: 2), visibleAsteroids: 4)
        let tile2 = Tile(object: .asteroid, position: Position(x: 2, y: 4), visibleAsteroids: 7)
        let tile3 = Tile(object: .asteroid, position: Position(x: 4, y: 8), visibleAsteroids: -2)
        let map = [tile1, tile2, tile3]

        let result = map.maxAsteroids()

        XCTAssertEqual(result, 7)
    }

    // MARK: - Read from text

    func testTextCanBeConvertedToMap() {
        let text = ".#.\n###\n..."
        let tile1 = Tile(object: .empty, position: Position(x: 0, y: 0))
        let tile2 = Tile(object: .asteroid, position: Position(x: 1, y: 0))
        let tile3 = Tile(object: .empty, position: Position(x: 2, y: 0))
        let tile4 = Tile(object: .asteroid, position: Position(x: 0, y: 1))
        let tile5 = Tile(object: .asteroid, position: Position(x: 1, y: 1))
        let tile6 = Tile(object: .asteroid, position: Position(x: 2, y: 1))
        let tile7 = Tile(object: .empty, position: Position(x: 0, y: 2))
        let tile8 = Tile(object: .empty, position: Position(x: 1, y: 2))
        let tile9 = Tile(object: .empty, position: Position(x: 2, y: 2))
        let expected = [tile1, tile2, tile3, tile4, tile5, tile6, tile7, tile8, tile9]

        let result = AsteroidMap(from: text)

        XCTAssertEqual(result, expected)
    }

    // MARK: - Examples from especification
    func testSimpleExample() {
        let text = """
            .#..#
            .....
            #####
            ....#
            ...##
            """
        let result = AsteroidMap(from: text).countMaxAsteroids()
        XCTAssertEqual(result, 8)
    }

    func testExample1() {
        let text = """
            ......#.#.
            #..#.#....
            ..#######.
            .#.#.###..
            .#..#.....
            ..#....#.#
            #..#....#.
            .##.#..###
            ##...#..#.
            .#....####
            """
        let result = AsteroidMap(from: text).countMaxAsteroids()
        XCTAssertEqual(result, 33)
    }

    func testExample2() {
        let text = """
            #.#...#.#.
            .###....#.
            .#....#...
            ##.#.#.#.#
            ....#.#.#.
            .##..###.#
            ..#...##..
            ..##....##
            ......#...
            .####.###.
            """
        let result = AsteroidMap(from: text).countMaxAsteroids()
        XCTAssertEqual(result, 35)
    }

    func testExample3() {
        let text = """
            .#..#..###
            ####.###.#
            ....###.#.
            ..###.##.#
            ##.##.#.#.
            ....###..#
            ..#.#..#.#
            #..#.#.###
            .##...##.#
            .....#.#..
            """
        let result = AsteroidMap(from: text).countMaxAsteroids()
        XCTAssertEqual(result, 41)
    }

    func testComplexExample() {
        let text = """
            .#..##.###...#######
            ##.############..##.
            .#.######.########.#
            .###.#######.####.#.
            #####.##.#.##.###.##
            ..#####..#.#########
            ####################
            #.####....###.#.#.##
            ##.#################
            #####.##.###..####..
            ..######..##.#######
            ####.##.####...##..#
            .#####..#.######.###
            ##...#.##########...
            #.##########.#######
            .####.#.###.###.#.##
            ....##.##.###..#####
            .#.#.###########.###
            #.#.#.#####.####.###
            ###.##.####.##.#..##
            """
        let result = AsteroidMap(from: text).countMaxAsteroids()
        XCTAssertEqual(result, 210)
    }

    func testDay10Part1() {
        XCTAssertEqual(Day10().maxAsteroids(), 282)
    }

    // MARK: - Part two
    func testAllVisibleAsteroidsCanBeSeparated() {
        let text = """
            .#....#####...#..
            ##...##.#####..##
            ##...#...#.#####.
            ..#.....#...###..
            ..#.#.....#....##
            """
        let expected = [Tile(object: .asteroid, position: Position(x: 8, y: 1)),
            Tile(object: .asteroid, position: Position(x: 9, y: 0)),
            Tile(object: .asteroid, position: Position(x: 9, y: 1)),
            Tile(object: .asteroid, position: Position(x: 10, y: 0)),
            Tile(object: .asteroid, position: Position(x: 9, y: 2)),
            Tile(object: .asteroid, position: Position(x: 11, y: 1)),
            Tile(object: .asteroid, position: Position(x: 12, y: 1)),
            Tile(object: .asteroid, position: Position(x: 11, y: 2)),
            Tile(object: .asteroid, position: Position(x: 15, y: 1)),
            Tile(object: .asteroid, position: Position(x: 12, y: 2)),
            Tile(object: .asteroid, position: Position(x: 13, y: 2)),
            Tile(object: .asteroid, position: Position(x: 14, y: 2)),
            Tile(object: .asteroid, position: Position(x: 15, y: 2)),
            Tile(object: .asteroid, position: Position(x: 12, y: 3)),
            Tile(object: .asteroid, position: Position(x: 16, y: 4)),
            Tile(object: .asteroid, position: Position(x: 15, y: 4)),
            Tile(object: .asteroid, position: Position(x: 10, y: 4)),
            Tile(object: .asteroid, position: Position(x: 4, y: 4)),
            Tile(object: .asteroid, position: Position(x: 2, y: 4)),
            Tile(object: .asteroid, position: Position(x: 2, y: 3)),
            Tile(object: .asteroid, position: Position(x: 0, y: 2)),
            Tile(object: .asteroid, position: Position(x: 1, y: 2)),
            Tile(object: .asteroid, position: Position(x: 0, y: 1)),
            Tile(object: .asteroid, position: Position(x: 1, y: 1)),
            Tile(object: .asteroid, position: Position(x: 5, y: 2)),
            Tile(object: .asteroid, position: Position(x: 1, y: 0)),
            Tile(object: .asteroid, position: Position(x: 5, y: 1)),
            Tile(object: .asteroid, position: Position(x: 6, y: 1)),
            Tile(object: .asteroid, position: Position(x: 6, y: 0)),
            Tile(object: .asteroid, position: Position(x: 7, y: 0))
        ]

        let result = AsteroidMap(from: text).allAsteroids().visibleAsteroids(from: Position(x: 8, y: 3))

        XCTAssertEqual(result, expected)
    }

    func testComplexExample200thAsteroid() {
        let text = """
            .#..##.###...#######
            ##.############..##.
            .#.######.########.#
            .###.#######.####.#.
            #####.##.#.##.###.##
            ..#####..#.#########
            ####################
            #.####....###.#.#.##
            ##.#################
            #####.##.###..####..
            ..######..##.#######
            ####.##.####...##..#
            .#####..#.######.###
            ##...#.##########...
            #.##########.#######
            .####.#.###.###.#.##
            ....##.##.###..#####
            .#.#.###########.###
            #.#.#.#####.####.###
            ###.##.####.##.#..##
            """
        let position = Position(x: 11, y: 13)
        let destroyed = AsteroidMap(from: text).destroyedAsteroids(from: position)
        XCTAssertEqual(destroyed[199].position, Position(x: 8, y: 2))
    }

    func testDay10Part2() {
        XCTAssertEqual(Day10().betAsteroidEncodedPosition(), 1008)
    }

    func testDebugDescriptionOfTileContainsObjectAndPosition() {
        let tile = Tile(object: .asteroid, position: Position(x: 9, y: 0))
        let description = tile.debugDescription
        XCTAssertEqual(description, "# (9,0)")
    }
}
