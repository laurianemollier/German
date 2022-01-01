//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ReviewVerbsView: View {
    
    struct State: Equatable {
        var alertItem: AlertItem?
        var isFlashcardFlipped: Bool
        var currentVerb: Verb?
        var progressionBarText: String
        
        var regressionButtonName: LocalizedStringKey
        var stagnationButtonName: LocalizedStringKey
        var progressionButtonName: LocalizedStringKey
    }
    
    public enum Action {
        case loadVerbsToReview
        case flashcardTapped
        case revealButtonTapped
        case regressButtonTapped
        case stagnateButtonTapped
        case progressButtonTapped
        case endRevisionSession
    }

    var store: Store<ReviewVerbsFeatureState, ReviewVerbsFeatureAction>
    @ObservedObject var viewStore: ViewStore<State, Action>
    
    init(store: Store<ReviewVerbsFeatureState, ReviewVerbsFeatureAction>) {
        self.store = store
        self.viewStore = ViewStore(
            self.store.scope(
                state: State.init,
                action: ReviewVerbsFeatureAction.init
            )
        )
    }
    
    var body: some View {
        VStack {
            if let currentVerb = viewStore.currentVerb {
                HStack {
                    Spacer()
                    Text(viewStore.progressionBarText).padding(.trailing, 40)
                }
                
                flashcardView(verb: currentVerb)
                
                if viewStore.isFlashcardFlipped { rateProgressionView() }
                else { flipFlashcardButton(verb: currentVerb) }
                
                HStack {
                    Spacer()
                    AudioToggleView(
                        store: self.store
                            .scope(
                                state: { $0.audioToggle },
                                action: { .audioToggle($0) }
                            )
                    )
                        .padding(.trailing, 40)
                }
                
                Spacer()
            }
            Spacer()
        }
    }
    
    
    private func flashcardView(verb: Verb) -> some View {
        FlashcardView<FrontCardView, BackCardView>(
            store: self.store
                .scope(
                    state: { $0.flashcard },
                    action: { .flashcard($0) }
                )
        ) {
            FrontCardView(verb: verb)
        } back: {
            BackCardView(verb: verb)
        }.onTapGesture {
            viewStore.send(.flashcardTapped)
        }
    }
    
    private func flipFlashcardButton(verb: Verb) -> some View {
        Button {
            viewStore.send(.revealButtonTapped)
        } label: {
            Image("RVTurnButton")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
    }
    
    private func rateProgressionView() -> some View {
        VStack {
            Text("To repeat in")
            
            HStack{
                Button { viewStore.send(.regressButtonTapped) } label: {
                    ToChangeButton(title: viewStore.regressionButtonName,
                                   backgroundColor: Color.red)
                }
                
                Button { viewStore.send(.stagnateButtonTapped) } label: {
                    ToChangeButton(
                        title: viewStore.stagnationButtonName,
                        backgroundColor: Color.orange)
                }
                
                Button { viewStore.send(.progressButtonTapped) } label: {
                    ToChangeButton(
                        title: viewStore.progressionButtonName,
                        backgroundColor: Color.green)
                }
            }
        }
    }
}

extension ReviewVerbsView.State {
    init(reviewVerbFeatureState state: ReviewVerbsFeatureState) {
        self.isFlashcardFlipped = state.flashcard.flipped
        self.progressionBarText = "\(state.index + 1)/\(state.verbCount)"
        
        if let learningVerb = state.currentLearningVerb(){
            self.currentVerb = learningVerb.verb
            self.regressionButtonName = learningVerb.userProgression.regressionName()! // TODO
            self.stagnationButtonName = learningVerb.userProgression.stagnationName()!
            self.progressionButtonName = learningVerb.userProgression.progressionName()!
        } else {
            self.alertItem = AlertContext.internalError(CustomError.IllegalState)
            self.regressionButtonName = "---"
            self.stagnationButtonName = "---"
            self.progressionButtonName = "---"
        }
    }
}

extension ReviewVerbsFeatureAction {
    init(action: ReviewVerbsView.Action) {
        switch action {
        case .loadVerbsToReview:
            self = .loadVerbsToReview
        case .flashcardTapped:
            self = .revealVerb
        case .revealButtonTapped:
            self = .revealVerb
        case .regressButtonTapped:
            self = .regressButtonTapped
        case .stagnateButtonTapped:
            self = .stagnateButtonTapped
        case .progressButtonTapped:
            self = .progressButtonTapped
        case .endRevisionSession:
            self = .endRevisionSession
        }
    }
}
