//
//  VerbListReducer.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

let verbListReducer = Reducer<VerbListState, VerbListAction, ()>.combine(
    searchBarReducer.pullback(
        state: \.searchBar,
        action: /VerbListAction.searchBar,
        environment: {_ in ()}
    ),
    verbDetailReducer
        .optional()
        .pullback(
          state: \VerbListState.selectedVerbDetail,
          action: /VerbListAction.verbDetail,
          environment: {_ in ()}
        ),
    Reducer<VerbListState, VerbListAction, ()> { state, action, environment in
        
        struct CancelId: Hashable {}
        
        switch(action) {
        case .verbDetail(.verbProgression(.selectNewProgressionLevel)):
            return .none
            
        case .verbDetail(_):
            return .none
 
        case let .setLearningVerbDetail(selection: .some(selection)):
            state.selectedVerbDetail = VerbDetailState(verbProgressionDetail: selection) // TODO: lolo
            return .none
            
        case .setLearningVerbDetail(selection: .none):
            state.selectedVerbDetail = nil
            return .cancel(id: CancelId())
            
        case let .searchBar(.textChanged(text)):
            state.filteredLearningVerbs = state.learningVerbs.filter({ learningVerb in
                if state.searchBar.isSearching {
                    return learningVerb.verb.tense.infinitive.value.lowercased()
                        .contains(state.searchBar.searchText.lowercased())
                } else {
                    return true
                }
            })
            return .none
            
        case .loadState:
            state.isLoading = true
            do {
                if let progression = state.userProgression {
                    return Effect(value: .setState( try DAO.shared.select(userProgression: progression)))
                        .cancellable(id: CancelId())
                        .eraseToEffect()
                } else {
                    return Effect(value: .setState(try DAO.shared.all()))
                        .cancellable(id: CancelId())
                        .eraseToEffect()
                }
            }
            catch {
                return Effect(value: .loadStateFailure(error)).eraseToEffect()
            }
            
        case let .setState(learningVerbs):
            state.setLearningVerbs(learningVerbs: learningVerbs)
            return .none
            
        case let .loadStateFailure(error):
            state.isLoading = false
            state.alertItem = AlertContext.internalError(error)
            return .none
            
        case let .selecteLevel(level):
            state.selectedLevel = level
            state.filteredLearningVerbs = state.learningVerbs.filter({ learningVerb in
                if let selectedLevel = level {
                    return learningVerb.verb.level == selectedLevel
                } else {
                    return true
                }
            })
            return .none
            
        case let .selecteForm(form):
            state.selectedForm = form
            state.filteredLearningVerbs = state.learningVerbs.filter({ learningVerb in
                if let selectedForm = form {
                    return learningVerb.verb.form == selectedForm
                } else {
                    return true
                }
            })
            return .none
            
        }
    }
)

