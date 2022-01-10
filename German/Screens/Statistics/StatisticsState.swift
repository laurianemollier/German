//
//  StatisticsState.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

struct StatisticsState: Equatable {
    
    var selection: Identified<UserProgression, VerbListState>?
    
    var userProgressionStatistics: IdentifiedArrayOf<UserProgressionStatistics> = [
        .loading(userProgression: UserProgression.notSeenYet),
        .loading(userProgression: UserProgression.level1),
        .loading(userProgression: UserProgression.level2),
        .loading(userProgression: UserProgression.level3),
        .loading(userProgression: UserProgression.level4),
        .loading(userProgression: UserProgression.level5),
        .loading(userProgression: UserProgression.level6),
        .loading(userProgression: UserProgression.level7),
        .loading(userProgression: UserProgression.level8)
    ]
    
    static let loading: StatisticsState = StatisticsState()
    
    struct UserProgressionStatistics: Equatable, Identifiable {
        let id: UserProgression.ID
        let userProgression: UserProgression
        var isActivityIndicatorVisible: Bool
        var verbCount: Int
        
//        mutating func setLearningVerbs(learningVerbs: [LearningVerb]) {
//            self.isLoading = false
//            self.learningVerbs = learningVerbs
//            self.filteredLearningVerbs = learningVerbs
//        }
        
        static func loading(userProgression: UserProgression) -> UserProgressionStatistics {
            UserProgressionStatistics(
                id: userProgression.id,
                userProgression: userProgression,
                isActivityIndicatorVisible: true,
                verbCount: 0)
        }
    }
}

