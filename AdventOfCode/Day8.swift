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
    let dimension: Dimension
    init(layers: [Layer<T>], dimension: Dimension) {
        self.layers = layers
        self.dimension = dimension
    }
    init(layers: [Layer<T>]) {
        self.init(layers:layers, dimension:Dimension(width: 0, height: 0))
    }
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

class CharacterToColorValueTransformer: ValueTransformer {
    typealias Source = String.Element
    typealias Destination = Color
    func transform(value: Source) -> Destination {
        Color(rawValue: value.wholeNumberValue!)!
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
        return Image(layers: layers, dimension: target)
    }
}



extension ImageReader where Transformer == CharacterToIntValueTransformer {
    convenience init(target: Dimension = Dimension.PasswordImage) {
        self.init(transformer: CharacterToIntValueTransformer(), target:target)
    }
}
extension ImageReader where Transformer == CharacterToColorValueTransformer {
    convenience init(target: Dimension = Dimension.PasswordImage) {
        self.init(transformer: CharacterToColorValueTransformer(), target:target)
    }
}
typealias DefaultImageReader = ImageReader<CharacterToIntValueTransformer>
typealias ColorImageReader = ImageReader<CharacterToColorValueTransformer>



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
    func layerWithFewestZeroes() -> Layer<T>? {
        self.layers.min { a, b in a.numberOfZeroes() < b.numberOfZeroes() }
    }
}

extension Image where T: Numeric {
    func checksum() -> Int {
        var checksum = 0
        if let layer = self.layerWithFewestZeroes() {
            checksum = layer.numberOfOnes() * layer.numberOfTwos()
        }
        return checksum
    }
}

enum Color: Int  {
    case black = 0
    case white = 1
    case transparent = 2
}
extension Color : CustomStringConvertible {
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

extension Image where T == Color {
    func render() -> Image<Color> {
        var renderedLayer = Layer<Color>()
        let imageSize = self.layers.first!.count // Assume all layers are equal and there is at least one layer
        for index in 0..<imageSize {
            var finalColor = Color.transparent
            self.layers.forEach { sublayer in
                if finalColor == .transparent {
                    finalColor = sublayer[index]
                }
            }
            renderedLayer.append(finalColor)
        }
        return Image(layers: [renderedLayer], dimension:dimension)
    }
    
    func print() {
        self.layers.first!.print(with: dimension)
    }
}

extension Layer where Element == Color {
    func print(with dimension:Dimension) {
        for y in 0..<dimension.height {
            for x in 0..<dimension.width {
                let index = y * dimension.width + x
                let color = self[index]
                Swift.print(color, separator: "", terminator: "")
            }
            Swift.print()
        }
    }
}

class Day8: NSObject {
    
    func checksumOfPasswordImage() -> Int {
        let image = DefaultImageReader().read(input())
        return image.checksum()
    }
    
    func printPasswordImage() {
        let image = ColorImageReader().read(input())
        image.render().print()
    }
    
    func input() -> String {
        try! String(contentsOfFile: "./Day8.txt").trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
