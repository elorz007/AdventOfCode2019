//
//  Day.swift
//  AdventOfCodeFramework
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

public class Day: NSObject {
    func input() -> String {
        // swiftlint:disable force_try
        let bundle = Bundle(for: type(of: self))
        let fileName = String(self.className.split(separator: ".").last!)
        let paht = bundle.path(forResource: fileName, ofType: "txt")!
        return try! String(contentsOfFile: paht).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        // swiftlint:enable force_try
    }
}
