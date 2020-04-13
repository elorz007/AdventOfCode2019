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
    func add(vertex: Vertex, weight: Int)
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

    public func add(vertex: Vertex, weight: Int) {
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
            graph.add(vertex: resultName, weight: resultAmount)

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

protocol GraphWeightCalculator {
    associatedtype Vertex: Hashable
    func computeTotalCost(for graph: Graph<Vertex>, of vertex: Vertex, source: Vertex) -> Int
}

public class RecursiveGraphWeightCalculator<Vertex: Hashable>: GraphWeightCalculator {
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

    public func computeTotalCost(for graph: Graph<Vertex>, of vertex: Vertex, source: Vertex) -> Int {
        amounts[vertex] = graph.weight(of: vertex)!
        computeAmounts(for: graph, from: vertex)
        return amounts[source]!
    }

}

public class Day14: Day {
    public func costForOneFuel() -> Int {
        let graph = ReactionsReader().createGraph(from: input())
        let calculator = RecursiveGraphWeightCalculator<String>()
        return calculator.computeTotalCost(for: graph, of: "FUEL", source: "ORE")
    }
}
