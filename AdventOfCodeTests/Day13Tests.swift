//
//  Day13Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day13Tests: XCTestCase {
    func testWhenExamplOutputIsGivenThenTwoTilesAreParsed() {
        let cabinet = cabinetWithExampleOutput()
        XCTAssertEqual(cabinet.tiles.count, 2)
    }

    func testWhenExamplOutputIsGivenThenFirstTileIsAPaddleInTheCorrectPosition() {
        let cabinet = cabinetWithExampleOutput()
        let expected = ArcadeTile(type: .Paddle, position: Position(x: 1, y: 2))
        let result = cabinet.tiles[0]
        XCTAssertEqual(expected, result)
    }

    func testWhenExamplOutputIsGivenThenSecondTileIsABallInTheCorrectPosition() {
        let cabinet = cabinetWithExampleOutput()
        let expected = ArcadeTile(type: .Ball, position: Position(x: 6, y: 5))
        let result = cabinet.tiles[1]
        XCTAssertEqual(expected, result)
    }

    func cabinetWithExampleOutput() -> ArcadeCabinet {
        let computerMock = IntcodeComputerMock()
        computerMock.outputs = [1, 2, 3, 6, 5, 4]
        let cabinet = ArcadeCabinet(computer: computerMock)
        cabinet.run()
        return cabinet
    }
}
