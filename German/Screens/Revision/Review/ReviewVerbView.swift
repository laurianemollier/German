//
//  ReviewView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

// https://www.pointfree.co/collections
// https://www.pointfree.co/collections/swiftui/redactions/ep116-redacted-swiftui-the-composable-architecture
// https://www.youtube.com/watch?v=oDKDGCRdSHc
// https://www.swiftbysundell.com/articles/avoiding-massive-swiftui-views/
// https://stackoverflow.com/questions/62512547/in-swiftui-in-a-foreach0-3-animate-the-tapped-button-only-not-all-3-a
struct ReviewVerbView: View /*, ReviewCardStyleViewModel */ {
    
    // TODO: lolo to make generic
    @StateObject var flashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    
    func flashcardView(verb: Verb) -> some View {
        FlashcardView<FrontCardView, BackCardView>(viewModel: flashcardViewModel) {
            FrontCardView(verb: verb)
        } back: {
            BackCardView(verb: verb)
        } onTapGestureAction: {
            try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)
        }
    }
    
    func isCurrentVerbReviewFinished() -> Bool {
        flashcardViewModel.flipped
    }
    
    func flipAllCards() {
        flashcardViewModel.flipFlashcard()
    }
    
    func resetAllCards() {
        flashcardViewModel.resetFlashcard()
    }
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    
    @StateObject var viewModel: ReviewVerbViewModel = ReviewVerbViewModel()
    @StateObject var audioToggleViewModel: AudioToggleViewModel = AudioToggleViewModel()
    
    var body: some View {
        VStack {
            if let currentVerb = viewModel.currentLearningVerb {
                HStack {
                    Spacer()
                    progressionBar
                }
                
                flashcardView(verb: currentVerb.verb)
                
                if isCurrentVerbReviewFinished() {
                    ReviewRateProgressionView(
                        audioToggleViewModel: audioToggleViewModel,
                        viewModel: viewModel
                    )
                } else {
                    flipFlashcardButton(verb: currentVerb.verb)
                }
                
                HStack {
                    Spacer()
                    AudioToggleView()
                        .padding(.trailing, 40)
                }
                
                Spacer()
            }
            Spacer()
        }
        .environmentObject(audioToggleViewModel)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {
            navigation.state = RevisionNavigationState.pickStyle
        }))
        .onAppear{onAppear()}
    }
    
    private var progressionBar: some View {
        Text("\(viewModel.index + 1)/\(viewModel.verbsToReview.count)").padding(.trailing, 40)
    }
    
    private func flipFlashcardButton(verb: Verb) -> some View {
        Button {
            flipAllCards()
            do {
                try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.all)
            }
            catch {
                SpeedLog.print(error)
            }
        } label: {
            Image("RVTurnButton")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
        }
    }
    
    private func onAppear() {
        viewModel.getVerbToReview()
        viewModel.setAction(
            onNextVerb: {
                resetAllCards()
            })
        
        viewModel.setAction(
            onEndRevisionSession: {
                audioToggleViewModel.audioStop()
                navigation.state = RevisionNavigationState.home
            })
    }
}


//struct ReviewVerbView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewVerbView()
//    }
//}
