//
//  VerbDetailAction.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

enum VerbDetailAction {
    case addVerbToTheReviewList
    case selectNewProgressionLevel(UserProgression)
    case verbUpdated(new: LearningVerb)
    case verbUpdateFailure(Error)
}
