//
//  LearnVerbAction.swift
//  German
//
//  Created by Lauriane Mollier on 29.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

enum LearnVerbAction {
    case infinitiveFormSeen
    case presentFormSeen
    case simplePastFormSeen
    case pastParticipleFormSeen
    case endLearnSession
    case verbUpdated(new: LearningVerb)
    case verbUpdateFailure(Error)
}
