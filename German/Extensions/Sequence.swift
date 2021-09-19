//
//  Sequence.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 27/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation



extension Sequence{
    
    func forAll(where predicate: @escaping (Element) throws -> Bool) rethrows -> Bool{
        var result = true
        for el in self {
            let r = try predicate(el)
            result = result && r
        }
        return result
    }
}
