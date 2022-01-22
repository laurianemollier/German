//
//  StatisticsState.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

import ComposableArchitecture

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
        let id: UserProgression
        var verbListState: VerbListState

        static func loading(userProgression: UserProgression) -> UserProgressionStatistics {
            UserProgressionStatistics(
                id: userProgression,
                verbListState: VerbListState.loading(userProgression: userProgression)
            )
        }
    }
}

