//
//  Day4Tests.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 07.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day4Tests: XCTestCase {
    
    func testValidPassword() {
        assertIsValid(password:[1,1,2,2,3,3])
    }
    
    func testValidPasswordEvenWithGroup() {
        assertIsValid(password:[1,1,1,1,2,2])
    }
    
    func testInvalidPasswordLargerGroup() {
        assertIsInvalid(password:[1,2,3,4,4,4])
    }
    
    func testInValidPasswordDecreasingNumbers() {
        assertIsInvalid(password:[2,2,3,4,5,0])
    }
    
    func testInValidPasswordNoPairs() {
        assertIsInvalid(password:[1,2,3,7,8,9])
    }
    
    func assertIsValid(password: Password) {
        let checker = PasswordChecker()
        XCTAssertTrue(checker.isValid(password))
    }
    
    func assertIsInvalid(password: Password) {
        let checker = PasswordChecker()
        XCTAssertFalse(checker.isValid(password))
    }
    
    func DISABLED_testStepsOfFastestIntersection() {
        let d4 = Day4()
        XCTAssertEqual(d4.numberOfDifferentPasswords(), 591)
    }
}
