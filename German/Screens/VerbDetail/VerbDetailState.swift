//
//  VerbDetailState.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

struct VerbDetailState: Equatable {
    var isLoading: Bool = false
    var alertItem: AlertItem?
    var learningVerb: LearningVerb
}
