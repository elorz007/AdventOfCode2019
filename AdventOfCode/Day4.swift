//
//  Day4.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 07.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

typealias Digit = Int
typealias Password = [Digit]

extension Sequence {
    func isSorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> Bool {
        var iterator = makeIterator()
        guard var previous = iterator.next() else {
            // Sequence is empty
            return true
        }
        while let current = iterator.next() {
            guard try areInIncreasingOrder(previous, current) else {
                return false
            }
            previous = current
        }
        return true
    }
}

extension Password {
    func containsValidDouble() -> Bool {
        var iterator = makeIterator()
        guard var previous = iterator.next() else {
            // Sequence is empty
            return false
        }
        var current: Element?
        current = iterator.next()
        while current != nil {
            if current == previous {
                var partOfLargerGroup = false
                current = iterator.next()
                while current != nil, current == previous {
                    partOfLargerGroup = true
                    current = iterator.next()
                }
                if !partOfLargerGroup {
                    return true
                }
            }
            if current != nil {
                previous = current!
                current = iterator.next()
            }
        }
        return false
    }
}

class PasswordChecker: NSObject {
    func isValid(_ password: Password) -> Bool {
        let neverDecreases = password.isSorted(by: <=)
        let containsDouble = password.containsValidDouble()
        return neverDecreases && containsDouble
    }

}

public class Day4: Day {
    public func numberOfDifferentPasswords() -> UInt {
        var count: UInt = 0
        let checker = PasswordChecker()
        for passwordNumber in 284639...748759 {
            let password = String(passwordNumber).map { Digit(String($0))! }
            if checker.isValid(password) {
                count += 1
            }
        }
        return count
    }
}
