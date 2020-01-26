//
//  Day7Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 15.01.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day7Tests: XCTestCase {
    func testLimitOf1GeneratesAllResults() {
        assert(phaseSettingLimit: 1, produces: [
            [0]
        ])
    }
    
    func testLimitOf2GeneratesGeneratesAllResults() {
        assert(phaseSettingLimit: 2, produces: [
            [0,1],
            [1,0],
        ])
    }
    
    func testLimitOf3GeneratesGeneratesAllResults() {
        assert(phaseSettingLimit: 3, produces: [
             [0,1,2],
             [1,0,2],
             [2,0,1],
             [0,2,1],
             [1,2,0],
             [2,1,0],
        ])
    }
    
    func testLimitOf4Generates24Results() {
        assert(phaseSettingLimit: 4, producesCount: 24)
    }
    
    func assert(phaseSettingLimit n:UInt, produces expected:Set<PhaseSettings>) {
        let all = PhaseSettingsLimit(n:n).all()
        XCTAssertEqual(expected, all)
    }
    
    func assert(phaseSettingLimit n:UInt, producesCount expected:Int) {
        let all = PhaseSettingsLimit(n:n).all()
        XCTAssertEqual(expected, all.count)
    }
    
    func test_SLOW_FindHighestSignal() {
        let d7 = Day7()
        XCTAssertEqual(d7.findHighestSignal(), 67023)
    }
    
    // MARK:-

    func testAdventOfCodeExample1() {
        let example = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
        let d7 = Day7()
        d7.inputCache = example
        let result = d7.runAmplifiersInFeedbackMode(phaseSettings: [9,8,7,6,5])
        XCTAssertEqual(result, 139629729)
    }
    
    func testAdventOfCodeExample1GivesTheSameResultWhenRunMultipleTimes() {
        for _ in 1...100 {
            testAdventOfCodeExample1()
        }
    }
    
    func testAdventOfCodeExample2() {
        let example = "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"
        let d7 = Day7()
        d7.inputCache = example
        let result = d7.runAmplifiersInFeedbackMode(phaseSettings: [9,7,8,5,6])
        XCTAssertEqual(result, 18216)
    }
    
    func testAdventOfCodeExample2GivesTheSameResultWhenRunMultipleTimes() {
        for _ in 1...100 {
            testAdventOfCodeExample2()
        }
    }
    
    func test_SLOW_FindHighestSignalInFeedbackMode() {
        let d7 = Day7()
        XCTAssertEqual(d7.findHighestSignalInFeedbackMode(), 7818398)
    }
}
