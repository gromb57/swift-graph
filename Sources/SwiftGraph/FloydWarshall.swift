//
//  FloydWarshall.swift
//
//
//  Created by Jerome Bach on 29/10/2023.
//

import Foundation

class FloydWarshall {
    /// Données : A : matrice d’adjacence du graphe G
    /// Résultat : PCC[x,y] : le sommet qui précède y dans le plus court
    /// chemin de x à y
    /// - Parameter G: matrix
    static func plusCourtChMatriciel(G: [[Int?]]) -> ([[Int?]], [[Int?]]) {
        let infinity: Int? = nil
        
        var A: [[Int?]] = G.map { row in
            return row.map { column in
                return column ?? nil
            }
        }
        var PCC: [[Int?]] = G.map { row in
            return row.map { column in
                return column ?? nil
            }
        }
        
        for z in 0..<G.count {
            for x in 0..<G.count {
                for y in 0..<G.count {
                    if let axz = A[x][z],
                       let azy = A[z][y],
                       let axy = A[x][y],
                        (axz != infinity)
                        && (azy != infinity)
                        && ((axz + azy) < axy) {
                        A[x][y] = axz + azy
                        PCC[x][y] = z
                    }
                }
            }
        }
        return (A, PCC)
    }
}
