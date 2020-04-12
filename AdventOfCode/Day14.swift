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
    func weight(from source: Vertex) -> Int?
}

public class Graph<Vertex: Hashable>: Graphable, Weightable {
    public var edges: [Vertex: Set<Edge<Vertex>>] = [:]
    public var weights: [Vertex: Int] = [:]

    public func addEdge(from source: Vertex, to destination: Vertex, weight: Int) {
        let edge = Edge(source: source, destination: destination, weight: weight)
        if edges[source] == nil {
            edges[source] = [edge]
        } else {
            edges[source]?.insert(edge)
        }
    }

    public func edges(from source: Vertex) -> Set<Edge<Vertex>> {
        return edges[source] ?? []
    }

    public func add(vertex: Vertex, weight: Int) {
        weights[vertex] = weight
    }

    public func weight(from source: Vertex) -> Int? {
        return weights[source]
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
    func computeTotalCost(for graph: Graph<Vertex>, from source: Vertex) -> Int
}

public class RecursiveGraphWeightCalculator<Vertex: Hashable>: GraphWeightCalculator {

    func computeTotalCost(for graph: Graph<Vertex>, from vertex: Vertex, amountWanted: Int) -> Int {
        if let weight = graph.weight(from: vertex) {
            let amountNeeded = amountWanted / weight + min(amountWanted % weight, 1)
            return graph.edges(from: vertex).reduce(0) { $0 + computeTotalCost(for: graph, from: $1.destination, amountWanted: amountNeeded * $1.weight) }
        } else {
            return amountWanted // vertex is the final node (no edges from it, cost is constant)
        }
    }

    public func computeTotalCost(for graph: Graph<Vertex>, from vertex: Vertex) -> Int {
        let initalAmountWanted = graph.weight(from: vertex)!
        return computeTotalCost(for: graph, from: vertex, amountWanted: initalAmountWanted)
    }

}

class Day14: Day {

}
