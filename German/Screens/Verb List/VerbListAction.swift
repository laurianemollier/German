//
//  VerbListAction.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import Foundation

enum VerbListAction {
    case searchBar(SearchBarAction)
    
    case verbDetail(VerbDetailAction)
    case setLearningVerbDetail(selection: LearningVerb?)

    // if not defined, load all the verbs
    case loadState
    case setState([LearningVerb])
    case loadStateFailure(Error)
    
    case selecteLevel(Level?)
    case selecteForm(Form?)
}
