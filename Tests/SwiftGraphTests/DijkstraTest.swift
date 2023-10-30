//
//  DijkstraTest.swift
//  
//
//  Created by Jerome Bach on 30/10/2023.
//

import Foundation

import XCTest
@testable import SwiftGraph

final class DijkstraTest: XCTestCase {
    typealias MyNode = Dijkstra.MyNode
    typealias Connection = Dijkstra.Connection

    func testExample() throws {
        let nodeA = MyNode(name: "A")
        let nodeB = MyNode(name: "B")
        let nodeC = MyNode(name: "C")
        let nodeD = MyNode(name: "D")
        let nodeE = MyNode(name: "E")

        nodeA.connections.append(Connection(to: nodeB, weight: 1))
        nodeB.connections.append(Connection(to: nodeC, weight: 3))
        nodeC.connections.append(Connection(to: nodeD, weight: 1))
        nodeB.connections.append(Connection(to: nodeE, weight: 1))
        nodeE.connections.append(Connection(to: nodeC, weight: 1))
        
        let sourceNode = nodeA
        let destinationNode = nodeD

        var path = Dijkstra().shortestPath(source: sourceNode, destination: destinationNode)

        if let succession: [String] = path?.array.reversed().flatMap({ $0 as? MyNode}).map({$0.name}) {
          print("🏁 Quickest path: \(succession)")
        } else {
          print("💥 No path between \(sourceNode.name) & \(destinationNode.name)")
        }
    }
}
