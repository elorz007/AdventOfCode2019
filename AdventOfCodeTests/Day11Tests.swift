//
//  Day11Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 02.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class IntcodeComputerMock: IntcodeComputer {
    override func run() {
    }
}

//class PaintingRobotMock : PaintingRobot {
//    override func run() {
//    }
//}

class Day11Tests: XCTestCase {

    func testWhenColorIsBlackThenBinaryIs0() {
        XCTAssertEqual(PanelColor.black.rawValue, 0)
    }

    func testWhenColorIsWhiteThenBinaryIs1() {
        XCTAssertEqual(PanelColor.white.rawValue, 1)
    }

    func testWhenPaintingRobotStartsThenTheColorIsBlack() {
        let robot = PaintingRobot(computer: IntcodeComputerMock())
        robot.run()
        let color = robot.panels[Position(x: 0, y: 0)]
        XCTAssertEqual(color, .black)
    }

    func testWhenRobotIsOverBlackPanelThenItProvides0() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        robot.currentPosition = Position(x: 11, y: 22)
        robot.panels = [robot.currentPosition: .black]
        let provided = computerMock.input!()
        XCTAssertEqual(provided, 0)
    }

    func testWhenRobotIsOverWhitePanelThenItProvides1() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        robot.currentPosition = Position(x: 22, y: 33)
        robot.panels = [robot.currentPosition: .white]
        let provided = computerMock.input!()
        XCTAssertEqual(provided, 1)
    }

    func testWhenRobotIsGiven0ThenBlackIsInserted() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        let startingPosition = Position(x: 11, y: 22)
        robot.currentPosition = startingPosition
        computerMock.output!(0)
        computerMock.output!(0)
        let writtenColor = robot.panels[startingPosition]
        XCTAssertEqual(writtenColor, .black)
    }

    func testWhenRobotIsGiven1ThenWhiteIsInserted() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        let startingPosition = Position(x: 11, y: 22)
        robot.currentPosition = startingPosition
        computerMock.output!(1)
        computerMock.output!(0)
        let writtenColor = robot.panels[startingPosition]
        XCTAssertEqual(writtenColor, .white)
    }

    func testWhenRobotIsFacingUpAndTurnedLeftThenItMovesLeft() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        robot.currentPosition = Position(x: 0, y: 0)
        computerMock.output!(0)
        computerMock.output!(0)
        let newPosition = robot.currentPosition
        XCTAssertEqual(newPosition, Position(x: -1, y: 0))
    }
}
