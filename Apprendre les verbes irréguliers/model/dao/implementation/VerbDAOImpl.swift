//
//  VerbDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

final class LocalVerbDAO: VerbDAO{
    
    private let db: Connection
    
    init(connection: Connection){
        self.db = connection
    }
    
    func find(id: Int64) throws -> Verb {
        guard let verbs = Verbs.verbs.first(where: {$0.id == id})
        else { throw CustomErrorType.VerbNotFound }
    
        return verbs
    }
}
