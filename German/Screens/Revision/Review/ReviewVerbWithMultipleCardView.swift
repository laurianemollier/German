//
//  ReviewVerbWithMultipleCardView.swift
//  German
//
//  Created by Lauriane Mollier on 10/17/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

// https://www.pointfree.co/collections/swiftui/redactions/ep116-redacted-swiftui-the-composable-architecture
// https://www.youtube.com/watch?v=oDKDGCRdSHc
// https://www.swiftbysundell.com/articles/avoiding-massive-swiftui-views/
// https://stackoverflow.com/questions/62512547/in-swiftui-in-a-foreach0-3-animate-the-tapped-button-only-not-all-3-a
struct ReviewVerbWithMultipleCardView: View /*, ReviewCardStyleViewModel */ {
    
    // TODO: lolo to make generic
    @StateObject var infinitiveFlashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    @StateObject var presentFlashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    @StateObject var simplePastFlashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    @StateObject var pastParticipleFlashcardViewModel: FlashcardViewModel = FlashcardViewModel()
    
    func flashcardView(verb: Verb) -> some View {
        
        VStack {
            
            Text(verb.translation(Lang.en))
            
            FlashcardView<Text, Text>(viewModel: infinitiveFlashcardViewModel) {
                Text("infinitive")
            } back: {
                Text.verbTemps(verb.temps.infinitive)
            } onTapGestureAction: {
                audioToggleViewModel.audioStop()
                try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.infinitive)
            }
            
            FlashcardView<Text, Text>(viewModel: presentFlashcardViewModel) {
                Text("present")
            } back: {
                Text.verbTemps(verb.temps.present)
            } onTapGestureAction: {
                audioToggleViewModel.audioStop()
                try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.present)
            }
            
            FlashcardView<Text, Text>(viewModel: simplePastFlashcardViewModel) {
                Text("simplePast")
            } back: {
                Text.verbTemps(verb.temps.simplePast)
            } onTapGestureAction: {
                audioToggleViewModel.audioStop()
                try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.simplePast)
            }
            
            FlashcardView<Text, Text>(viewModel: pastParticipleFlashcardViewModel) {
                Text("pastParticiple")
            } back: {
                Text.verbTemps(verb.temps.pastParticiple)
            } onTapGestureAction: {
                audioToggleViewModel.audioStop()
                try audioToggleViewModel.audioPlay(verb: verb, playVerbAudio: PlayVerbAudio.pastParticiple)
            }
        }
    }
    
    func isCurrentVerbReviewFinished() -> Bool {
        infinitiveFlashcardViewModel.flipped &&
        presentFlashcardViewModel.flipped &&
        simplePastFlashcardViewModel.flipped &&
        pastParticipleFlashcardViewModel.flipped
    }
    
    func flipAllCards() {
        infinitiveFlashcardViewModel.flipFlashcard()
        presentFlashcardViewModel.flipFlashcard()
        simplePastFlashcardViewModel.flipFlashcard()
        pastParticipleFlashcardViewModel.flipFlashcard()
    }
    
    func resetAllCards() {
        infinitiveFlashcardViewModel.resetFlashcard()
        presentFlashcardViewModel.resetFlashcard()
        simplePastFlashcardViewModel.resetFlashcard()
        pastParticipleFlashcardViewModel.resetFlashcard()
    }
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @EnvironmentObject var navigation: RevisionNavigation
    
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
                navigation.state = RevisionNavigationState.home
            })
    }
}


struct ReviewVerbWithMultipleCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewVerbView()
    }
}

