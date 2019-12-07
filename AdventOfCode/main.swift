//
//  main.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 06.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Foundation

print("Advent Of Code starting!")

let d1 = Day1()
print("[Day1] Total fuel: " + String(d1.totalFuel()))
print("[Day1] Total real fuel: " + String(d1.totalRealFuel()))

let d2 = Day2()
print("[Day2] Restored state: " + String(d2.restoredState()))
print("[Day2] Noun and Verb: " + String(d2.findNounAndVerb()))

let d3 = Day3()
print("[Day3] Manhattan distance of closest intersection: " + String(d3.mahattanDistanceOfClosestIntersection()))
print("[Day3] Steps taken of fastest intersection: " + String(d3.stepsOfFastestIntersection()))

