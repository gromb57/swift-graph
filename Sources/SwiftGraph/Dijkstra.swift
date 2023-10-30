//
//  Dijkstra.swift
//
//
//  Created by Jerome Bach on 29/10/2023.
//

import Foundation

/// Données : d(x, y) : la longueur de l’arête (x, y)
/// Résultat : pcd[x] : la plus courte distance provisoire de x0 à x ∀x ∈ V
/// prec[x] : le sommet précédent x sur le plus court chemin de x0 à x
/// X : l’ensemble des sommets x ayant une valeur pour l[x] définitive
/// Y :lecomplémentairedeX dansV (V =X∪Y)
class Dijkstra {
    // MARK: - 1
    static func plusCourtChDijkstra(G: [[Int?]], x0: Int) {
        let infinity: Int? = nil
        
        // pour chaque sommet x de G ̸= x0 faire
        //  pcd[x] ← +∞
        //  prec[x] ← −1
        var pcd: [Int?] = Array(repeating: infinity, count: G.count)
        var prec: [Int] = Array(repeating: -1, count: G.count)
        
        pcd[x0] = 0
        var X = [x0]
        // Y = V \ {x0}
        var Y: [Int] = []
        
        let v: [Int] = [] // voisin de x0
        for y in v {
            pcd[y] = abs(x0 - y) // d(x0, y)
            prec[y] = x0
        }
        
        // tant que ∃y ∈ Y tel que pcd[y] < +∞ faire
        var y: Int = 0
        while pcd[y] != infinity {
            //prendre y ∈ Y tel que pcd[y] soit minimum
            //pour chaque z ∈ Y ∩ Γ(y) faire
            for z in Y {
                let dyz = abs(y - z) // d(y, z)
                if let pcdz = pcd[z], let pcdy = pcd[y], pcdz > pcdy + dyz {
                    pcd[z] = pcdy + dyz
                    prec[z] = y
                }
            }
            // X = X ∪ {y}
            // Y = Y \ {y}
        }
    }
    
    // MARK: - 2
    class Node {
      var visited = false
      var connections: [Connection] = []
    }
    
    class MyNode: Node {
      let name: String
      
      init(name: String) {
        self.name = name
        super.init()
      }
    }
    
    class Connection {
      public let to: Node
      public let weight: Int
      
      public init(to node: Node, weight: Int) {
        assert(weight >= 0, "weight has to be equal or greater than zero")
        self.to = node
        self.weight = weight
      }
    }
    
    class Path {
      public let cumulativeWeight: Int
      public let node: Node
      public let previousPath: Path?
      
      init(to node: Node, via connection: Connection? = nil, previousPath path: Path? = nil) {
        if
          let previousPath = path,
          let viaConnection = connection {
          self.cumulativeWeight = viaConnection.weight + previousPath.cumulativeWeight
        } else {
          self.cumulativeWeight = 0
        }
        
        self.node = node
        self.previousPath = path
      }
        
      //  extension Path {
      var array: [Node] {
        var array: [Node] = [self.node]
        
        var iterativePath = self
        while let path = iterativePath.previousPath {
          array.append(path.node)
          
          iterativePath = path
        }
        
        return array
      }
    }
    
    func shortestPath(source: Node, destination: Node) -> Path? {
      var frontier: [Path] = [] {
        didSet { frontier.sort { return $0.cumulativeWeight < $1.cumulativeWeight } } // the frontier has to be always ordered
      }
      
      frontier.append(Path(to: source)) // the frontier is made by a path that starts nowhere and ends in the source
      
      while !frontier.isEmpty {
        let cheapestPathInFrontier = frontier.removeFirst() // getting the cheapest path available
        guard !cheapestPathInFrontier.node.visited else { continue } // making sure we haven't visited the node already
        
        if cheapestPathInFrontier.node === destination {
          return cheapestPathInFrontier // found the cheapest path 😎
        }
        
        cheapestPathInFrontier.node.visited = true
        
        for connection in cheapestPathInFrontier.node.connections where !connection.to.visited { // adding new paths to our frontier
          frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
        }
      } // end while
      return nil // we didn't find a path 😣
    }
}
