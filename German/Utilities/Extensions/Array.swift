//
//  Array.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 20/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


// TODO: to delete
extension Array {
    
    /// Returns an array containing this sequence shuffled
    var shuffled: Array {
        var elements = self
        return elements.shuffle()
    }
    
    /// Shuffles this sequence in place
    @discardableResult
    mutating func shuffle() -> Array {
        let count = self.count
        indices.lazy.dropLast().forEach {
            swapAt($0, Int(arc4random_uniform(UInt32(count - $0))) + $0)
        }
        return self
    }
    
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
    
    func choose(_ n: Int) -> Array { return Array(shuffled.prefix(n)) }
}
