//
//  VerbDetailReducer.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

let verbDetailReducer = Reducer<VerbDetailState, VerbDetailAction, ()> { state, action, environment in
    switch(action) {
    case .addToTheReviewList: // TODO: lolo
        do{
            let success = try DAO.shared.addVerbToReviewList(learningVerb: state.learningVerb)
            if success {
                SpeedLog.print("Sucessly modify all learning verb")
            }
            else{
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            SpeedLog.print(error)
        }
        return .none
        
    case let .selectNewProgressionLevel(newLevel):  // TODO: lolo
        let (newProgression, dateToReview) = UserProgression.stagnation(newLevel, reviewedDate: Date())!
        
        do{
            let userLearningVerb = LearningVerb(id: state.learningVerb.id,
                                                verb: state.learningVerb.verb,
                                                dateToReview: dateToReview,
                                                userProgression: newProgression)
            let success = try DAO.shared.update(learningVerb: userLearningVerb.toDbUserLearningVerb())
            if success {
                SpeedLog.print("Sucessly modify all learning verb")
            }
            else{
                SpeedLog.print("One verb was not found")
            }
        }
        catch{
            SpeedLog.print(error)
        }
        return .none
    }
}

