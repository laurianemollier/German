//
//  DAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

struct DAO {
    
    private let db: Connection
    
    init(connection: Connection){
        self.db = connection
    }
    
    static let shared = LocalLearningVerbDAO(connection: Database.shared.connection!)

}
