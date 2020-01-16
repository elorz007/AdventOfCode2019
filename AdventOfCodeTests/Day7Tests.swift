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
    
    // MARK:-
    func DISABLED_testFindHighestSignal() {
        let d7 = Day7()
        XCTAssertEqual(d7.findHighestSignal(), 67023)
    }
}
