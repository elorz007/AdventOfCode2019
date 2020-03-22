//
//  GeometryTests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 22.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class GeometryTests: XCTestCase {

    func testWhenDirectionIsUpAndItsRotatedLeftThenDirectionIsLeft() {
        assert(direction: .up, rotated: .left, equals: .left)
    }

    func testWhenDirectionIsUpAndItsRotatedRightThenDirectionIsRight() {
        assert(direction: .up, rotated: .right, equals: .right)
    }

    func testWhenDirectionIsLeftAndItsRotatedRightThenDirectionIsUp() {
        assert(direction: .left, rotated: .right, equals: .up)
    }

    func testWhenDirectionIsLeftAndItsRotatedLeftThenDirectionIsDown() {
        assert(direction: .left, rotated: .left, equals: .down)
    }

    func testWhenDirectionIsDownAndItsRotatedRightThenDirectionIsLeft() {
        assert(direction: .down, rotated: .right, equals: .left)
    }

    func testWhenDirectionIsDownAndItsRotatedLeftThenDirectionIsRight() {
        assert(direction: .down, rotated: .left, equals: .right)
    }

    func testWhenDirectionIsRightAndItsRotatedRightThenDirectionIsDown() {
        assert(direction: .right, rotated: .right, equals: .down)
    }

    func testWhenDirectionIsRightAndItsRotatedLeftThenDirectionIsUp() {
        assert(direction: .right, rotated: .left, equals: .up)
    }

    func testWhenDirectionIsRotatedFourTimesInTheSameDirectionhenItDoesntChange() {
        let initial = Direction.up
        var direction = initial
        for _ in 1...4 {
            direction.rotate(.right)
        }
        XCTAssertEqual(initial, direction)
    }

    func assert(direction initial: Direction, rotated rotation: Rotation, equals expected: Direction) {
        var direction = initial
        direction.rotate(rotation)
        XCTAssertEqual(direction, expected)
    }

}
