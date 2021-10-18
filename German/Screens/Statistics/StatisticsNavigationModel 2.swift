//
//  StatisticsNavigationModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/18/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class StatisticsNavigationModel: ObservableObject {
    
    @Published var activeUserProgression: UserProgression?
    
    @Published var activeLearningVerb: LearningVerb?

}
