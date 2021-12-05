//
//  LearnViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 12/5/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class LearnViewModel: ObservableObject {

    @Published var selectedLevel: Level? = nil
    @Published var selectedForm: Form? = nil
    @Published var learningVerbs: [LearningVerb] = []
    @Published var userProgression: UserProgression?
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    
    // if not defined, load all the verbs
    func loadData() {
        isLoading = true
        
        do {
            if let progression = userProgression {
                self.learningVerbs = try DAO.shared.select(userProgression: progression)
            } else {
                self.learningVerbs = try DAO.shared.all()
            }
            isLoading = false
        }
        catch {
            SpeedLog.print(error)
        }
    }
}

