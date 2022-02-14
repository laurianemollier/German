//
//  VerbListState.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

struct VerbListState: Equatable {
    var isLoading: Bool
    var alertItem: AlertItem?
    
    enum DetailType {
        case verbProgression
        case learnVerb
    }
    let detailType: DetailType
    let cellViewMode: VerbListCellViewMode
    
    var searchBar = SearchBarState()
    
    // if not defined, load all the verbs
    var userProgression: UserProgression?
    var selectedVerbDetail: VerbDetailState?
    var selectedLevel: Level?
    var selectedForm: Form?
    
    private(set) var learningVerbs: IdentifiedArrayOf<LearningVerb>
    var filteredLearningVerbs: [LearningVerb]
    
    mutating func setLearningVerbs(learningVerbs: [LearningVerb]) {
        self.isLoading = false
        self.learningVerbs = IdentifiedArrayOf(uniqueElements: learningVerbs)
        self.filteredLearningVerbs = learningVerbs
    }
    
    fileprivate init(detailType: DetailType, cellViewMode: VerbListCellViewMode, userProgression: UserProgression?) {
        self.isLoading = true
        self.userProgression = userProgression
        self.detailType = detailType
        self.cellViewMode = cellViewMode
        self.learningVerbs = []
        self.filteredLearningVerbs = []
    }
    
    static func loading(detailType: DetailType, userProgression: UserProgression) -> VerbListState {
        VerbListState(
            detailType: detailType,
            cellViewMode: VerbListCellViewMode.expanded, // TODO
            userProgression: userProgression
        )
    }
    
    static func loading(detailType: DetailType) -> VerbListState {
        VerbListState(
           detailType: detailType,
           cellViewMode: VerbListCellViewMode.expanded,  // TODO
           userProgression: nil
       )
    }
}
