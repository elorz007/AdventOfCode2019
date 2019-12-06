//
//  Day1.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

class FuelCalculator: NSObject {
    func fuel(mass: Int) -> Int {
        return (mass / 3) - 2
    }
}

class Day1: NSObject {
    func fetchInput() -> String? {
        let file = "Day1.txt"
        return try? String(contentsOfFile: file)
    }
}
