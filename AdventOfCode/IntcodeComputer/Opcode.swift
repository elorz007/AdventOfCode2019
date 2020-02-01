//
//  Opcode.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 01.02.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

struct Opcode {
    let position: Int
    let value: Int
    let mode1: ParameterMode
    let mode2: ParameterMode
    let mode3: ParameterMode
    
    init(position:Int, rawValue:Int) {
        self.position = position
        self.value = rawValue % 100
        let parameterCount = ParameterMode.allCases.count
        mode1 = ParameterMode(((rawValue / 100) % 10) % parameterCount)
        mode2 = ParameterMode(((rawValue / 1000) % 10) % parameterCount)
        mode3 = ParameterMode(((rawValue / 10000) % 10) % parameterCount)
    }
}

enum ParameterMode : CaseIterable {
    case Position
    case Inmediate
    case Relative
}

fileprivate extension ParameterMode {
    init(_ value: Int) {
        switch value {
        case 0: self = .Position
        case 1: self = .Inmediate
        case 2: self = .Relative
        default: self = .Position
        }
    }
}
