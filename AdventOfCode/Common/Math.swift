//
//  Math.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 04.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

func leastCommonMultiple(_ a: Int, _ b: Int, _ c: Int) -> Int {
    return leastCommonMultiple(a, leastCommonMultiple(b, c))
}
func leastCommonMultiple(_ a: Int, _ b: Int) -> Int {
    return abs(a * b) / greatestCommonDivisor(a, b)
}
func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
    return b == 0 ? a : greatestCommonDivisor(b, a % b)
}
