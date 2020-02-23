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
        max((mass / 3) - 2, 0)
    }

    func realFuel(mass: Int) -> Int {
        if mass > 0 {
            let fuelForMass = fuel(mass: mass)
            return fuelForMass + realFuel(mass: fuelForMass)
        } else {
            return 0
        }
    }
}

class Day1: NSObject {
    func input() -> String {
        try! String(contentsOfFile: "./Day1.txt")
    }

    func totalFuel() -> Int {
        let calculator = FuelCalculator()
        return applyToAllMasses(calculator.fuel)
    }

    func totalRealFuel() -> Int {
        let calculator = FuelCalculator()
        return applyToAllMasses(calculator.realFuel)
    }

    func applyToAllMasses(_ transform: (Int) -> Int) -> Int {
        return allMasses().map(transform).reduce(0, +)
    }

    func allMasses() -> [Int] {
        input().split { $0.isNewline }.map { (Int(String($0)) ?? 0) }
    }
}
