//
//  Day6.swift
//  AdventOfCode
//
//  Created by Mikel Elorz on 09.12.19.
//  Copyright © 2019 Mikel Elorz. All rights reserved.
//

import Cocoa

class Node<T> {
    var value:T
    var children: [Node] = []
    var depth: UInt = 0
    weak var nextSibling: Node?
    weak var parent: Node?
    init(_ value:T) {
        self.value = value
    }
    func add(child: Node) {
        child.parent = self
        child.depth = self.depth + 1
        if let lastChild = children.last {
            lastChild.nextSibling = child
        }
        children.append(child)
    }
}

typealias Tree<T> = Node<T>

extension Node {
    func totalDepth() -> UInt {
        self.reduce(0) { $0 + $1.depth}
    }
}

extension Node where T: Equatable {
    
    func shortestPathLength(_ node1: Node,_ node2: Node) -> UInt {
        var result = UInt.max
        if let commonAncestor = commonAncestor(node1, node2) {
            let node1Depth = node1.depth
            let node2Depth = node2.depth
            let commonAncestorDepth = commonAncestor.depth
            let node1ToAncestor = node1Depth - commonAncestorDepth - 1
            let node2ToAncestor = node2Depth - commonAncestorDepth - 1
            result = node1ToAncestor + node2ToAncestor
        }
        return result
    }
    
    func commonAncestor(_ node1: Node,_ node2: Node) -> Node? {
        let stripped1 = node1.strippedTree()
        let stripped2 = node2.strippedTree()
        var currentNode1: Node? = stripped1
        var currentNode2: Node? = stripped2
        var commonAncestor: Node? = nil
        while let node1 = currentNode1, let node2 = currentNode2, node1.value == node2.value {
            commonAncestor = node1
            currentNode1 = node1.children.first
            currentNode2 = node2.children.first
        }
        return commonAncestor
    }
    
    func strippedTree() -> Node {
        var strippedCurrentNode = Node(self.value)
        var currentNode: Node? = self.parent
        while let node = currentNode {
            let newNode = Node(node.value)
            newNode.depth = node.depth
            newNode.add(child: strippedCurrentNode)
            strippedCurrentNode = newNode
            currentNode = node.parent
        }
        return strippedCurrentNode
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        var text = "\(value)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "}"
        }
        return text
    }
}

extension Node: Sequence {
    typealias Element = Node
    typealias Iterator = TreeDepthIterator<T>
    func makeIterator() -> Iterator {
        return TreeDepthIterator(self)
    }
}

struct TreeDepthIterator<T>: IteratorProtocol {
    typealias Element = Node<T>

    var node: Node<T>?
    init(_ node: Node<T>) {
        self.node = node
    }
    
    mutating func next() -> Element? {
        let result = self.node
        if let node = self.node {
            if !node.children.isEmpty {
                self.node = node.children.first
            } else {
                var findNext = node
                while findNext.nextSibling == nil , findNext.parent != nil {
                    findNext = findNext.parent!
                }
                self.node = findNext.nextSibling
            }
        }
        return result
    }
}


class Day6: NSObject {
    func input() -> String {
        try! String(contentsOfFile: "./Day6.txt")
    }
    
    func split(_ input: String) -> [String] {
        input.split { $0.isNewline }.map { String($0) }
    }
    
    
    func buildTree(_ input: String) -> Tree<String> {
        let tree = Node("COM")
        var lines = split(input)
        while lines.count > 0 {
            for (index, line) in lines.enumerated().reversed() { // Reversed is mandatory or else the index that are deleted won't be valid
                let nodeValues = line.split(separator: ")").map { String($0) }
                let leftNodeValue = nodeValues[0]
                let rightNodeValue = nodeValues[1]
                
                if let foundNode = tree.first(where: { leftNodeValue == $0.value }) {
                    foundNode.add(child: Node(rightNodeValue))
                    lines.remove(at: index)
                }
            }
        }
        return tree
    }
    
    func totalOrbits() -> UInt {
        return buildTree(input()).totalDepth()
    }
    
    func minimumOrbitalTransfers() -> UInt {
        let tree = buildTree(input())
        let you = tree.first{ $0.value == "YOU" }!
        let san = tree.first{ $0.value == "SAN" }!
        return tree.shortestPathLength(you, san)
    }
}
