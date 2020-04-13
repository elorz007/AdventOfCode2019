//
//  Day14.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 12.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import Cocoa

public struct Edge<T: Hashable>: Hashable {
    public let source: T
    public let destination: T
    public let weight: Int
}

public protocol Graphable {
    associatedtype Vertex: Hashable
    func addEdge(from source: Vertex, to destination: Vertex, weight: Int)
    func edges(from source: Vertex) -> Set<Edge<Vertex>>
}

public protocol Weightable {
    associatedtype Vertex: Hashable
    func set(weight: Int, of vertex: Vertex)
    func weight(of vertex: Vertex) -> Int?
}

public protocol Degreeable: Graphable {
    func degree(of vertex: Vertex) -> Int
}

public class Graph<Vertex: Hashable>: Graphable, Weightable, Degreeable {
    public var edges: [Vertex: Set<Edge<Vertex>>] = [:]
    public var weights: [Vertex: Int] = [:]
    public var degrees: [Vertex: Int] = [:]

    public func addEdge(from source: Vertex, to destination: Vertex, weight: Int) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        if edges[source] == nil {
            edges[source] = [edge]
        } else {
            edges[source]?.insert(edge)
        }

        if degrees[destination] == nil {
            degrees[destination] = 1
        } else {
            degrees[destination]! += 1
        }
    }

    public func edges(from source: Vertex) -> Set<Edge<Vertex>> {
        return edges[source] ?? []
    }

    public func set(weight: Int, of vertex: Vertex) {
        weights[vertex] = weight
    }

    public func weight(of vertex: Vertex) -> Int? {
        return weights[vertex]
    }

    public func degree(of vertex: Vertex) -> Int {
        return degrees[vertex] ?? 0
    }
}

public class ReactionsReader {
    public func createGraph(from input: String) -> Graph<String> {
        let graph = Graph<String>()
        input.components(separatedBy: .newlines).forEach { line in
            let reactionParts = line.components(separatedBy: "=>")

            let resultPart = reactionParts.last!
            let (resultAmount, resultName) = separate(resultPart)
            graph.set(weight: resultAmount, of: resultName)

            let ingredientsPart = reactionParts.first!
            ingredientsPart.components(separatedBy: ",").forEach { ingredient in
                let (ingredientAmount, ingredientName) = separate(ingredient)
                graph.addEdge(from: resultName, to: ingredientName, weight: ingredientAmount)
            }
        }
        return graph
    }

    func separate(_ input: String) -> (amount: Int, name: String) {
        let separator = NSCharacterSet.whitespaces
        let parts = input.trimmingCharacters(in: separator).components(separatedBy: separator)
        let amount = Int(parts.first!)!
        let name = parts.last!
        return (amount, name)
    }
}

public class RecursiveGraphWeightCalculator<Vertex: Hashable> {
    var amounts: [Vertex: Int] = [:]
    var visited: [Vertex: Int] = [:]

    func visit(vertex: Vertex) {
        visited[vertex] = (visited[vertex] ?? 0) + 1
    }

    func isFullyVisited(vertex: Vertex, in graph: Graph<Vertex>) -> Bool {
        visited[vertex]! >= graph.degree(of: vertex)
    }

    func computeAmounts(for graph: Graph<Vertex>, from vertex: Vertex) {
        let edges = graph.edges(from: vertex)
        if edges.isEmpty { return } // source node (ORE)

        visit(vertex: vertex)
        guard isFullyVisited(vertex: vertex, in: graph) else { return }

        let weight = graph.weight(of: vertex)!
        let amountWanted = amounts[vertex]!
        let amountNeeded = amountWanted / weight + min(amountWanted % weight, 1)

        for edge in edges {
            amounts[edge.destination] = (amounts[edge.destination] ?? 0) + edge.weight * amountNeeded
            computeAmounts(for: graph, from: edge.destination)
        }
    }

    public func totalCost(for graph: Graph<Vertex>, of vertex: Vertex, source: Vertex, wanted amount: Int) -> Int {
        amounts[vertex] = amount
        computeAmounts(for: graph, from: vertex)
        return amounts[source]!
    }
}

public class MaxFuelCalculator {

    public func costOfFuel(for graph: Graph<String>, amount: Int = 1) -> Int {
        let calculator = RecursiveGraphWeightCalculator<String>()
        return calculator.totalCost(for: graph, of: "FUEL", source: "ORE", wanted: amount)
    }

    func middlePoint(min: Int, max: Int) -> Int {
        min + (max - min) / 2
    }

    public func maxFuel(for reactions: String, with maxCost: Int) -> Int {
        let graph = ReactionsReader().createGraph(from: reactions)
        var fuel = 1
        let costForOne = costOfFuel(for: graph, amount: fuel)

        // The function of f(fuel) -> cost is monotonically increasing
        // which means a fast way of finding the first point where f(x) > maxCost
        // can be done by choosing an upper and lower bound (fuelEstimateMin and fuelEstimateMax)
        // which we know are true in the beginning and then try a middle point
        // if the cost for that middle point is higher then we know a new maximum which is way closer
        // if the cost for that middle point is lower then we know a new minimu which is way closer
        // we repeat this until our middle point is exactly the minimum
        // (meaning that even one more to the middle point would go over)

        var fuelEstimateMin = maxCost / costForOne
        var fuelEstimateMax = fuelEstimateMin * 2
        fuel = middlePoint(min: fuelEstimateMin, max: fuelEstimateMax)

        while fuel != fuelEstimateMin {
            let cost = costOfFuel(for: graph, amount: fuel)

            if cost < maxCost {
                fuelEstimateMin = fuel
            } else {
                fuelEstimateMax = fuel
            }
            fuel = middlePoint(min: fuelEstimateMin, max: fuelEstimateMax)
        }
        return fuel
    }
}

public class Day14: Day {
    public func costForOneFuel() -> Int {
        let graph = ReactionsReader().createGraph(from: input())
        let calculator = MaxFuelCalculator()
        return calculator.costOfFuel(for: graph)
    }
}
