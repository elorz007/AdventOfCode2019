//
//  Day13Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day13Tests: XCTestCase {
    func testWhenExampleOutputIsGivenThenTwoTilesAreParsed() {
        let cabinet = cabinetWithExampleOutput()
        XCTAssertEqual(cabinet.tiles.count, 2)
    }

    func testWhenExampleOutputIsGivenThenFirstTileIsAPaddleInTheCorrectPosition() {
        let cabinet = cabinetWithExampleOutput()
        let position = Position(x: 1, y: 2)
        let expected = ArcadeTile(type: .paddle, position: position)
        let result = cabinet.tiles[position]
        XCTAssertEqual(expected, result)
    }

    func testWhenExampleOutputIsGivenThenSecondTileIsABallInTheCorrectPosition() {
        let cabinet = cabinetWithExampleOutput()
        let position = Position(x: 6, y: 5)
        let expected = ArcadeTile(type: .ball, position: position)
        let result = cabinet.tiles[position]
        XCTAssertEqual(expected, result)
    }

    func cabinetWithExampleOutput() -> ArcadeCabinet {
        let computerMock = IntcodeComputerMock()
        computerMock.outputs = [1, 2, 3, 6, 5, 4]
        let cabinet = ArcadeCabinet(computer: computerMock)
        cabinet.run()
        return cabinet
    }

    func testDay13NumberOfBlockTilesIs318() {
        let d13 = Day13()
        XCTAssertEqual(d13.numberOfBlockTiles(), 318)
    }

    // MARK: -
    func testWhenJoystickLeftValueIsSetThenMinusOneIsGiven() {
        assert(joystick: .left, outputs: -1)
    }

    func testWhenJoystickRightValueIsSetThenOneIsGiven() {
        assert(joystick: .right, outputs: 1)
    }

    func testWhenJoystickNeutralValueIsSetThenZeroIsGiven() {
        assert(joystick: .neutral, outputs: 0)
    }

    func assert(joystick: Joystick, outputs expected: Int) {
        let computerMock = IntcodeComputerMock()
        computerMock.askForInput = 1
        let cabinet = ArcadeCabinet(computer: computerMock)
        cabinet.joystick = joystick
        cabinet.run()
        XCTAssertEqual(computerMock.inputs.first!, expected)
    }

    func testWhenPreInputIsGivenThenItIsExecuted() {
        let computerMock = IntcodeComputerMock()
        computerMock.askForInput = 1
        let cabinet = ArcadeCabinet(computer: computerMock)
        var executed = false
        cabinet.preInput = {
            executed = true
        }
        cabinet.run()
        XCTAssertTrue(executed)
    }

    func testWhenCoinIsInsertedThenProgramHasValue2() {
        let computerMock = IntcodeComputerMock()
        computerMock.program = [0, 5, 5, 5]
        computerMock.askForInput = 1
        let cabinet = ArcadeCabinet(computer: computerMock)
        cabinet.insertCoin()
        XCTAssertEqual(computerMock.program![0], 2)
    }
}
