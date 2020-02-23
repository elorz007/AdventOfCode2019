//
//  Day3Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 07.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day3Tests: XCTestCase {

    func testParserCanParseUpInstruction() {
        let expected = [Instruction(direction: .up, steps: 13)]
        assert(input: "U13", isEqualTo: expected)
    }

    func testParserCanParseDownInstruction() {
        let expected = [Instruction(direction: .down, steps: 999)]
        assert(input: "D999", isEqualTo: expected)
    }

    func testParserCanParseLeftInstruction() {
        let expected = [Instruction(direction: .left, steps: 999)]
        assert(input: "L999", isEqualTo: expected)
    }

    func testParserCanParseRightInstruction() {
        let expected = [Instruction(direction: .right, steps: 999)]
        assert(input: "R999", isEqualTo: expected)
    }

    func testParserCanParseMultipleInstruction() {
        let expected = [Instruction(direction: .right, steps: 999),
                        Instruction(direction: .down, steps: 123),
                        Instruction(direction: .up, steps: 1)]
        assert(input: "R999,D123,U1", isEqualTo: expected)
    }

    func assert(input: String, isEqualTo wire: Wire) {
        let parser = WireParser()
        let result = parser.parse(input)
        XCTAssertEqual(result, wire)
    }

    // MARK: -

    func testExtendingWireOneStepDown() {
        let wire = [Instruction(direction: .down, steps: 1)]
        let expected: Path = [Point(x: 0, y: 0), Point(x: 0, y: -1)]
        assert(wire: wire, extendsTo: expected)
    }

    func testExtendingWireOneStepUp() {
        let wire = [Instruction(direction: .up, steps: 1)]
        let expected: Path = [Point(x: 0, y: 0), Point(x: 0, y: 1)]
        assert(wire: wire, extendsTo: expected)
    }

    func testExtendingWireOneStepLeft() {
        let wire = [Instruction(direction: .left, steps: 1)]
        let expected: Path = [Point(x: 0, y: 0), Point(x: -1, y: 0)]
        assert(wire: wire, extendsTo: expected)
    }

    func testExtendingWireOneStepRight() {
        let wire = [Instruction(direction: .right, steps: 1)]
        let expected: Path = [Point(x: 0, y: 0), Point(x: 1, y: 0)]
        assert(wire: wire, extendsTo: expected)
    }

    func testExtendingWireMultipleSteps() {
        let wire = [Instruction(direction: .right, steps: 3)]
        let expected: Path = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0)]
        assert(wire: wire, extendsTo: expected)
    }

    func testExtendingWireMultipleInstructions() {
        let wire = [Instruction(direction: .right, steps: 3),
                    Instruction(direction: .left, steps: 1),
                    Instruction(direction: .up, steps: 2),
                    Instruction(direction: .down, steps: 3)]
        let expected: Path = [Point(x: 0, y: 0),
                              Point(x: 1, y: 0),
                              Point(x: 2, y: 0),
                              Point(x: 3, y: 0),
                              Point(x: 2, y: 0),
                              Point(x: 2, y: 1),
                              Point(x: 2, y: 2),
                              Point(x: 2, y: 1),
                              Point(x: 2, y: 0),
                              Point(x: 2, y: -1)]
        assert(wire: wire, extendsTo: expected)
    }

    func testExtendingWireMultipleInstructionsCalculatesNumberOfSteps() {
        let wire = [Instruction(direction: .right, steps: 3),
                    Instruction(direction: .left, steps: 1),
                    Instruction(direction: .up, steps: 2),
                    Instruction(direction: .down, steps: 3)]

        let extender = WireExtender()
        let result = extender.extend(wire)
        XCTAssertEqual(result.sorted { $0.stepsTaken < $1.stepsTaken }.last!.stepsTaken, 9)
    }

    func assert(wire: Wire, extendsTo path: Path) {
        let extender = WireExtender()
        let result = extender.extend(wire)

        XCTAssertEqual(result, path)
    }

    // MARK: -
    func testManhattanDistanceOfPositiveNumbers() {
        let p = Point(x: 1, y: 10)
        XCTAssertEqual(p.manhattanDistance, 11)
    }

    func testManhattanDistanceOfNegativeNumbers() {
        let p = Point(x: -1, y: -10)
        XCTAssertEqual(p.manhattanDistance, 11)
    }

    // MARK: -
    func testClosestPointWithOneIntersection() {
        let p1: Path = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0)]
        let p2: Path = [Point(x: 0, y: 0), Point(x: 3, y: 0)]
        let pathActions = PathActions()
        let result = pathActions.closestIntersection(p1, p2)
        let expected = Point(x: 3, y: 0)
        XCTAssertEqual(result, expected)
    }

    func testClosestPointWithNoIntersection() {
        let p1: Path = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0)]
        let p2: Path = [Point(x: 0, y: 0), Point(x: 5, y: 0)]
        let pathActions = PathActions()
        let result = pathActions.closestIntersection(p1, p2)
        XCTAssertNil(result)
    }

    func testClosestPointWithMultipleIntersections() {
        let p1: Path = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0)]
        let p2: Path = [Point(x: 0, y: 0), Point(x: 3, y: 0), Point(x: 1, y: 0)]
        let pathActions = PathActions()
        let result = pathActions.closestIntersection(p1, p2)
        let expected = Point(x: 1, y: 0)
        XCTAssertEqual(result, expected)
    }

    // MARK: -
    func testMahattanDistanceOfClosestIntersection() {
        let d3 = Day3()
        XCTAssertEqual(d3.mahattanDistanceOfClosestIntersection(), 316)
    }

    // MARK: -
    func testFastestPointWithOneIntersection() {
        let p1: Path = [Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0, stepsTaken: 5)]
        let p2: Path = [Point(x: 0, y: 0), Point(x: 3, y: 0, stepsTaken: 3)]
        let pathActions = PathActions()
        let result = pathActions.fastestIntersection(p1, p2)
        let expected = Point(x: 3, y: 0, stepsTaken: 8)
        XCTAssertEqual(result, expected)
        XCTAssertEqual(result!.stepsTaken, expected.stepsTaken)
    }

    func testFastestPointWithMultipleIntersections() {
        let p1: Path = [Point(x: 0, y: 0),
                        Point(x: 1, y: 0, stepsTaken: 100),
                        Point(x: 2, y: 0),
                        Point(x: 0, y: 1, stepsTaken: 3)]
        let p2: Path = [Point(x: 0, y: 0),
                        Point(x: 0, y: 1, stepsTaken: 2),
                        Point(x: 1, y: 0, stepsTaken: 1)]
        let pathActions = PathActions()
        let result = pathActions.fastestIntersection(p1, p2)
        let expected = Point(x: 0, y: 1, stepsTaken: 5)
        XCTAssertEqual(result, expected)
        XCTAssertEqual(result!.stepsTaken, expected.stepsTaken)
    }

    func testExampleFromDefinistion() {
        let d3 = Day3()
        let (path1, path2) = d3.pathsFrom(input: "R75,D30,R83,U83,L12,D49,R71,U7,L72\nU62,R66,U55,R34,D71,R55,D58,R83")
        let pathActions = PathActions()
        let fastestIntersection = pathActions.fastestIntersection(path1, path2)
        XCTAssertEqual(fastestIntersection!.stepsTaken, 610)
    }

    func testExampleFromDefinistion2() {
        let d3 = Day3()
        // swiftlint:disable line_length
        let (path1, path2) = d3.pathsFrom(input: "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51\nU98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
        // swiftlint:enable line_length
        let pathActions = PathActions()
        let fastestIntersection = pathActions.fastestIntersection(path1, path2)
        XCTAssertEqual(fastestIntersection!.stepsTaken, 410)
    }

    func test_SLOW_StepsOfFastestIntersection() {
        let d3 = Day3()
        XCTAssertEqual(d3.stepsOfFastestIntersection(), 16368)
    }

}
