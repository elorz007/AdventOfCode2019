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

    // MARK: - Visible asteroids
    func testTwoAsteroidsInLineOfSightAreCountedAsOne() {
        let origin = Position(x: 0, y: 0)
        let tile1 = Tile(object: .asteroid, position: origin)
        let tile2 = Tile(object: .asteroid, position: Position(x: 1, y: 0))
        let tile3 = Tile(object: .asteroid, position: Position(x: 10, y: 0))
        let map = [tile1, tile2, tile3]
        let result = map.asteroidsVisible(in: origin)
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
        let result = map.asteroidsVisible(in: origin)
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

        let result = Day10().map(from: text)

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
        let result = Day10().map(from: text).countMaxAsteroids()
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
        let result = Day10().map(from: text).countMaxAsteroids()
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
        let result = Day10().map(from: text).countMaxAsteroids()
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
        let result = Day10().map(from: text).countMaxAsteroids()
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
        let result = Day10().map(from: text).countMaxAsteroids()
        XCTAssertEqual(result, 210)
    }

    func testDay10Part1() {
        XCTAssertEqual(Day10().maxAsteroids(), 282)
    }
}
