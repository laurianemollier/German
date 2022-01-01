//
//  ReviewVerbAction.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//
import SwiftUI

enum VerbReviewAction {
    case review(VerbReview)
    case updateVerb(userProgression: UserProgression, dateToReview: Date)
}
