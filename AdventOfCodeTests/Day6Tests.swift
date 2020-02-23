//
//  Day6Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 09.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import XCTest

class Day6Tests: XCTestCase {

    func testNodesCanBeAdded() {
        let tree = sampleTree()
        XCTAssertEqual(tree.children[2].children[3].children[0].value, "WRC")
    }

    func testTressCanBePrinted() {
        let tree = sampleTree()
        XCTAssertEqual("\(tree)", "Ford {Mustang {GT}, Mondeo, Focus {EcoBoost, EcoBlue, ST, RS {WRC}}}")
    }

    func testNodesCanBeIteratedByDefaultDepthFirst() {
        let tree = sampleTree()
        var all: [String] = []
        tree.forEach { all.append($0.value) }
        XCTAssertEqual(all, ["Ford", "Mustang", "GT", "Mondeo", "Focus", "EcoBoost", "EcoBlue", "ST", "RS", "WRC"])
    }

    func testTreeDepthIsSameForAllChildren() {
        let tree = sampleTree()
        tree.children.forEach { XCTAssertEqual($0.depth, 1) }
    }

    func testTreeDepthIsCalculated() {
        let tree = sampleTree()
        let wrc = tree.first { $0.value == "WRC" }!
        XCTAssertEqual(wrc.depth, 3)
    }

    func testTreeDepthIs0ForRoot() {
        let tree = sampleTree()
        XCTAssertEqual(tree.depth, 0)
    }

    func testTotalTreeDepthCanBeCalculated() {
        let tree = sampleTree()
        XCTAssertEqual(tree.totalDepth(), 16)

    }

    func testTotalTreeDepthCanBeCalculatedForExample() {
        let tree = adventOfCodeExample()
        XCTAssertEqual(tree.totalDepth(), 42)
    }

    // MARK: -
    func testExampleInputCanBeRead() {
        let d6 = Day6()
        let tree = d6.buildTree("COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L")
        XCTAssertEqual(tree.totalDepth(), 42)
    }

    func testSingleLineInputCanBeReadWhenComIsNotFirst() {
        let d6 = Day6()
        let tree = d6.buildTree("C)D\nCOM)B\nB)C\nD)E")
        XCTAssertEqual(tree.children.first?.children.first?.children.first?.children.first?.value, "E")
    }

    func test_SLOW_TotalOrbits() {
        let d6 = Day6()
        XCTAssertEqual(d6.totalOrbits(), 106065)
    }

    // MARK: - Orbital transfer
    func testStrippedTreeFindsDirectPathToRoot() {
        let tree = ancestorExample()
        let you = tree.first { $0.value == "YOU" }
        let stripped = you!.strippedTree()
        var all: [String] = []
        stripped.forEach { all.append($0.value) }
        XCTAssertEqual(all, ["COM", "B", "C", "D", "E", "J", "K", "YOU"])
    }

    func testStrippedTreeKeepsDepthProperly() {
        let tree = ancestorExample()
        let you = tree.first { $0.value == "YOU" }
        let stripped = you!.strippedTree()
        let youStripped = stripped.first { $0.value == "YOU" }!
        XCTAssertEqual(youStripped.depth, 7)
    }

    func testCommonAncestorCanBeFound() {
        let tree = ancestorExample()
        let you = tree.first { $0.value == "YOU" }!
        let san = tree.first { $0.value == "SAN" }!
        let ancestor = tree.commonAncestor(you, san)!
        XCTAssertEqual(ancestor.value, "D")
    }

    func testShortestPathInExample() {
        let tree = ancestorExample()
        let you = tree.first { $0.value == "YOU" }!
        let san = tree.first { $0.value == "SAN" }!
        let shortestPath = tree.shortestPathLength(you, san)
        XCTAssertEqual(shortestPath, 4)
    }

    func test_SLOW_MinimumOrbitalTransfers() {
        let d6 = Day6()
        XCTAssertEqual(d6.minimumOrbitalTransfers(), 253)
    }

    func sampleTree() -> Tree<String> {
        let ford = Tree<String>("Ford")
        let mustang = Node("Mustang")
        ford.add(child: mustang)
        mustang.add(child: Node("GT"))
        ford.add(child: Node("Mondeo"))
        let focus = Node("Focus")
        ford.add(child: focus)
        focus.add(child: Node("EcoBoost"))
        focus.add(child: Node("EcoBlue"))
        focus.add(child: Node("ST"))
        let rs = Node("RS")
        focus.add(child: rs)
        rs.add(child: Node("WRC"))
        return ford
    }

    func adventOfCodeExample() -> Tree<String> {
        let com = Tree<String>("COM")
        let b = Node("B")
        let c = Node("C")
        let d = Node("D")
        let e = Node("E")
        let f = Node("F")
        let g = Node("G")
        let h = Node("H")
        let i = Node("I")
        let j = Node("J")
        let k = Node("K")
        let l = Node("L")
        com.add(child: b)
        b.add(child: g)
        b.add(child: c)
        g.add(child: h)
        c.add(child: d)
        d.add(child: i)
        d.add(child: e)
        e.add(child: j)
        e.add(child: f)
        j.add(child: k)
        k.add(child: l)
        return com
    }

    func ancestorExample() -> Node<String> {
        return Day6().buildTree("COM)B\nB)C\nC)D\nD)E\nE)F\nB)G\nG)H\nD)I\nE)J\nJ)K\nK)L\nK)YOU\nI)SAN")
    }
}
