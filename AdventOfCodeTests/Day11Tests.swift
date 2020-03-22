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

    func testWhenRobotIsGivenARotationThenItFacesANewDirection() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        robot.currentPosition = Position(x: 0, y: 0)
        robot.currentDirection = .left
        computerMock.output!(0)
        computerMock.output!(1)
        XCTAssertEqual(robot.currentDirection, .up)
    }

    func testWhenRobotIsGivenARotationThenItMoves() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        robot.currentPosition = Position(x: 0, y: 0)
        robot.currentDirection = .left
        computerMock.output!(0)
        computerMock.output!(1)
        XCTAssertEqual(robot.currentPosition, Position(x: 0, y: 1))
    }

    func testWhenRobotStartsThenItsFacingUp() {
        let robot = PaintingRobot(computer: IntcodeComputerMock())
        XCTAssertEqual(robot.currentDirection, .up)
    }

    func testWhenRobotStartsThenPositionIs00() {
        let robot = PaintingRobot(computer: IntcodeComputerMock())
        XCTAssertEqual(robot.currentPosition, Position(x: 0, y: 0))
    }

    func testWhenRobotIsGivenExampleOrdersThenItPaints6Panels() {
        let computerMock = IntcodeComputerMock()
        let robot = PaintingRobot(computer: computerMock)
        robot.run()
        [1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 1, 0].forEach { computerMock.output!($0) }
        XCTAssertEqual(robot.coveredArea, 6)
    }

    func testWhenRobotIsGivenFullProgramThenCoveredAreadIs2594() {
        XCTAssertEqual(Day11().coveredArea(), 2594)
    }

    func testWhenRobotIsGivenFullProgramThenRegistrationIdentifierIsAKERJFHK() {
        let expected = """
        ⬛⬛⬜⬜⬛⬛⬜⬛⬛⬜⬛⬜⬜⬜⬜⬛⬜⬜⬜⬛⬛⬛⬛⬜⬜⬛⬜⬜⬜⬜⬛⬜⬛⬛⬜⬛⬜⬛⬛⬜⬛⬛⬛
        ⬛⬜⬛⬛⬜⬛⬜⬛⬜⬛⬛⬜⬛⬛⬛⬛⬜⬛⬛⬜⬛⬛⬛⬛⬜⬛⬜⬛⬛⬛⬛⬜⬛⬛⬜⬛⬜⬛⬜⬛⬛⬛⬛
        ⬛⬜⬛⬛⬜⬛⬜⬜⬛⬛⬛⬜⬜⬜⬛⬛⬜⬛⬛⬜⬛⬛⬛⬛⬜⬛⬜⬜⬜⬛⬛⬜⬜⬜⬜⬛⬜⬜⬛⬛⬛⬛⬛
        ⬛⬜⬜⬜⬜⬛⬜⬛⬜⬛⬛⬜⬛⬛⬛⬛⬜⬜⬜⬛⬛⬛⬛⬛⬜⬛⬜⬛⬛⬛⬛⬜⬛⬛⬜⬛⬜⬛⬜⬛⬛⬛⬛
        ⬛⬜⬛⬛⬜⬛⬜⬛⬜⬛⬛⬜⬛⬛⬛⬛⬜⬛⬜⬛⬛⬜⬛⬛⬜⬛⬜⬛⬛⬛⬛⬜⬛⬛⬜⬛⬜⬛⬜⬛⬛⬛⬛
        ⬛⬜⬛⬛⬜⬛⬜⬛⬛⬜⬛⬜⬜⬜⬜⬛⬜⬛⬛⬜⬛⬛⬜⬜⬛⬛⬜⬛⬛⬛⬛⬜⬛⬛⬜⬛⬜⬛⬛⬜⬛⬛⬛

        """
        XCTAssertEqual(Day11().registrationIdentifierPanels().description, expected)
    }
}
