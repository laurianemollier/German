//
//  RevisionHomeState.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

public struct RevisionHomeState: Equatable {
    var isLoading = false
    var alertItem: AlertItem?
    
    /// The number of verb that is on the review list of this user
    var verbInReviewListCount: Int?
    /// The number of verb that the user as to review today
    var verbToReviewTodayCount: Int?
}
