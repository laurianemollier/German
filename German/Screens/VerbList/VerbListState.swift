//
//  VerbListState.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import Foundation

struct VerbListState: Equatable, Identifiable {
    var id: UUID = UUID.init() // TODO: Lolo should be removed
    
    var isLoading: Bool
    var alertItem: AlertItem?
    
    var searchBar = SearchBarState()
    
    // if not defined, load all the verbs
    var userProgression: UserProgression?
    var selectedVerbDetail: VerbDetailState?
    var selectedLevel: Level?
    var selectedForm: Form?
    
    private(set) var learningVerbs: [LearningVerb]
    var filteredLearningVerbs: [LearningVerb]
    
    mutating func setLearningVerbs(learningVerbs: [LearningVerb]) {
        self.isLoading = false
        self.learningVerbs = learningVerbs
        self.filteredLearningVerbs = learningVerbs
    }
    
    fileprivate init(userProgression: UserProgression?) {
        self.isLoading = true
        self.userProgression = userProgression
        self.learningVerbs = []
        self.filteredLearningVerbs = []
    }
    
    static func loading(userProgression: UserProgression) -> VerbListState {
        VerbListState(userProgression: userProgression)
    }
    
    static let loading: VerbListState = VerbListState(userProgression: nil)
}
