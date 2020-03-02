//
//  Color.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 02.03.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

enum Color: Int {
    case black = 0
    case white = 1
    case transparent = 2
}

extension Color: CustomStringConvertible {
    var description: String {
        var result: String
        switch self {
        case .black:
            result = "⬛"
        case .white:
            result = "⬜"
        case .transparent:
            result = "🟨"
        }
        return result
    }
}
