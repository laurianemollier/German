//
//  RevisionHomeState.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

public struct RevisionHomeState {
    var isLoading = false
    var alertItem: AlertItem?
    
    /// The number of verb that is on the review list of this user
    var verbInReviewListCount: Int?
    /// The number of verb that the user as to review today
    var verbToReviewTodayCount: Int? {
        didSet {
            if let count = verbToReviewTodayCount {
                self.isRevisionDisabled = count <= 0
            } else {
                self.isRevisionDisabled = false
            }
        }
    }
    var isRevisionDisabled: Bool = false
    /// Determine number of verb that the user will review in one review session
    var nbrVerbInReviewSession = 10
}
