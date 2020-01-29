//
//  Day8.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 29.01.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa


struct Dimension {
    static let PasswordImage = Dimension(width: 25, height: 6)
    let width: Int
    let height: Int
    var total: Int { width * height }
}

typealias Layer<T> = [T]

struct Image<T> {
    let layers: [Layer<T>]
}

protocol ValueTransformer {
    associatedtype Source
    associatedtype Destination
    func transform(value: Source) -> Destination
}

class CharacterToIntValueTransformer: ValueTransformer {
    typealias Source = String.Element
    typealias Destination = Int
    func transform(value: Source) -> Destination {
        value.wholeNumberValue!
    }
}

class ImageReader<Transformer> where Transformer : ValueTransformer, Transformer.Source == String.Element {
    let target: Dimension
    let transformer: Transformer
    init(transformer: Transformer, target: Dimension) {
        self.transformer = transformer
        self.target = target
    }
    func read(_ input:String) -> Image<Transformer.Destination> {
        var layers = [Layer<Transformer.Destination>]()
        var currentLayer = Layer<Transformer.Destination>()
        for (index, char) in input.enumerated() {
            currentLayer.append(transformer.transform(value: char))
            if ((index + 1) % target.total == 0) {
                layers.append(currentLayer)
                currentLayer = Layer()
            }
        }
        return Image(layers: layers)
    }
}



extension ImageReader where Transformer == CharacterToIntValueTransformer {
    convenience init(target: Dimension = Dimension.PasswordImage) {
        self.init(transformer: CharacterToIntValueTransformer(), target:target)
    }
}
typealias DefaultImageReader = ImageReader<CharacterToIntValueTransformer>



extension Layer where Element : Numeric {
    func numberOfZeroes() -> Int {
        numberOf(0)
    }
    
    func numberOfOnes() -> Int {
        numberOf(1)
    }

    func numberOfTwos() -> Int {
        numberOf(2)
    }
    
    func numberOf(_ toCheck: Element) -> Int {
        self.filter { $0 == toCheck}.count
    }
}

extension Image where T : Numeric {
    func layerWithMostZeroes() -> Layer<T>? {
        self.layers.max { a, b in a.numberOfZeroes() < b.numberOfZeroes() }
    }
}

extension Image where T: Numeric {
    func checksum() -> Int {
        var checksum = 0
        if let layer = self.layerWithMostZeroes() {
            checksum = layer.numberOfOnes() * layer.numberOfTwos()
        }
        return checksum
    }
}

class Day8: NSObject {
//    func checksumOfPasswordImage() -> Int {
//        
//    }
    func input() -> String {
        try! String(contentsOfFile: "./Day8.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
