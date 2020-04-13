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
        XCTAssertEqual(graph.weight(of: "X"), 4)
    }

    func testWhenReadingSimpleReactionThenGraphContainsEdgesFromResultToIngredient() {
        let graph = ReactionsReader().createGraph(from: "1 A => 4 X")
        let edges = graph.edges(from: "X")
        let expected = Set([Edge(source: "X", destination: "A", weight: 1)])
        XCTAssertEqual(edges, expected)
    }

    func testWhenReadingSimpleReactionThenGraphContainsDegreeForIngredient() {
        let graph = ReactionsReader().createGraph(from: "1 A => 4 X")
        XCTAssertEqual(graph.degree(of: "A"), 1)
    }

    func testWhenReadingSimpleReactionThenGraphContainsDegreeForResult() {
        let graph = ReactionsReader().createGraph(from: "1 A => 4 X")
        XCTAssertEqual(graph.degree(of: "X"), 0)
    }

    func testWhenReadingComplexReactionThenGraphContainsAllEdgesFromResultToIngredients() {
        let graph = ReactionsReader().createGraph(from: "1 A, 9 B => 4 X")
        let edgesX = graph.edges(from: "X")
        let expectedX = Set([Edge(source: "X", destination: "A", weight: 1),
                             Edge(source: "X", destination: "B", weight: 9)])
        XCTAssertEqual(edgesX, expectedX)
    }

    func testWhenReadingComplexReactionThenGraphContainsDegreesForIngredients() {
        let graph = ReactionsReader().createGraph(from: "1 A, 9 B => 4 X")
        XCTAssertEqual(graph.degree(of: "A"), 1)
        XCTAssertEqual(graph.degree(of: "B"), 1)
    }

    func testWhenReadingMultipleReactionsThenGraphContainsAllEdges() {
        let graph = multipleReactionsGraph()
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
        let graph = multipleReactionsGraph()
        XCTAssertNil(graph.weight(of: "ORE"))
        XCTAssertEqual(graph.weight(of: "A"), 10)
        XCTAssertEqual(graph.weight(of: "B"), 1)
        XCTAssertEqual(graph.weight(of: "C"), 2)
        XCTAssertEqual(graph.weight(of: "D"), 3)
        XCTAssertEqual(graph.weight(of: "E"), 4)
        XCTAssertEqual(graph.weight(of: "FUEL"), 1)
    }

    func testWhenReadingMultipleReactionsThenGraphContainsAllDegrees() {
        let graph = multipleReactionsGraph()
        XCTAssertEqual(graph.degree(of: "ORE"), 2)
        XCTAssertEqual(graph.degree(of: "A"), 4)
        XCTAssertEqual(graph.degree(of: "B"), 1)
        XCTAssertEqual(graph.degree(of: "C"), 1)
        XCTAssertEqual(graph.degree(of: "D"), 1)
        XCTAssertEqual(graph.degree(of: "E"), 1)
        XCTAssertEqual(graph.degree(of: "FUEL"), 0)
    }

    func multipleReactionsGraph() -> Graph<String> {
        let input = """
                    10 ORE => 10 A
                    1 ORE => 1 B
                    7 A, 1 B => 2 C
                    7 A, 1 C => 3 D
                    7 A, 1 D => 4 E
                    7 A, 1 E => 1 FUEL
                    """
        return ReactionsReader().createGraph(from: input)
    }

    // test degrees

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

    func testWhenMoreFuelIsWantedThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 1 FUEL
                        """
        assert(reactions: reactions, cost: 2, wanted: 2)
    }

    func testWhenMoreFuelIsProducedThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 2 FUEL
                        """
        assert(reactions: reactions, cost: 1, wanted: 2)
    }

    func testWhenInexactAmountOfFuelIsWantedThenCostIsCorrect() {
        let reactions = """
                        1 ORE => 2 FUEL
                        """
        assert(reactions: reactions, cost: 2, wanted: 3)
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

    func testWhenExample1IsGivenThenCostIsCorrect() {
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

    func testWhenExample2IsGivenThenCostIsCorrect() {
        let reactions = """
                        9 ORE => 2 A
                        8 ORE => 3 B
                        7 ORE => 5 C
                        3 A, 4 B => 1 AB
                        5 B, 7 C => 1 BC
                        4 C, 1 A => 1 CA
                        2 AB, 3 BC, 4 CA => 1 FUEL
                        """
        assert(reactions: reactions, cost: 165)
    }

    func testWhenExample3IsGivenThenCostIsCorrect() {
        let reactions = """
                        157 ORE => 5 NZVS
                        165 ORE => 6 DCFZ
                        44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
                        12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
                        179 ORE => 7 PSHF
                        177 ORE => 5 HKGWZ
                        7 DCFZ, 7 PSHF => 2 XJWVT
                        165 ORE => 2 GPVTF
                        3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
                        """
        assert(reactions: reactions, cost: 13312)
    }

    func testWhenExample4IsGivenThenCostIsCorrect() {
        let reactions = """
                        2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
                        17 NVRVD, 3 JNWZP => 8 VPVL
                        53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
                        22 VJHF, 37 MNCFX => 5 FWMGM
                        139 ORE => 4 NVRVD
                        144 ORE => 7 JNWZP
                        5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
                        5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
                        145 ORE => 6 MNCFX
                        1 NVRVD => 8 CXFTF
                        1 VJHF, 6 MNCFX => 4 RFSQX
                        176 ORE => 6 VJHF
                        """
        assert(reactions: reactions, cost: 180697)
    }

    func testWhenExample5IsGivenThenCostIsCorrect() {
        let reactions = """
                        171 ORE => 8 CNZTR
                        7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
                        114 ORE => 4 BHXH
                        14 VRPVC => 6 BMBT
                        6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
                        6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
                        15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
                        13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
                        5 BMBT => 4 WPTQ
                        189 ORE => 9 KTJDG
                        1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
                        12 VRPVC, 27 CNZTR => 2 XDBXC
                        15 KTJDG, 12 BHXH => 5 XCVML
                        3 BHXH, 2 VRPVC => 7 MZWV
                        121 ORE => 7 VRPVC
                        7 XCVML => 6 RJRHP
                        5 BHXH, 4 VRPVC => 5 LTCX
                        """
        assert(reactions: reactions, cost: 2210736)
    }

    func assert(reactions input: String, cost: Int, wanted: Int = 1) {
        let graph = ReactionsReader().createGraph(from: input)
        let calculator = MaxFuelCalculator()
        let result = calculator.costOfFuel(for: graph, amount: wanted)
        XCTAssertEqual(result, cost)
    }

    func testDay14Part1() {
        XCTAssertEqual(Day14().costForOneFuel(), 899155)
    }

    // MARK: -
    func testWhenExample1IsGivenWithLimitOreThenMaxAmountOfFuelIsFound() {
        let reactions = """
                        10 ORE => 10 A
                        1 ORE => 1 B
                        7 A, 1 B => 1 C
                        7 A, 1 C => 1 D
                        7 A, 1 D => 1 E
                        7 A, 1 E => 1 FUEL
                        """
        assert(reactions: reactions, withMaximumCost: 62, produces: 2)
    }

    func testWhenExample3IsGivenThenMaxFuelIsCorrect() {
        let reactions = """
                        157 ORE => 5 NZVS
                        165 ORE => 6 DCFZ
                        44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL
                        12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ
                        179 ORE => 7 PSHF
                        177 ORE => 5 HKGWZ
                        7 DCFZ, 7 PSHF => 2 XJWVT
                        165 ORE => 2 GPVTF
                        3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT
                        """
        assert(reactions: reactions, produces: 82892753)
    }

    func testWhenExample4IsGivenThenMaxFuelIsCorrect() {
        let reactions = """
                        2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG
                        17 NVRVD, 3 JNWZP => 8 VPVL
                        53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL
                        22 VJHF, 37 MNCFX => 5 FWMGM
                        139 ORE => 4 NVRVD
                        144 ORE => 7 JNWZP
                        5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC
                        5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV
                        145 ORE => 6 MNCFX
                        1 NVRVD => 8 CXFTF
                        1 VJHF, 6 MNCFX => 4 RFSQX
                        176 ORE => 6 VJHF
                        """
        assert(reactions: reactions, produces: 5586022)
    }

    func testWhenExample5IsGivenThenMaxFuelIsCorrect() {
        let reactions = """
                        171 ORE => 8 CNZTR
                        7 ZLQW, 3 BMBT, 9 XCVML, 26 XMNCP, 1 WPTQ, 2 MZWV, 1 RJRHP => 4 PLWSL
                        114 ORE => 4 BHXH
                        14 VRPVC => 6 BMBT
                        6 BHXH, 18 KTJDG, 12 WPTQ, 7 PLWSL, 31 FHTLT, 37 ZDVW => 1 FUEL
                        6 WPTQ, 2 BMBT, 8 ZLQW, 18 KTJDG, 1 XMNCP, 6 MZWV, 1 RJRHP => 6 FHTLT
                        15 XDBXC, 2 LTCX, 1 VRPVC => 6 ZLQW
                        13 WPTQ, 10 LTCX, 3 RJRHP, 14 XMNCP, 2 MZWV, 1 ZLQW => 1 ZDVW
                        5 BMBT => 4 WPTQ
                        189 ORE => 9 KTJDG
                        1 MZWV, 17 XDBXC, 3 XCVML => 2 XMNCP
                        12 VRPVC, 27 CNZTR => 2 XDBXC
                        15 KTJDG, 12 BHXH => 5 XCVML
                        3 BHXH, 2 VRPVC => 7 MZWV
                        121 ORE => 7 VRPVC
                        7 XCVML => 6 RJRHP
                        5 BHXH, 4 VRPVC => 5 LTCX
                        """
        assert(reactions: reactions, produces: 460664)
    }

    func assert(reactions input: String, withMaximumCost cost: Int = 1000000000000, produces fuel: Int) {
        let graph = ReactionsReader().createGraph(from: input)
        let calculator = MaxFuelCalculator()
        let result = calculator.maxFuel(for: graph, with: cost)
        XCTAssertEqual(result, fuel)
    }

    func testDay14Part2() {
        XCTAssertEqual(Day14().maxFuel(), 2390226)
    }

}
