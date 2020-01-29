//
//  Day8Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 29.01.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day8Tests: XCTestCase {


    func testWhenOneLayerIsGivenThenItCanBeRead() {
        let imageReader = DefaultImageReader(target: Dimension(width: 3, height: 2))
        let image = imageReader.read("123456");
        XCTAssertEqual(image.layers.count, 1)
    }

    func testWhenOneLayerIsGivenThenContentsArePresent() {
        let imageReader = DefaultImageReader(target: Dimension(width: 3, height: 2))
        let image = imageReader.read("123456");
        XCTAssertEqual(image.layers[0], [1,2,3,4,5,6])
    }

    func testWhenMoreLayerAreGivenThenTheyCanBeRead() {
        let imageReader = DefaultImageReader(target: Dimension(width: 3, height: 2))
        let image = imageReader.read("123456123456123456");
        XCTAssertEqual(image.layers.count, 3)
    }

    func testWhenMoreLayerAreGivenThenContentsArePresent() {
        let imageReader = DefaultImageReader(target: Dimension(width: 3, height: 2))
        let image = imageReader.read("123456111111222222");
        XCTAssertEqual(image.layers[0], [1,2,3,4,5,6])
        XCTAssertEqual(image.layers[1], [1,1,1,1,1,1])
        XCTAssertEqual(image.layers[2], [2,2,2,2,2,2])
    }
    
    func testWhenDimensionsAreDifferentSameContentIsRead() {
        let imageReader = DefaultImageReader(target: Dimension(width: 1, height: 6))
        let image = imageReader.read("123456111111222222");
        XCTAssertEqual(image.layers[0], [1,2,3,4,5,6])
        XCTAssertEqual(image.layers[1], [1,1,1,1,1,1])
        XCTAssertEqual(image.layers[2], [2,2,2,2,2,2])
    }
    
    // MARK: -

    func testWhenNumberOfZeroesIsZeroThenZeroIsReturned() {
        let layer = Layer([1,2,3,4])
        XCTAssertEqual(layer.numberOfZeroes(), 0)
    }
    
    func testWhenZeroesArePresentThenTheyAreCounted() {
        let layer = Layer([0,1,2,0,0,0,3,4,0])
        XCTAssertEqual(layer.numberOfZeroes(), 5)
    }
    
    func testWhenNumberOfOnesIsZeroThenZeroIsReturned() {
        let layer = Layer([0,2,3,4])
        XCTAssertEqual(layer.numberOfOnes(), 0)
    }

    func testWhenOnesArePresentThenTheyAreCounted() {
        let layer = Layer([1,1,2,0,0,1,3,4,1])
        XCTAssertEqual(layer.numberOfOnes(), 4)
    }
    
    func testWhenNumberOfTwosIsZeroThenZeroIsReturned() {
        let layer = Layer([0,1,3,4])
        XCTAssertEqual(layer.numberOfTwos(), 0)
    }
    
    func testWhenTwosArePresentThenTheyAreCounted() {
        let layer = Layer([2,2,2,0,0,1,2,2,2])
        XCTAssertEqual(layer.numberOfTwos(), 6)
    }
    
    // MARK: -
    func testWhenImageHasLayersThenOneWithMostZeroesCanBeFound() {
        let image = Image(layers: [
            [1,2,0,4],
            [1,0,0,4],
            [1,2,3,5],
            [1,2,0,4],
        ])
        XCTAssertEqual(image.layerWithFewestZeroes(), [1,2,3,5])
    }
    
    func testWhenTwoLayersHaveTheSameNumberThenFirstOneIsReturned() {
        let image = Image(layers: [
            [1,2,3,4],
            [1,0,0,4],
            [1,2,3,5],
            [5,0,0,6],
        ])
        XCTAssertEqual(image.layerWithFewestZeroes(), [1,2,3,4])
    }
    
    func testWhenImageHasNoLayersThenNilIsReturned() {
        let image:Image<Int> = Image(layers: [])
        XCTAssertNil(image.layerWithFewestZeroes())
    }
    
    // MARK: -
    func testCheckSumIsCalculated() {
        let image = Image(layers: [
            [1,3,3,4,0],
            [1,2,3,2,1],
            [3,3,3,4,0],
            [2,1,2,0,0],
        ])
        XCTAssertEqual(image.checksum(), 4)
    }
    
    // MARK: -
    func testChecksumOfPasswordImage() {
        let d8 = Day8()
        XCTAssertEqual(d8.checksumOfPasswordImage(), 1452)
    }
}
