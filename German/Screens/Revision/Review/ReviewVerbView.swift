//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ReviewVerbView: View {
    
    struct State: Equatable {
        var flashcard: FlashcardState = FlashcardState()
        var currentLearningVerb: LearningVerb? // TODO: should not be empty
        var progressionBarText: String
    }
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    
    var store: Store<ReviewVerbFeatureState, ReviewVerbFeatureAction>
    @ObservedObject var viewStore: ViewStore<State, ReviewVerbFeatureAction>
    
    init(store: Store<ReviewVerbFeatureState, ReviewVerbFeatureAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: State.init(reviewVerbFeatureState:)))
    }
    
    var body: some View {
        VStack {
            if let currentVerb = viewStore.currentLearningVerb {
                HStack {
                    Spacer()
                    Text(viewStore.progressionBarText).padding(.trailing, 40)
                }
                
                flashcardView(verb: currentVerb.verb)
                
                if viewStore.flashcard.flipped {
                    rateProgressionView()
                } else {
                    flipFlashcardButton(verb: currentVerb.verb)
                }
                
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
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {
            navigation.activeRevision = false
        }))
        .onAppear{
            viewStore.send(.reviewVerb(.loadVerbsToReview))
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
            viewStore.send(.flashcard(.flipFlashcard))
            viewStore.send(.audioToggle(.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)))
        }
    }
    
    private func flipFlashcardButton(verb: Verb) -> some View {
        Button {
            viewStore.send(.flashcard(.flipFlashcard))
            viewStore.send(.audioToggle(.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)))
        } label: {
            Image("RVTurnButton")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
    }
    
    private func rateProgressionView() -> some View {
        VStack {
            if let progression = viewStore.currentLearningVerb?.userProgression {
                
                Text("To repeat in")
                
                HStack{
                    Button {
                        // TODO: upper action for that ?
                        viewStore.send(.reviewVerb(.regress))
                        viewStore.send(.audioToggle(.audioStop))
                        viewStore.send(.flashcard(.resetFlashcard))
                    } label: {
                        ToChangeButton(title: progression.regressionName()!, // TODO
                                       backgroundColor: Color.red)
                    }
                    
                    Button {
                        viewStore.send(.reviewVerb(.stagnate))
                        viewStore.send(.audioToggle(.audioStop))
                        viewStore.send(.flashcard(.resetFlashcard))
                    } label: {
                        ToChangeButton(
                            title: progression.stagnationName()!, // TODO
                            backgroundColor: Color.orange)
                    }
                    
                    Button {
                        viewStore.send(.reviewVerb(.progress))
                        viewStore.send(.audioToggle(.audioStop))
                        viewStore.send(.flashcard(.resetFlashcard))
                    } label: {
                        ToChangeButton(
                            title: progression.progressionName()!, // TODO
                            backgroundColor: Color.green)
                    }
                }
            }
        }
    }
    
    //    private func onAppear() {
    //        viewModel.getVerbToReview()
    //        viewModel.setAction(
    //            onNextVerb: {
    //                 flashcardViewModel.resetFlashcard()
    //            })
    //
    //        viewModel.setAction(
    //            onEndRevisionSession: {
    //                audioToggleViewModel.audioStop()
    //                navigation.activeRevision = false
    //            })
    //    }
}

extension ReviewVerbView.State {
    init(reviewVerbFeatureState state: ReviewVerbFeatureState) {
        self.flashcard = state.flashcard
        self.currentLearningVerb = state.reviewVerb.currentLearningVerb
        self.progressionBarText = "\(state.reviewVerb.index + 1)/\(state.reviewVerb.verbsToReview.count)"
    }
}
