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
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    
    @ObservedObject var store: Store<ReviewVerbViewState, ReviewVerbViewAction>
    
    init(store: Store<ReviewVerbViewState, ReviewVerbViewAction>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            if let currentVerb = store.value.reviewVerb.currentLearningVerb {
                HStack {
                    Spacer()
                    progressionBar
                }
                
                flashcardView(verb: currentVerb.verb)
                
                if store.value.flashcard.flipped {
                    rateProgressionView()
                } else {
                    flipFlashcardButton(verb: currentVerb.verb)
                }
                
                HStack {
                    Spacer()
                    AudioToggleView(
                        store: self.store
                            .view(
                                value: { $0.audioToggle },
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
            store.send(.reviewVerb(.loadVerbsToReview))
        }
    }
    
    private var progressionBar: some View {
        Text("\(store.value.reviewVerb.index + 1)/\(store.value.reviewVerb.verbsToReview.count)")
            .padding(.trailing, 40)
    }
    
    private func flashcardView(verb: Verb) -> some View {
        FlashcardView<FrontCardView, BackCardView>(
            store: self.store
                .view(
                    value: { $0.flashcard },
                    action: { .flashcard($0) }
                )
        ) {
            FrontCardView(verb: verb)
        } back: {
            BackCardView(verb: verb)
        }.onTapGesture {
            store.send(.flashcard(.flipFlashcard))
            store.send(.audioToggle(.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)))
        }
    }
    
    private func flipFlashcardButton(verb: Verb) -> some View {
        Button {
            store.send(.flashcard(.flipFlashcard))
            store.send(.audioToggle(.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)))
        } label: {
            Image("RVTurnButton")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
    }
    
    private func rateProgressionView() -> some View {
        VStack {
            if let progression = store.value.reviewVerb.currentLearningVerb?.userProgression {
                
                Text("To repeat in")
                
                HStack{
                    Button {
                        // TODO: upper action for that ?
                        store.send(.reviewVerb(.regress))
                        store.send(.audioToggle(.audioStop))
                        store.send(.flashcard(.resetFlashcard))
                    } label: {
                        ToChangeButton(title: progression.regressionName()!, // TODO
                                       backgroundColor: Color.red)
                    }
                    
                    Button {
                        store.send(.reviewVerb(.stagnate))
                        store.send(.audioToggle(.audioStop))
                    } label: {
                        ToChangeButton(
                            title: progression.stagnationName()!, // TODO
                            backgroundColor: Color.orange)
                    }
                    
                    Button {
                        store.send(.reviewVerb(.progress))
                        store.send(.audioToggle(.audioStop))
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
