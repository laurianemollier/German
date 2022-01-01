//
//  ReviewVerbState.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

struct VerbReviewState: Equatable, Identifiable {
    let id: Int
    var alertItem: AlertItem?
    
    var learningVerb: LearningVerb
    var verbReview: VerbReview?
    
    init(id: Int, learningVerb: LearningVerb) {
        self.id = id
        self.learningVerb = learningVerb
    }
}

