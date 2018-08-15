//
//  UserProgression.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 14/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


enum UserProgression: String {
    
    case notSeenYet = "notSeenYet"
    case level1 = "level1"
    case level2 = "level2"
    case level3 = "level3"
    case level4 = "level4"
    case level5 = "level5"
    case level6 = "level6"
    case level7 = "level7"
    case level8 = "level8"
    case toIgnore = "toIgnore"
    
    static let allValues = [notSeenYet, level1, level2 , level3, level4, level5, level6, level7, level8, toIgnore]
}
