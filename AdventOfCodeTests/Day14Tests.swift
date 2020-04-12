//
//  Day14Tests.swift
//  AdventOfCodeTests
//
//  Created by Mikel Elorz on 12.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import XCTest

class Day14Tests: XCTestCase {

    func testWhenReadingSimpleReactionThenGraphContainsWeightForResult() {
        let graph = ReactionsReader().createGraph(from: "1 A => 4 X")
        XCTAssertEqual(graph.weight(from: "X"), 4)
    }

    func testWhenReadingSimpleReactionThenGraphContainsEdgesFromResultToIngredient() {
        let graph = ReactionsReader().createGraph(from: "1 A => 4 X")
        let edges = graph.edges(from: "X")
        let expected = Set([Edge(source: "X", destination: "A", weight: 1)])
        XCTAssertEqual(edges, expected)
    }

    func testWhenReadingComplexReactionThenGraphContainsAllEdgesFromResultToIngredients() {
        let graph = ReactionsReader().createGraph(from: "1 A, 9 B => 4 X")
        let edgesX = graph.edges(from: "X")
        let expectedX = Set([Edge(source: "X", destination: "A", weight: 1),
                             Edge(source: "X", destination: "B", weight: 9)])
        XCTAssertEqual(edgesX, expectedX)
    }

    func testWhenReadingMultipleReactionsThenGraphContainsAllEdges() {
        let input = """
                    10 ORE => 10 A
                    1 ORE => 1 B
                    7 A, 1 B => 1 C
                    7 A, 1 C => 1 D
                    7 A, 1 D => 1 E
                    7 A, 1 E => 1 FUEL
                    """
        let graph = ReactionsReader().createGraph(from: input)
        XCTAssertEqual(graph.edges(from: "ORE"), Set([]))
        XCTAssertEqual(graph.edges(from: "A"), Set([Edge(source: "A", destination: "ORE", weight: 10)]))
        XCTAssertEqual(graph.edges(from: "B"), Set([Edge(source: "B", destination: "ORE", weight: 1)]))
        XCTAssertEqual(graph.edges(from: "C"), Set([Edge(source: "C", destination: "A", weight: 7),
                                                    Edge(source: "C", destination: "B", weight: 1)]))
        XCTAssertEqual(graph.edges(from: "D"), Set([Edge(source: "D", destination: "A", weight: 7),
                                                    Edge(source: "D", destination: "C", weight: 1)]))
        XCTAssertEqual(graph.edges(from: "E"), Set([Edge(source: "E", destination: "A", weight: 7),
                                                    Edge(source: "E", destination: "D", weight: 1)]))
        XCTAssertEqual(graph.edges(from: "FUEL"), Set([Edge(source: "FUEL", destination: "A", weight: 7),
                                                       Edge(source: "FUEL", destination: "E", weight: 1)]))
    }

    func testWhenReadingMultipleReactionsThenGraphContainsAllWeights() {
        let input = """
                    10 ORE => 10 A
                    1 ORE => 1 B
                    7 A, 1 B => 2 C
                    7 A, 1 C => 3 D
                    7 A, 1 D => 4 E
                    7 A, 1 E => 1 FUEL
                    """
        let graph = ReactionsReader().createGraph(from: input)
        XCTAssertEqual(graph.weight(from: "A"), 10)
        XCTAssertEqual(graph.weight(from: "B"), 1)
        XCTAssertEqual(graph.weight(from: "C"), 2)
        XCTAssertEqual(graph.weight(from: "D"), 3)
        XCTAssertEqual(graph.weight(from: "E"), 4)
        XCTAssertEqual(graph.weight(from: "FUEL"), 1)
    }
    // MARK: -
    func testWhenTrivialReactionIsGivenThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 1 FUEL
                        """
        assert(reactions: reactions, cost: 1)
    }

    func testWhenTrivialReactionWithWeightsIsGivenThenCostIsCorrect() {
        let reactions = """
                        8 ORE => 1 FUEL
                        """
        assert(reactions: reactions, cost: 8)
    }

    func testWhenSinglePathIsGivenThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 1 A
                        1 A => 1 B
                        1 B => 1 FUEL
                        """
        assert(reactions: reactions, cost: 1)
    }

    func testWhenSinglePathHasExtraIngredientsThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 10 A
                        1 A => 1 B
                        1 B => 1 FUEL
                        """
        assert(reactions: reactions, cost: 1)
    }

    func testWhenMultiplePathsAreRequiredToCalculateThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 1 A
                        1 ORE => 1 B
                        1 A, 1 B => 1 C
                        1 B, 1 C => 1 FUEL
                        """
        assert(reactions: reactions, cost: 3)
    }

    func testWhenMultiplePathsWithExtraIngredientsAreRequiredToCalculateThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 1 A
                        1 ORE => 1 B
                        1 A, 1 B => 7 C
                        1 B, 1 C => 1 FUEL
                        """
        assert(reactions: reactions, cost: 3)
    }

    func testWhenExample1IsGivenThenCostIs31() {
        let reactions = """
                        10 ORE => 10 A
                        1 ORE => 1 B
                        7 A, 1 B => 1 C
                        7 A, 1 C => 1 D
                        7 A, 1 D => 1 E
                        7 A, 1 E => 1 FUEL
                        """
        assert(reactions: reactions, cost: 31)
    }

    func assert(reactions input: String, cost: Int) {
        let calculator = RecursiveGraphWeightCalculator<String>()
        let graph = ReactionsReader().createGraph(from: input)
        let result = calculator.computeTotalCost(for: graph, from: "FUEL")
        XCTAssertEqual(result, cost)
    }
}
