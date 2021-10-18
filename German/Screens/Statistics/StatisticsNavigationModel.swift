//
//  StatisticsNavigationModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/18/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class StatisticsNavigationModel: ObservableObject {
    
    @Published var activeUserProgression: UserProgression? {
        didSet {
            print("activeUserProgression: ", String(describing: self.activeUserProgression))
        }
    }
    
    @Published var activeLearningVerb: LearningVerb? {
        didSet {
            print("activeLearningVerb: ", String(describing: self.activeLearningVerb?.id))
        }
    }
}
