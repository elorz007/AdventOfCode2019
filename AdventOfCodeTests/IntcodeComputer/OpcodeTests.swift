//
//  OpcodeTests.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

import XCTest

class OpcodeTests: XCTestCase {
    func testWhenFirstParameterModeIs0ThenItIsPosition() {
        let opcode = Opcode(position: 0, rawValue: 7)
        XCTAssertEqual(opcode.mode1, .Position)
    }
    func testWhenFirstParameterModeIs1ThenItIsInmediate() {
        let opcode = Opcode(position: 0, rawValue: 107)
        XCTAssertEqual(opcode.mode1, .Inmediate)
    }

    func testWhenFirstParameterModeIs2ThenItIsRelative() {
        let opcode = Opcode(position: 0, rawValue: 207)
        XCTAssertEqual(opcode.mode1, .Relative)
    }

    func testWhenSecondParameterModeIs0ThenItIsPosition() {
        let opcode = Opcode(position: 0, rawValue: 7)
        XCTAssertEqual(opcode.mode2, .Position)
    }
    func testWhenSecondParameterModeIs1ThenItIsInmediate() {
        let opcode = Opcode(position: 0, rawValue: 1007)
        XCTAssertEqual(opcode.mode2, .Inmediate)
    }

    func testWhenSecondParameterModeIs2ThenItIsRelative() {
        let opcode = Opcode(position: 0, rawValue: 2007)
        XCTAssertEqual(opcode.mode2, .Relative)
    }

    func testWhenThirdParameterModeIs0ThenItIsPosition() {
        let opcode = Opcode(position: 0, rawValue: 7)
        XCTAssertEqual(opcode.mode3, .Position)
    }
    func testWhenThirdParameterModeIs1ThenItIsInmediate() {
        let opcode = Opcode(position: 0, rawValue: 10007)
        XCTAssertEqual(opcode.mode3, .Inmediate)
    }

    func testWhenThirdParameterModeIs2ThenItIsRelative() {
        let opcode = Opcode(position: 0, rawValue: 20007)
        XCTAssertEqual(opcode.mode3, .Relative)
    }

    func test200IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 20007)
        XCTAssertEqual(opcode.mode1, .Position)
        XCTAssertEqual(opcode.mode2, .Position)
        XCTAssertEqual(opcode.mode3, .Relative)
    }

    func test201IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 20107)
        XCTAssertEqual(opcode.mode1, .Inmediate)
        XCTAssertEqual(opcode.mode2, .Position)
        XCTAssertEqual(opcode.mode3, .Relative)
    }

    func test202IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 20207)
        XCTAssertEqual(opcode.mode1, .Relative)
        XCTAssertEqual(opcode.mode2, .Position)
        XCTAssertEqual(opcode.mode3, .Relative)
    }

    func test212IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 21207)
        XCTAssertEqual(opcode.mode1, .Relative)
        XCTAssertEqual(opcode.mode2, .Inmediate)
        XCTAssertEqual(opcode.mode3, .Relative)
    }

    func test222IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 22207)
        XCTAssertEqual(opcode.mode1, .Relative)
        XCTAssertEqual(opcode.mode2, .Relative)
        XCTAssertEqual(opcode.mode3, .Relative)
    }

    func test122IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 12207)
        XCTAssertEqual(opcode.mode1, .Relative)
        XCTAssertEqual(opcode.mode2, .Relative)
        XCTAssertEqual(opcode.mode3, .Inmediate)
    }

    func test112IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 11207)
        XCTAssertEqual(opcode.mode1, .Relative)
        XCTAssertEqual(opcode.mode2, .Inmediate)
        XCTAssertEqual(opcode.mode3, .Inmediate)
    }

    func test111IsParsed() {
        let opcode = Opcode(position: 0, rawValue: 11107)
        XCTAssertEqual(opcode.mode1, .Inmediate)
        XCTAssertEqual(opcode.mode2, .Inmediate)
        XCTAssertEqual(opcode.mode3, .Inmediate)
    }
}
