//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

// https://stackoverflow.com/questions/62512547/in-swiftui-in-a-foreach0-3-animate-the-tapped-button-only-not-all-3-a
struct ReviewVerbView: View {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @EnvironmentObject var navigation: RevisionNavigation
    
    @StateObject var viewModel: ReviewVerbViewModel = ReviewVerbViewModel()
    @StateObject var flashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    @StateObject var audioToggleViewModel: AudioToggleViewModel = AudioToggleViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let currentVerb = viewModel.currentLearningVerb {
                    HStack {
                        Spacer()
                        progressionBar
                    }
                
                    flashcardView(verb: currentVerb.verb)
                    
                    if flashcardViewModel.flipped {
                        ReviewRateProgressionView(
                            audioToggleViewModel: audioToggleViewModel,
                            viewModel: viewModel
                        )
                    } else {
                        flipFlashcardButton(verb: currentVerb.verb)
                    }
                    
                    HStack {
                        Spacer()
                        AudioToggleView(viewModel: audioToggleViewModel)
                            .padding(.trailing, 40)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {
            navigation.state = RevisionNavigationState.pickStyle
        }))
        .onAppear{onAppear()}
    }
    
    private var progressionBar: some View {
        Text("\(viewModel.index + 1)/\(viewModel.verbsToReview.count)").padding(.trailing, 40)
    }
    
    private func flashcardView(verb: Verb) -> some View {
        FlashcardView<FrontCardView, BackCardView>(viewModel: flashcardViewModel) {
            FrontCardView(verb: verb)
        } back: {
            BackCardView(verb: verb)
        } onTapGestureAction: {
            do {
                audioToggleViewModel.audioStop()
                try audioToggleViewModel.audioPlay(verb: verb)
            }
            catch {
                SpeedLog.print(error)
            }
        }
    }
    
    private func flipFlashcardButton(verb: Verb) -> some View {
        Button {
            flashcardViewModel.flipFlashcard()
            do {try audioToggleViewModel.audioPlay(verb: verb)}
            catch {
                SpeedLog.print(error)
            }
        } label: {
            Image("RVTurnButton")
        }
    }
    
    
    private func onAppear() {
        viewModel.getVerbToReview()
        viewModel.setAction(
            onNextVerb: {
                flashcardViewModel.flipped = false
            })
        
        viewModel.setAction(
            onEndRevisionSession: {
                navigation.state = RevisionNavigationState.home
            })
    }
}

struct ReviewVerbView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVerbView()
    }
}
